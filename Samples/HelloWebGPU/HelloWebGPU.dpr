program SimpleWebGPUDraw;

{$APPTYPE CONSOLE}

uses
   Winapi.Windows, Winapi.Messages,
   System.SysUtils, System.Math,
   webgpu;

const
   cWindowWidth = 800;
   cWindowHeight = 600;
   cWindowTitle = 'WebGPU Pond in a Field';
   cVertexShaderCode =
      '''
      struct VertexOutput {
        @builtin(position) position: vec4f,
        @location(0) color: vec4f
      };
      @vertex
      fn vs_main(@location(0) position: vec2f) -> VertexOutput {
        var output: VertexOutput;
        output.position = vec4f(position, 0.0, 1.0);
        output.color = vec4f(0, 0, 1, 1);
        return output;
      };
      ''';
   cFragmentShaderCode =
      '''
      @fragment
      fn fs_main(@location(0) color: vec4f) -> @location(0) vec4f {
        return color;
      }
      ''';

var
   vInstance: WGPUInstance;
   vSurface: WGPUSurface;
   vAdapter: WGPUAdapter;
   vDevice: WGPUDevice;
   vQueue: WGPUQueue;
   vSwapChain: WGPUSwapChain;
   vRenderPipeline: WGPURenderPipeline;
   vVertexBuffer: WGPUBuffer;
   vUniformBuffer: WGPUBuffer;
   vBindGroup: WGPUBindGroup;

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

procedure DeviceCallback(status: WGPURequestDeviceStatus; device: WGPUDevice; const &message: PUTF8Char; userdata: Pointer); cdecl;
begin
   vDevice := device;
   if status <> WGPURequestDeviceStatus_Success then
      Writeln(Ord(status), &message);
end;

procedure AdapterCallback(status: WGPURequestAdapterStatus; adapter: WGPUAdapter; const &message: PUTF8Char; userdata: Pointer); cdecl;
begin
   vAdapter := adapter;
   if status <> WGPURequestAdapterStatus_Success then
      Writeln(Ord(status), &message);
end;

procedure InitializeWebGPU;
begin
   // Create vInstance
   var InstanceDescriptor := Default(WGPUInstanceDescriptor);
   vInstance := wgpuCreateInstance(@InstanceDescriptor);
   Assert(vInstance <> nil);

   // Request adapter
   var adapterOptions := Default(WGPURequestAdapterOptions);
   wgpuInstanceRequestAdapter(vInstance, @adapterOptions, @AdapterCallback, nil);
   Assert(vAdapter <> nil);

   // Request device
   var deviceDescriptor := Default(WGPUDeviceDescriptor);
   deviceDescriptor.&label := 'WebGPU Device';
   wgpuAdapterRequestDevice(vAdapter, @deviceDescriptor, @DeviceCallback, nil);
   Assert(vDevice <> nil);

   // Create vSurface

   var fromWindowsHWND := Default(WGPUSurfaceSourceWindowsHWND);
   fromWindowsHWND.chain.next := nil;
   fromWindowsHWND.chain.sType := WGPUSType_SurfaceSourceWindowsHWND;
   fromWindowsHWND.hinstance := Pointer(HInstance);
   fromWindowsHWND.hwnd := Pointer(vWindowHandle);

   var surfaceDescriptor := Default(WGPUSurfaceDescriptor);
   surfaceDescriptor.&label := nil;
   surfaceDescriptor.nextInChain := @fromWindowsHWND;

   vSurface := wgpuInstanceCreateSurface(vInstance, @surfaceDescriptor);
   Assert(vSurface <> nil);

   // Configure canvas context
   var surfaceConfiguration := Default(WGPUSurfaceConfiguration);
   surfaceConfiguration.nextInChain := nil;
   surfaceConfiguration.device := vDevice;
   surfaceConfiguration.format := WGPUTextureFormat_BGRA8Unorm;
   surfaceConfiguration.usage := WGPUTextureUsage_RenderAttachment;
   surfaceConfiguration.alphaMode := WGPUCompositeAlphaMode_Auto;
   surfaceConfiguration.viewFormats := nil;
   surfaceConfiguration.viewFormatCount := 0;
   surfaceConfiguration.width := cWindowWidth;
   surfaceConfiguration.height := cWindowHeight;
   surfaceConfiguration.presentMode := WGPUPresentMode_Fifo;

   wgpuSurfaceConfigure(vSurface, @surfaceConfiguration);

   // Get vQueue
   vQueue := wgpuDeviceGetQueue(vDevice);
end;

procedure CreateRenderPipeline;
var
   vertexAttributes: array[0..1] of WGPUVertexAttribute;
begin
   // Create shader modules
   var vertexSource := Default(WGPUShaderSourceWGSL);
   vertexSource.chain.sType := WGPUSType_ShaderSourceWGSL;
   vertexSource.code := PUTF8Char(cVertexShaderCode);

   var shaderModuleDescriptor := Default(WGPUShaderModuleDescriptor);
   shaderModuleDescriptor.&label := 'Vertex Shader';
   shaderModuleDescriptor.nextInChain := @vertexSource;

   var vertexModule := wgpuDeviceCreateShaderModule(vDevice, @shaderModuleDescriptor);
   Assert(vertexModule <> nil);

   var fragmentSource := Default(WGPUShaderSourceWGSL);
   fragmentSource.chain.sType := WGPUSType_ShaderSourceWGSL;
   fragmentSource.code := PUTF8Char(cFragmentShaderCode);

   shaderModuleDescriptor.&label := 'Fragment Shader';
   shaderModuleDescriptor.nextInChain := @fragmentSource;

   var fragmentModule := wgpuDeviceCreateShaderModule(vDevice, @shaderModuleDescriptor);
   Assert(fragmentModule <> nil);

   // Create pipeline layout
   var pipelineLayoutDescriptor := Default(WGPUPipelineLayoutDescriptor);
   pipelineLayoutDescriptor.&label := 'Pipeline Layout';
   var pipelineLayout := wgpuDeviceCreatePipelineLayout(vDevice, @pipelineLayoutDescriptor);
   Assert(pipelineLayout <> nil);

   // Configure vertex state
   var vertexBufferLayout := Default(WGPUVertexBufferLayout);
   vertexBufferLayout.arrayStride := 2 * SizeOf(Single);
   vertexBufferLayout.stepMode := WGPUVertexStepMode_Vertex;
   vertexBufferLayout.attributeCount := 1;
   vertexBufferLayout.attributes := @vertexAttributes;

   vertexAttributes[0].format := WGPUVertexFormat_Float32x2;
   vertexAttributes[0].offset := 0;
   vertexAttributes[0].shaderLocation := 0;

//   vertexAttributes[1].format := WGPUVertexFormat_Float32x4;
//   vertexAttributes[1].offset := 2 * SizeOf(Single);
//   vertexAttributes[1].shaderLocation := 1;

   var vertexState := Default(WGPUVertexState);
   vertexState.module := vertexModule;
   vertexState.entryPoint := 'vs_main';
   vertexState.bufferCount := 1;
   vertexState.buffers := @vertexBufferLayout;

   // Configure fragment state
   var blendState := Default(WGPUBlendState);
   blendState.color.srcFactor := WGPUBlendFactor_SrcAlpha;
   blendState.color.dstFactor := WGPUBlendFactor_OneMinusSrcAlpha;
   blendState.color.operation := WGPUBlendOperation_Add;
   blendState.alpha.srcFactor := WGPUBlendFactor_Zero;
   blendState.alpha.dstFactor := WGPUBlendFactor_One;
   blendState.alpha.operation := WGPUBlendOperation_Add;

   var colorTargetState := Default(WGPUColorTargetState);
   colorTargetState.format := WGPUTextureFormat_BGRA8Unorm;
   colorTargetState.writeMask := WGPUColorWriteMask_All;
   colorTargetState.blend := @blendState;

   var fragmentState := Default(WGPUFragmentState);
   fragmentState.module := fragmentModule;
   fragmentState.entryPoint := 'fs_main';
   fragmentState.targetCount := 1;
   fragmentState.targets := @colorTargetState;

   // Create render pipeline
   var pipelineDescriptor := Default(WGPURenderPipelineDescriptor);
   pipelineDescriptor.&label := 'Render Pipeline';
   pipelineDescriptor.layout := pipelineLayout;
   pipelineDescriptor.vertex := vertexState;
   pipelineDescriptor.fragment := @fragmentState;
   pipelineDescriptor.primitive.topology := WGPUPrimitiveTopology_TriangleStrip;
   pipelineDescriptor.primitive.stripIndexFormat := WGPUIndexFormat_Undefined;
   pipelineDescriptor.primitive.frontFace := WGPUFrontFace_CCW;
   pipelineDescriptor.primitive.cullMode := WGPUCullMode_None;
   pipelineDescriptor.multisample.count := 1;
   pipelineDescriptor.multisample.mask := UInt32(-1);

   vRenderPipeline := wgpuDeviceCreateRenderPipeline(vDevice, @pipelineDescriptor);
   Assert(vRenderPipeline <> nil);

   wgpuShaderModuleRelease(vertexModule);
   wgpuShaderModuleRelease(fragmentModule);
   wgpuPipelineLayoutRelease(pipelineLayout);
end;

procedure CreateBuffers;
begin
   // Create vertex buffer
   var vertexBufferDescriptor := Default(WGPUBufferDescriptor);
   vertexBufferDescriptor.&label := 'Vertex Buffer';
   vertexBufferDescriptor.usage := WGPUBufferUsage_Vertex or WGPUBufferUsage_CopyDst;
   vertexBufferDescriptor.size := SizeOf(Vertices);
   vVertexBuffer := wgpuDeviceCreateBuffer(vDevice, @vertexBufferDescriptor);
   Assert(vVertexBuffer <> nil);

   wgpuQueueWriteBuffer(vQueue, vVertexBuffer, 0, @Vertices, SizeOf(Vertices));
end;

procedure Render;
begin
   var surfaceTexture := Default(WGPUSurfaceTexture);
   wgpuSurfaceGetCurrentTexture(vSurface, @surfaceTexture);
   Assert(surfaceTexture.status = WGPUSurfaceGetCurrentTextureStatus_Success);

   var viewDescriptor := Default(WGPUTextureViewDescriptor);
   viewDescriptor.nextInChain := nil;
   viewDescriptor.&label := 'Surface texture view';
   viewDescriptor.format := wgpuTextureGetFormat(surfaceTexture.texture);
   viewDescriptor.dimension := WGPUTextureViewDimension_2D;
   viewDescriptor.baseMipLevel := 0;
   viewDescriptor.mipLevelCount := 1;
   viewDescriptor.baseArrayLayer := 0;
   viewDescriptor.arrayLayerCount := 1;
   viewDescriptor.aspect := WGPUTextureAspect_All;
   var targetView := wgpuTextureCreateView(surfaceTexture.texture, @viewDescriptor);
   Assert(targetView <> nil);

   var commandEncoderDescriptor := Default(WGPUCommandEncoderDescriptor);
   commandEncoderDescriptor.&label := 'Command Encoder';
   var commandEncoder := wgpuDeviceCreateCommandEncoder(vDevice, @commandEncoderDescriptor);
   Assert(commandEncoder <> nil);

   var renderPassColorAttachment := Default(WGPURenderPassColorAttachment);
   renderPassColorAttachment.view := targetView;
   renderPassColorAttachment.loadOp := WGPULoadOp_Clear;
   renderPassColorAttachment.storeOp := WGPUStoreOp_Store;
   renderPassColorAttachment.clearValue.r := 0.1;
   renderPassColorAttachment.clearValue.g := 1.0;
   renderPassColorAttachment.clearValue.b := 0.1;
   renderPassColorAttachment.clearValue.a := 1.0;
   renderPassColorAttachment.depthSlice := WGPU_DEPTH_SLICE_UNDEFINED;

   var renderPassDescriptor := Default(WGPURenderPassDescriptor);
   renderPassDescriptor.colorAttachmentCount := 1;
   renderPassDescriptor.colorAttachments := @renderPassColorAttachment;

   var renderPass := wgpuCommandEncoderBeginRenderPass(commandEncoder, @renderPassDescriptor);

   wgpuRenderPassEncoderSetPipeline(renderPass, vRenderPipeline);
   wgpuRenderPassEncoderSetVertexBuffer(renderPass, 0, vVertexBuffer, 0, SizeOf(Vertices));
   wgpuRenderPassEncoderDraw(renderPass, 4, 1, 0, 0);

   wgpuRenderPassEncoderEnd(renderPass);
   wgpuRenderPassEncoderRelease(renderPass);

   var commandBuffer := wgpuCommandEncoderFinish(commandEncoder, nil);
   Assert(commandBuffer <> nil);
   wgpuCommandEncoderRelease(commandEncoder);

   wgpuQueueSubmit(vQueue, 1, @commandBuffer);

   wgpuCommandBufferRelease(commandBuffer);

   wgpuTextureViewRelease(targetView);

   wgpuSurfacePresent(vSurface);
   wgpuDeviceTick(vDevice);

   wgpuTextureRelease(surfaceTexture.texture);
end;

procedure MainLoop;
var
   msg: TMsg;
   startTime, currentTime, totalTime: DWORD;
   frameCount: Integer;
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
      InitializeWindow;
      InitializeWebGPU;
      CreateRenderPipeline;
      CreateBuffers;
      MainLoop;
   except
      on E: Exception do
         Writeln(E.ClassName, ': ', E.Message);
   end;
end.