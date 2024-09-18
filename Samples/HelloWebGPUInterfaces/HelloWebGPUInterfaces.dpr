program HelloWebGPUInterfaces;

{$APPTYPE CONSOLE}

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Math,
  WebGPU, WebGPU.Interfaces;

const
   cWindowWidth = 800;
   cWindowHeight = 600;
   cWindowTitle = 'Hello WebGPU';
   cVertexShaderCode =
      '''
      struct VertexOutput {
        @builtin(position) position: vec4f,
        @location(0) color: vec4f,
        @location(1) uv: vec2f
      };
      @group(0) @binding(0) var<uniform> u_angle: f32;

      @vertex
      fn vs_main(@location(0) position: vec2f) -> VertexOutput {
        var output: VertexOutput;
        var cos_angle = cos(u_angle);
        var sin_angle = sin(u_angle);
        var rotation_matrix = mat2x2f(
           vec2f(cos_angle, -sin_angle),
           vec2f(sin_angle, cos_angle)
        );
        var rotated_position = rotation_matrix * position;
        output.position = vec4f(rotated_position, 0.0, 1.0);
        output.color = vec4f(1, 1, 1, 0.5 + 0.5 * cos(2 * u_angle));
        output.uv = position.xy + 0.5;
        return output;
      };
      ''';
   cFragmentShaderCode =
      '''
      struct VertexOutput {
        @builtin(position) position: vec4f,
        @location(0) color: vec4f,
        @location(1) uv: vec2f
      };

      @group(0) @binding(1) var t_test: texture_2d<f32>;
      @group(0) @binding(2) var t_sampler: sampler;

      @fragment
      fn fs_main(in: VertexOutput) -> @location(0) vec4f {
         var aliasedColor = textureLoad(t_test, vec2i(in.uv * vec2f(textureDimensions(t_test))), 0);
         var filteredColor = textureSample(t_test, t_sampler, in.uv);
         return filteredColor * in.color.a + aliasedColor * (1 - in.color.a);
      }
      ''';

var
   vInstance: IWGPUInstance;
   vSurface: IWGPUSurface;
   vAdapter: IWGPUAdapter;
   vDevice: IWGPUDevice;
   vQueue: IWGPUQueue;
   vRenderPipeline: IWGPURenderPipeline;
   vVertexBuffer: IWGPUBuffer;
   vUniformBuffer: IWGPUBuffer;
   vBindGroup: IWGPUBindGroup;
   vTexture: IWGPUTexture;
   vTextureView: IWGPUTextureView;
   vSampler: IWGPUSampler;

   vWindowHandle: HWND;
   vWindowClass: TWndClass;

   Vertices: array [0..7] of Single = (
      -0.5, -0.5,
       0.5, -0.5,
      -0.5,  0.5,
       0.5,  0.5
   );

function WindowProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  case uMsg of
    WM_DESTROY: begin
        PostQuitMessage(0);
        Result := 0;
        Exit;
    end;
  end;
  Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
end;

procedure InitializeWindow;
begin
   vWindowClass.style := CS_HREDRAW or CS_VREDRAW;
   vWindowClass.lpfnWndProc := @WindowProc;
   vWindowClass.hInstance := HInstance;
   vWindowClass.hCursor := LoadCursor(0, IDC_ARROW);
   vWindowClass.lpszClassName := 'WebGPUWindowClass';
   RegisterClass(vWindowClass);

   vWindowHandle := CreateWindow(
      'WebGPUWindowClass',
      cWindowTitle,
      WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, CW_USEDEFAULT,
      cWindowWidth, cWindowHeight,
      0, 0, HInstance, nil
   );

   ShowWindow(vWindowHandle, SW_SHOW);
   UpdateWindow(vWindowHandle);
end;

procedure UncapturedErrorCallback(
   const device: PWGPUDevice;
   &type: TWGPUErrorType; const &message: PUTF8Char;
   userdata1: Pointer; userdata2: Pointer
   ); cdecl;
begin
   if &message <> nil then
      Writeln(Ord(&type).ToHexString, ' ', &message);
end;

procedure CompilationCallback(
   status: TWGPUCompilationInfoRequestStatus;
   const compilationInfo: PWGPUCompilationInfo; userdata1, userdata2: Pointer
   ); cdecl;
begin
   if compilationInfo.messageCount = 0 then Exit;

   Writeln('Compilation ', PChar(userData1), ' ', Ord(status));
   var p := compilationInfo.messages;
   for var i := 1 to compilationInfo.messageCount do begin
      Writeln('Line ', p.lineNum, ':', p.linePos, ' ', p.message);
      Inc(p);
   end;
end;

procedure PipelineInfoCallback(
   status: TWGPUCreatePipelineAsyncStatus;
   pipeline: TWGPURenderPipeline; const &message: PUTF8Char;
   userdata1: Pointer; userdata2: Pointer
   ); cdecl;
begin
   Writeln('Pipeline ', &message);
end;

procedure DeviceCallback(status: TWGPURequestDeviceStatus; const device: TWGPUDevice; const &message: PUTF8Char; userdata: Pointer); cdecl;
begin
   if status <> WGPURequestDeviceStatus_Success then
      Writeln(Ord(status), &message);
   vDevice := WGPUFactory.WrapDevice(device);
end;

procedure AdapterCallback(status: TWGPURequestAdapterStatus; adapter: TWGPUAdapter; const &message: PUTF8Char; userdata: Pointer); cdecl;
begin
   if status <> WGPURequestAdapterStatus_Success then
      Writeln(Ord(status), &message);
   vAdapter := WGPUFactory.WrapAdapter(adapter);
end;

procedure InitializeWebGPU;
begin
   // Create vInstance
   var instanceDescriptor := Default(TWGPUInstanceDescriptor);
   vInstance := WGPUFactory.CreateInstance(instanceDescriptor);

   // Request adapter
   var adapterOptions := Default(TWGPURequestAdapterOptions);
   vInstance.RequestAdapter(adapterOptions, @AdapterCallback, nil);
   Assert(vAdapter <> nil);

   // Request device
   var requiredLimits := Default(TWGPURequiredLimits);
   requiredLimits.limits.maxBindGroups := 1;
   requiredLimits.limits.maxUniformBuffersPerShaderStage := 1;
   requiredLimits.limits.maxUniformBufferBindingSize := 16 * 4;
   requiredLimits.limits.minUniformBufferOffsetAlignment := 256;
   requiredLimits.limits.minStorageBufferOffsetAlignment := 256;
   requiredLimits.limits.maxSampledTexturesPerShaderStage := 1;
   requiredLimits.limits.maxSamplersPerShaderStage := 1;

   var deviceDescriptor := Default(TWGPUDeviceDescriptor);
   deviceDescriptor.&label := 'WebGPU Device';
   deviceDescriptor.requiredLimits := @requiredLimits;
   deviceDescriptor.uncapturedErrorCallbackInfo2.callback := @UncapturedErrorCallback;
   var featuresArray : array of TWGPUFeatureName := [
      WGPUFeatureName_TimestampQuery
      // , WGPUFeatureName_ChromiumExperimentalTimestampQueryInsidePasses
   ];
   deviceDescriptor.requiredFeatureCount := Length(featuresArray);
   deviceDescriptor.requiredFeatures := Pointer(featuresArray);
   vAdapter.RequestDevice(deviceDescriptor, @DeviceCallback, nil);
   Assert(vDevice <> nil);

   // Create vSurface

   var fromWindowsHWND := Default(TWGPUSurfaceSourceWindowsHWND);
   fromWindowsHWND.chain.next := nil;
   fromWindowsHWND.chain.sType := WGPUSType_SurfaceSourceWindowsHWND;
   fromWindowsHWND.hinstance := Pointer(HInstance);
   fromWindowsHWND.hwnd := Pointer(vWindowHandle);

   var surfaceDescriptor := Default(TWGPUSurfaceDescriptor);
   surfaceDescriptor.&label := nil;
   surfaceDescriptor.nextInChain := @fromWindowsHWND;

   vSurface := vInstance.CreateSurface(surfaceDescriptor);
   Assert(vSurface <> nil);

   // Configure canvas context
   var surfaceConfiguration := Default(TWGPUSurfaceConfiguration);
   surfaceConfiguration.nextInChain := nil;
   surfaceConfiguration.device := vDevice.GetHandle;
   surfaceConfiguration.format := WGPUTextureFormat_BGRA8Unorm;
   surfaceConfiguration.usage := WGPUTextureUsage_RenderAttachment;
   surfaceConfiguration.alphaMode := WGPUCompositeAlphaMode_Auto;
   surfaceConfiguration.viewFormats := nil;
   surfaceConfiguration.viewFormatCount := 0;
   surfaceConfiguration.width := cWindowWidth;
   surfaceConfiguration.height := cWindowHeight;
   surfaceConfiguration.presentMode := WGPUPresentMode_Mailbox;

   vSurface.Configure(surfaceConfiguration);

   // Get vQueue
   vQueue := vDevice.GetQueue;
end;

procedure CreateRenderPipeline;
var
   vertexAttributes: array[0..1] of TWGPUVertexAttribute;
begin
   // Create shader modules
   var vertexSource := Default(TWGPUShaderSourceWGSL);
   vertexSource.chain.sType := WGPUSType_ShaderSourceWGSL;
   vertexSource.code := PUTF8Char(cVertexShaderCode);

   var shaderModuleDescriptor := Default(TWGPUShaderModuleDescriptor);
   shaderModuleDescriptor.&label := 'Vertex Shader';
   shaderModuleDescriptor.nextInChain := @vertexSource;

   var vertexModule := vDevice.CreateShaderModule(shaderModuleDescriptor);
   Assert(vertexModule <> nil);

   var compilationInfoCallbackInfo2 := Default(TWGPUCompilationInfoCallbackInfo2);
   compilationInfoCallbackInfo2.mode := WGPUCallbackMode_AllowSpontaneous;
   compilationInfoCallbackInfo2.callback := @CompilationCallback;
   compilationInfoCallbackInfo2.userdata1 := PChar('Vertex Shader');
   vertexModule.GetCompilationInfo2(compilationInfoCallbackInfo2);

   var fragmentSource := Default(TWGPUShaderSourceWGSL);
   fragmentSource.chain.sType := WGPUSType_ShaderSourceWGSL;
   fragmentSource.code := PUTF8Char(cFragmentShaderCode);

   shaderModuleDescriptor.&label := 'Fragment Shader';
   shaderModuleDescriptor.nextInChain := @fragmentSource;

   var fragmentModule := vDevice.CreateShaderModule(shaderModuleDescriptor);
   Assert(fragmentModule <> nil);

   compilationInfoCallbackInfo2.userdata1 := PChar('Fragment Shader');
   fragmentModule.GetCompilationInfo2(compilationInfoCallbackInfo2);

   // Create a sampler for the texture
   var samplerDescriptor := Default(TWGPUSamplerDescriptor);
   samplerDescriptor.addressModeU := WGPUAddressMode_ClampToEdge;
   samplerDescriptor.addressModeV := WGPUAddressMode_ClampToEdge;
   samplerDescriptor.addressModeW := WGPUAddressMode_ClampToEdge;
   samplerDescriptor.magFilter := WGPUFilterMode_Linear;
   samplerDescriptor.minFilter := WGPUFilterMode_Linear;
   samplerDescriptor.mipmapFilter := WGPUMipmapFilterMode_Linear;
   samplerDescriptor.lodMinClamp := 0;
   samplerDescriptor.lodMaxClamp := 1;
   samplerDescriptor.maxAnisotropy := 1;
   vSampler := vDevice.CreateSampler(samplerDescriptor);

   // bind group layout arrays
   var bindGroupLayoutEntries : array [0..2] of TWGPUBindGroupLayoutEntry;
   FillChar(bindGroupLayoutEntries, SizeOf(bindGroupLayoutEntries), 0);

   // our vertex shader uniform
   var bindGroupLayoutEntry_vs : PWGPUBindGroupLayoutEntry := @bindGroupLayoutEntries[0];
   bindGroupLayoutEntry_vs.binding := 0; // slot 0
   bindGroupLayoutEntry_vs.buffer.&type := WGPUBufferBindingType_Uniform;
   bindGroupLayoutEntry_vs.buffer.minBindingSize := SizeOf(Single);
   bindGroupLayoutEntry_vs.visibility := WGPUShaderStage_Vertex;

   // our fragment shader texture
   var bindGroupLayoutEntry_ps : PWGPUBindGroupLayoutEntry := @bindGroupLayoutEntries[1];
   bindGroupLayoutEntry_ps.binding := 1; // slot 1
   bindGroupLayoutEntry_ps.visibility := WGPUShaderStage_Fragment;
   bindGroupLayoutEntry_ps.texture.sampleType := WGPUTextureSampleType_Float;
   bindGroupLayoutEntry_ps.texture.viewDimension := WGPUTextureViewDimension_2D;

   // our fragment shader sampler
   var bindGroupLayoutEntry_sa : PWGPUBindGroupLayoutEntry := @bindGroupLayoutEntries[2];
   bindGroupLayoutEntry_sa.binding := 2; // slot 2
   bindGroupLayoutEntry_sa.visibility := WGPUShaderStage_Fragment;
   bindGroupLayoutEntry_sa.sampler.&type := WGPUSamplerBindingType_Filtering;

   var bindGroupLayoutDescriptor := Default(TWGPUBindGroupLayoutDescriptor);
   bindGroupLayoutDescriptor.entryCount := Length(bindGroupLayoutEntries);
   bindGroupLayoutDescriptor.entries := @bindGroupLayoutEntries;
   var bindGroupLayout := vDevice.CreateBindGroupLayout(bindGroupLayoutDescriptor);
   Assert(bindGroupLayout <> nil);

   // Create pipeline layout
   var bindGroupLayouts : array [0..0] of TWGPUBindGroupLayout;
   bindGroupLayouts[0] := bindGroupLayout.GetHandle;
   var pipelineLayoutDescriptor := Default(TWGPUPipelineLayoutDescriptor);
   pipelineLayoutDescriptor.&label := 'Pipeline Layout';
   pipelineLayoutDescriptor.bindGroupLayoutCount := Length(bindGroupLayouts);
   pipelineLayoutDescriptor.bindGroupLayouts := @bindGroupLayouts;
   var pipelineLayout := vDevice.CreatePipelineLayout(pipelineLayoutDescriptor);
   Assert(pipelineLayout <> nil);

   // Configure vertex state
   var vertexBufferLayout := Default(TWGPUVertexBufferLayout);
   vertexBufferLayout.arrayStride := 2 * SizeOf(Single);
   vertexBufferLayout.stepMode := WGPUVertexStepMode_Vertex;
   vertexBufferLayout.attributeCount := 1;
   vertexBufferLayout.attributes := @vertexAttributes;

   vertexAttributes[0].format := WGPUVertexFormat_Float32x2;
   vertexAttributes[0].offset := 0;
   vertexAttributes[0].shaderLocation := 0;

   var vertexState := Default(TWGPUVertexState);
   vertexState.module := vertexModule.GetHandle;
   vertexState.entryPoint := 'vs_main';
   vertexState.bufferCount := 1;
   vertexState.buffers := @vertexBufferLayout;

   // Configure fragment state
   var blendState := Default(TWGPUBlendState);
   blendState.color.srcFactor := WGPUBlendFactor_SrcAlpha;
   blendState.color.dstFactor := WGPUBlendFactor_OneMinusSrcAlpha;
   blendState.color.operation := WGPUBlendOperation_Add;
   blendState.alpha.srcFactor := WGPUBlendFactor_Zero;
   blendState.alpha.dstFactor := WGPUBlendFactor_One;
   blendState.alpha.operation := WGPUBlendOperation_Add;

   var colorTargetState := Default(TWGPUColorTargetState);
   colorTargetState.format := WGPUTextureFormat_BGRA8Unorm;
   colorTargetState.writeMask := WGPUColorWriteMask_All;
   colorTargetState.blend := @blendState;

   var fragmentState := Default(TWGPUFragmentState);
   fragmentState.module := fragmentModule.GetHandle;
   fragmentState.entryPoint := 'fs_main';
   fragmentState.targetCount := 1;
   fragmentState.targets := @colorTargetState;

   // Create render pipeline
   var pipelineDescriptor := Default(TWGPURenderPipelineDescriptor);
   pipelineDescriptor.&label := 'Render Pipeline';
   pipelineDescriptor.layout := pipelineLayout.GetHandle;
   pipelineDescriptor.vertex := vertexState;
   pipelineDescriptor.fragment := @fragmentState;
   pipelineDescriptor.primitive.topology := WGPUPrimitiveTopology_TriangleStrip;
   pipelineDescriptor.primitive.stripIndexFormat := WGPUIndexFormat_Undefined;
   pipelineDescriptor.primitive.frontFace := WGPUFrontFace_CCW;
   pipelineDescriptor.primitive.cullMode := WGPUCullMode_None;
   pipelineDescriptor.multisample.count := 1;
   pipelineDescriptor.multisample.mask := UInt32(-1);

   vRenderPipeline := vDevice.CreateRenderPipeline(pipelineDescriptor);
   Assert(vRenderPipeline <> nil);

   // Create the bind group
   var bindGroupEntries : array [0..2] of TWGPUBindGroupEntry;
   FillChar(bindGroupEntries, SizeOf(bindGroupEntries), 0);

   bindGroupEntries[0].binding := 0;
   bindGroupEntries[0].buffer := vUniformBuffer.GetHandle;
   bindGroupEntries[0].size := SizeOf(Single);

   bindGroupEntries[1].binding := 1;
   bindGroupEntries[1].textureView := vTextureView.GetHandle;

   bindGroupEntries[2].binding := 2;
   bindGroupEntries[2].sampler := vSampler.GetHandle;

   var bindGroupDescriptor := Default(TWGPUBindGroupDescriptor);
   bindGroupDescriptor.layout := bindGroupLayout.GetHandle;
   bindGroupDescriptor.entryCount := Length(bindGroupEntries);
   bindGroupDescriptor.entries := @bindGroupEntries;
   vBindGroup := vDevice.CreateBindGroup(bindGroupDescriptor);
   Assert(vBindGroup <> nil);
end;

procedure CreateBuffers;
begin
   // Create vertex buffer
   var vertexBufferDescriptor := Default(TWGPUBufferDescriptor);
   vertexBufferDescriptor.&label := 'Vertex Buffer';
   vertexBufferDescriptor.usage := WGPUBufferUsage_Vertex or WGPUBufferUsage_CopyDst;
   vertexBufferDescriptor.size := SizeOf(Vertices);
   vVertexBuffer := vDevice.CreateBuffer(vertexBufferDescriptor);
   Assert(vVertexBuffer <> nil);

   vQueue.WriteBuffer(vVertexBuffer, 0, @Vertices, SizeOf(Vertices));

   // Create uniform buffer
   var uniformBufferDescriptor := Default(TWGPUBufferDescriptor);
   uniformBufferDescriptor.usage := WGPUBufferUsage_Uniform or WGPUBufferUsage_CopyDst;
   uniformBufferDescriptor.size := SizeOf(Single);
   vUniformBuffer := vDevice.CreateBuffer(uniformBufferDescriptor);
   Assert(vUniformBuffer <> nil);
end;

procedure CreateTexture;
type
   TColorRec = record
      R, G, B, A : Byte;
   end;
const
   cPixels : array [ 0 .. 11 ] of TColorRec = (
      ( R: 255; G: 255; B:   0; A: 255 ),   ( R: 0; G: 255; B:   0; A: 255 ), ( R: 0; G: 255; B: 255; A: 255 ),
      ( R: 255; G:   0; B:   0; A: 255 ),   ( R: 0; G: 255; B:   0; A:   0 ), ( R: 0; G:   0; B: 255; A: 255 ),
      ( R: 255; G:   0; B:   0; A: 255 ),   ( R: 0; G: 255; B:   0; A:   0 ), ( R: 0; G:   0; B: 255; A: 255 ),
      ( R: 255; G: 255; B:   0; A: 255 ),   ( R: 0; G: 255; B:   0; A: 255 ), ( R: 0; G: 255; B: 255; A: 255 )
   );
begin
   // Create texture
   var textureDescriptor := Default(TWGPUTextureDescriptor);
   textureDescriptor.usage := WGPUTextureUsage_TextureBinding or WGPUTextureUsage_CopyDst;
   textureDescriptor.dimension := WGPUTextureDimension_2D;
   textureDescriptor.size.width := 3;
   textureDescriptor.size.height := 4;
   textureDescriptor.size.depthOrArrayLayers := 1;
   textureDescriptor.format := WGPUTextureFormat_RGBA8Unorm;
   textureDescriptor.mipLevelCount := 1;
   textureDescriptor.sampleCount := 1;
   vTexture := vDevice.CreateTexture(textureDescriptor);
   Assert(vTexture <> nil);

   var destination := Default(TWGPUImageCopyTexture);
   destination.texture := vTexture.GetHandle;
   destination.mipLevel := 0;
   destination.aspect := WGPUTextureAspect_All;

   var source := Default(TWGPUTextureDataLayout);
   source.bytesPerRow := SizeOf(TColorRec) * textureDescriptor.size.width;
   source.rowsPerImage := textureDescriptor.size.height;

   vQueue.WriteTexture(
      @destination, @cPixels, SizeOf(cPixels),
      @source, @textureDescriptor.size
   );

   // Create the texture view
   var textureViewDescriptor := Default(TWGPUTextureViewDescriptor);
   textureViewDescriptor.format := textureDescriptor.format;
   textureViewDescriptor.dimension := WGPUTextureViewDimension_2D;
   textureViewDescriptor.baseMipLevel := 0;
   textureViewDescriptor.mipLevelCount := 1;
   textureViewDescriptor.baseArrayLayer := 0;
   textureViewDescriptor.arrayLayerCount := 1;
   textureViewDescriptor.aspect := WGPUTextureAspect_All;
   vTextureView := vTexture.CreateView(textureViewDescriptor);
   Assert(vTextureView <> nil);
end;

procedure Render;
begin
   var surfaceTexture := vSurface.GetCurrentTexture;

   var viewDescriptor := Default(TWGPUTextureViewDescriptor);
   viewDescriptor.nextInChain := nil;
   viewDescriptor.&label := 'Surface texture view';
   viewDescriptor.format := surfaceTexture.GetFormat;
   viewDescriptor.dimension := WGPUTextureViewDimension_2D;
   viewDescriptor.baseMipLevel := 0;
   viewDescriptor.mipLevelCount := 1;
   viewDescriptor.baseArrayLayer := 0;
   viewDescriptor.arrayLayerCount := 1;
   viewDescriptor.aspect := WGPUTextureAspect_All;
   var targetView := surfaceTexture.CreateView(viewDescriptor);

   var commandEncoderDescriptor := Default(TWGPUCommandEncoderDescriptor);
   commandEncoderDescriptor.&label := 'Command Encoder';
   var commandEncoder := vDevice.CreateCommandEncoder(commandEncoderDescriptor);
   Assert(commandEncoder <> nil);

   var renderPassColorAttachment := Default(TWGPURenderPassColorAttachment);
   renderPassColorAttachment.view := targetView.GetHandle;
   renderPassColorAttachment.loadOp := WGPULoadOp_Clear;
   renderPassColorAttachment.storeOp := WGPUStoreOp_Store;
   renderPassColorAttachment.clearValue.r := 0.1;
   renderPassColorAttachment.clearValue.g := 0.1;
   renderPassColorAttachment.clearValue.b := 0.1;
   renderPassColorAttachment.clearValue.a := 1.0;
   renderPassColorAttachment.depthSlice := WGPU_DEPTH_SLICE_UNDEFINED;

   var renderPassDescriptor := Default(TWGPURenderPassDescriptor);
   renderPassDescriptor.colorAttachmentCount := 1;
   renderPassDescriptor.colorAttachments := @renderPassColorAttachment;

   var renderPassEncoder := commandEncoder.BeginRenderPass(renderPassDescriptor);

   renderPassEncoder.SetPipeline(vRenderPipeline);
   renderPassEncoder.SetVertexBuffer(0, vVertexBuffer, 0, SizeOf(Vertices));
   renderPassEncoder.SetBindGroup(0, vBindGroup, 0, nil);
   renderPassEncoder.Draw(4, 1, 0, 0);

   renderPassEncoder.&End;

   var commandBuffer := commandEncoder.Finish(nil);
   Assert(commandBuffer <> nil);

   var angle : Single := Frac(Now) * 86400 * PI / 4; // PI/4 per second
   vQueue.WriteBuffer(vUniformBuffer, 0, @angle, SizeOf(angle));

   vQueue.Submit(commandBuffer);

   vSurface.Present;
   vInstance.ProcessEvents;
end;

procedure MainLoop;
var
   msg : TMsg;
   startTime, currentTime, totalTime : DWORD;
   frameCount : Integer;
   windowTitle : String;
begin
   startTime := GetTickCount;
   frameCount := 0;

   while True do begin
      // PeekMessage checks if there are any messages in the queue
      if PeekMessage(msg, 0, 0, 0, PM_REMOVE) then begin
         // If a message is retrieved, process it
         if msg.message = WM_QUIT then
            Break;  // Exit the loop if it's a quit message

         TranslateMessage(msg);
         DispatchMessage(msg);
      end;

      Render;

      currentTime := GetTickCount;
      totalTime := currentTime - startTime;
      Inc(frameCount);

      // Calculate the average FPS every second (or after a certain number of frames)
      if totalTime >= 1000 then begin // Update every second (1000 ms)
         var averageFPS := frameCount * 1000 / totalTime;

         // Set window title with the average FPS
         windowTitle := cWindowTitle +  Format(' - %.2f FPS', [averageFPS]);
         SetWindowText(vWindowHandle, PChar(windowTitle));

         startTime := currentTime;
         frameCount := 0;
      end;
   end;
end;

begin
   try
      Load_webgpu_Library('webgpu_dawn.dll');
      InitializeWindow;
      InitializeWebGPU;
      CreateBuffers;
      CreateTexture;
      CreateRenderPipeline;
      MainLoop;
   except
      on E: Exception do
         Writeln(E.ClassName, ': ', E.Message);
   end;
end.
