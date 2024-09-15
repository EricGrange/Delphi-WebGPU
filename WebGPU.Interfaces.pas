// WARNING: experimental and auto-generated, for comments only, not for use (yet)
//
unit WebGPU.Interfaces;

interface

uses Classes, WebGPU;

type

   IWGPUAdapter = interface;
   IWGPUBindGroup = interface;
   IWGPUBindGroupLayout = interface;
   IWGPUBuffer = interface;
   IWGPUCommandBuffer = interface;
   IWGPUCommandEncoder = interface;
   IWGPUComputePassEncoder = interface;
   IWGPUComputePipeline = interface;
   IWGPUDevice = interface;
   IWGPUExternalTexture = interface;
   IWGPUInstance = interface;
   IWGPUPipelineLayout = interface;
   IWGPUQuerySet = interface;
   IWGPUQueue = interface;
   IWGPURenderBundle = interface;
   IWGPURenderBundleEncoder = interface;
   IWGPURenderPassEncoder = interface;
   IWGPURenderPipeline = interface;
   IWGPUSampler = interface;
   IWGPUShaderModule = interface;
   IWGPUSharedBufferMemory = interface;
   IWGPUSharedFence = interface;
   IWGPUSharedTextureMemory = interface;
   IWGPUSurface = interface;
   IWGPUSwapChain = interface;
   IWGPUTexture = interface;
   IWGPUTextureView = interface;

   IWGPUAdapter = interface
      ['{EF23B10E-8B6E-2044-D3F0-0FC89A2141C9}']
      function GetHandle: TWGPUAdapter;
      function CreateDevice(const aDescriptor: TWGPUDeviceDescriptor): IWGPUDevice;
      function EnumerateFeatures(const aFeatures: PWGPUFeatureName): NativeUInt;
      function GetFormatCapabilities(const aFormat: TWGPUTextureFormat; const aCapabilities: PWGPUFormatCapabilities): TWGPUStatus;
      function GetInfo(const aInfo: PWGPUAdapterInfo): TWGPUStatus;
      function GetInstance: IWGPUInstance;
      function GetLimits(const aLimits: PWGPUSupportedLimits): TWGPUStatus;
      function HasFeature(const aFeature: TWGPUFeatureName): TWGPUBool;
      procedure RequestDevice(const aDescriptor: TWGPUDeviceDescriptor; const aCallback: TWGPURequestDeviceCallback; const aUserdata: Pointer);
      function RequestDevice2(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo2): TWGPUFuture;
      function RequestDeviceF(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo): TWGPUFuture;
   end;

   IWGPUBindGroup = interface
      ['{4F7692CD-D873-5E0E-D182-0165EBF70A08}']
      function GetHandle: TWGPUBindGroup;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUBindGroupLayout = interface
      ['{9E5830F4-8237-8781-456F-06134F2ACE2C}']
      function GetHandle: TWGPUBindGroupLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUBuffer = interface
      ['{6FC46489-F0E8-72EC-11FB-7E5935592B2A}']
      function GetHandle: TWGPUBuffer;
      function GetConstMappedRange(aOffset: NativeUInt; aSize: NativeUInt): Pointer;
      function GetMapState: TWGPUBufferMapState;
      function GetMappedRange(aOffset: NativeUInt; aSize: NativeUInt): Pointer;
      function GetSize: UInt64;
      function GetUsage: TWGPUBufferUsage;
      procedure MapAsync(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallback: TWGPUBufferMapCallback; const aUserdata: Pointer);
      function MapAsync2(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo2): TWGPUFuture;
      function MapAsyncF(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo): TWGPUFuture;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure Unmap;
   end;

   IWGPUCommandBuffer = interface
      ['{236B7E47-CC75-9118-0CA6-FE9A9AE1F74D}']
      function GetHandle: TWGPUCommandBuffer;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUCommandEncoder = interface
      ['{164CAC2F-76B4-7E3E-A25E-5EAE1600611F}']
      function GetHandle: TWGPUCommandEncoder;
      function BeginComputePass(const aDescriptor: TWGPUComputePassDescriptor): IWGPUComputePassEncoder;
      function BeginRenderPass(const aDescriptor: TWGPURenderPassDescriptor): IWGPURenderPassEncoder;
      procedure ClearBuffer(const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
      procedure CopyBufferToBuffer(const aSource: IWGPUBuffer; aSourceOffset: UInt64; const aDestination: IWGPUBuffer; aDestinationOffset: UInt64; aSize: UInt64);
      procedure CopyBufferToTexture(const aSource: PWGPUImageCopyBuffer; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D);
      procedure CopyTextureToBuffer(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyBuffer; const aCopySize: PWGPUExtent3D);
      procedure CopyTextureToTexture(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D);
      function Finish(const aDescriptor: PWGPUCommandBufferDescriptor): IWGPUCommandBuffer;
      procedure InjectValidationError(const aMessage: UTF8String);
      procedure InjectValidationError2(const aMessage: TWGPUStringView);
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure ResolveQuerySet(const aQuerySet: IWGPUQuerySet; aFirstQuery: UInt32; aQueryCount: UInt32; const aDestination: IWGPUBuffer; aDestinationOffset: UInt64);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure WriteBuffer(const aBuffer: IWGPUBuffer; aBufferOffset: UInt64; const aData: PUInt8; aSize: UInt64);
      procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
   end;

   IWGPUComputePassEncoder = interface
      ['{5717E3EE-0FD8-7D10-DD8F-5E82183A3C20}']
      function GetHandle: TWGPUComputePassEncoder;
      procedure DispatchWorkgroups(aWorkgroupCountX: UInt32; aWorkgroupCountY: UInt32; aWorkgroupCountZ: UInt32);
      procedure DispatchWorkgroupsIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure &End;
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetPipeline(const aPipeline: IWGPUComputePipeline);
      procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
   end;

   IWGPUComputePipeline = interface
      ['{D4CA07D2-FB2A-C067-A9E4-91F3403606A4}']
      function GetHandle: TWGPUComputePipeline;
      function GetBindGroupLayout(aGroupIndex: UInt32): IWGPUBindGroupLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUDevice = interface
      ['{5C020B62-26AA-E9DA-55D6-93B84ECEA57A}']
      function GetHandle: TWGPUDevice;
      function GetProcAddress(const aProcName: UTF8String): TWGPUProc;
      function GetProcAddress2(const aProcName: TWGPUStringView): TWGPUProc;
      function CreateBindGroup(const aDescriptor: TWGPUBindGroupDescriptor): IWGPUBindGroup;
      function CreateBindGroupLayout(const aDescriptor: TWGPUBindGroupLayoutDescriptor): IWGPUBindGroupLayout;
      function CreateBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
      function CreateCommandEncoder(const aDescriptor: TWGPUCommandEncoderDescriptor): IWGPUCommandEncoder;
      function CreateComputePipeline(const aDescriptor: TWGPUComputePipelineDescriptor): IWGPUComputePipeline;
      procedure CreateComputePipelineAsync(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallback: TWGPUCreateComputePipelineAsyncCallback; const aUserdata: Pointer);
      function CreateComputePipelineAsync2(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallbackInfo: TWGPUCreateComputePipelineAsyncCallbackInfo2): TWGPUFuture;
      function CreateComputePipelineAsyncF(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallbackInfo: TWGPUCreateComputePipelineAsyncCallbackInfo): TWGPUFuture;
      function CreateErrorBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
      function CreateErrorExternalTexture: IWGPUExternalTexture;
      function CreateErrorShaderModule(const aDescriptor: TWGPUShaderModuleDescriptor; const aErrorMessage: UTF8String): IWGPUShaderModule;
      function CreateErrorShaderModule2(const aDescriptor: TWGPUShaderModuleDescriptor; const aErrorMessage: TWGPUStringView): IWGPUShaderModule;
      function CreateErrorTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
      function CreateExternalTexture(const aExternalTextureDescriptor: TWGPUExternalTextureDescriptor): IWGPUExternalTexture;
      function CreatePipelineLayout(const aDescriptor: TWGPUPipelineLayoutDescriptor): IWGPUPipelineLayout;
      function CreateQuerySet(const aDescriptor: TWGPUQuerySetDescriptor): IWGPUQuerySet;
      function CreateRenderBundleEncoder(const aDescriptor: TWGPURenderBundleEncoderDescriptor): IWGPURenderBundleEncoder;
      function CreateRenderPipeline(const aDescriptor: TWGPURenderPipelineDescriptor): IWGPURenderPipeline;
      procedure CreateRenderPipelineAsync(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallback: TWGPUCreateRenderPipelineAsyncCallback; const aUserdata: Pointer);
      function CreateRenderPipelineAsync2(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallbackInfo: TWGPUCreateRenderPipelineAsyncCallbackInfo2): TWGPUFuture;
      function CreateRenderPipelineAsyncF(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallbackInfo: TWGPUCreateRenderPipelineAsyncCallbackInfo): TWGPUFuture;
      function CreateSampler(const aDescriptor: TWGPUSamplerDescriptor): IWGPUSampler;
      function CreateShaderModule(const aDescriptor: TWGPUShaderModuleDescriptor): IWGPUShaderModule;
      function CreateSwapChain(const aSurface: IWGPUSurface; const aDescriptor: TWGPUSwapChainDescriptor): IWGPUSwapChain;
      function CreateTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
      function EnumerateFeatures(const aFeatures: PWGPUFeatureName): NativeUInt;
      procedure ForceLoss(const aType: TWGPUDeviceLostReason; const aMessage: UTF8String);
      procedure ForceLoss2(const aType: TWGPUDeviceLostReason; const aMessage: TWGPUStringView);
      function GetAHardwareBufferProperties(const aHandle: Pointer; const aProperties: PWGPUAHardwareBufferProperties): TWGPUStatus;
      function GetAdapter: IWGPUAdapter;
      function GetLimits(const aLimits: PWGPUSupportedLimits): TWGPUStatus;
      function GetQueue: IWGPUQueue;
      function GetSupportedSurfaceUsage(const aSurface: IWGPUSurface): TWGPUTextureUsage;
      function HasFeature(const aFeature: TWGPUFeatureName): TWGPUBool;
      function ImportSharedBufferMemory(const aDescriptor: TWGPUSharedBufferMemoryDescriptor): IWGPUSharedBufferMemory;
      function ImportSharedFence(const aDescriptor: TWGPUSharedFenceDescriptor): IWGPUSharedFence;
      function ImportSharedTextureMemory(const aDescriptor: TWGPUSharedTextureMemoryDescriptor): IWGPUSharedTextureMemory;
      procedure InjectError(const aType: TWGPUErrorType; const aMessage: UTF8String);
      procedure InjectError2(const aType: TWGPUErrorType; const aMessage: TWGPUStringView);
      procedure PopErrorScope(const aOldCallback: TWGPUErrorCallback; const aUserdata: Pointer);
      function PopErrorScope2(const aCallbackInfo: TWGPUPopErrorScopeCallbackInfo2): TWGPUFuture;
      function PopErrorScopeF(const aCallbackInfo: TWGPUPopErrorScopeCallbackInfo): TWGPUFuture;
      procedure PushErrorScope(const aFilter: TWGPUErrorFilter);
      procedure SetDeviceLostCallback(const aCallback: TWGPUDeviceLostCallback; const aUserdata: Pointer);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetLoggingCallback(const aCallback: TWGPULoggingCallback; const aUserdata: Pointer);
      procedure SetUncapturedErrorCallback(const aCallback: TWGPUErrorCallback; const aUserdata: Pointer);
      procedure Tick;
      procedure ValidateTextureDescriptor(const aDescriptor: TWGPUTextureDescriptor);
   end;

   IWGPUExternalTexture = interface
      ['{0E1115A9-86F4-5155-65D6-5F010585CDF6}']
      function GetHandle: TWGPUExternalTexture;
      procedure Expire;
      procedure Refresh;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUInstance = interface
      ['{F1B8469C-6F36-DB74-B653-F2D1B7538413}']
      function GetHandle: TWGPUInstance;
      function CreateSurface(const aDescriptor: TWGPUSurfaceDescriptor): IWGPUSurface;
      function EnumerateWGSLLanguageFeatures(const aFeatures: PWGPUWGSLFeatureName): NativeUInt;
      function HasWGSLLanguageFeature(const aFeature: TWGPUWGSLFeatureName): TWGPUBool;
      procedure ProcessEvents;
      procedure RequestAdapter(const aOptions: TWGPURequestAdapterOptions; const aCallback: TWGPURequestAdapterCallback; const aUserdata: Pointer);
      function RequestAdapter2(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo2): TWGPUFuture;
      function RequestAdapterF(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo): TWGPUFuture;
      function WaitAny(aFutureCount: NativeUInt; const aFutures: PWGPUFutureWaitInfo; aTimeoutNS: UInt64): TWGPUWaitStatus;
   end;

   IWGPUPipelineLayout = interface
      ['{0B34D626-DCF4-7857-60A4-BA3D77C942B3}']
      function GetHandle: TWGPUPipelineLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUQuerySet = interface
      ['{EB6DCE87-D4CC-8C4C-F6A4-CDA5E4488E6C}']
      function GetHandle: TWGPUQuerySet;
      function GetCount: UInt32;
      function GetType: TWGPUQueryType;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUQueue = interface
      ['{4CBE6E56-BD36-266F-EEF2-D54D52FE5869}']
      function GetHandle: TWGPUQueue;
      procedure CopyExternalTextureForBrowser(const aSource: PWGPUImageCopyExternalTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
      procedure CopyTextureForBrowser(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
      procedure OnSubmittedWorkDone(const aCallback: TWGPUQueueWorkDoneCallback; const aUserdata: Pointer);
      function OnSubmittedWorkDone2(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo2): TWGPUFuture;
      function OnSubmittedWorkDoneF(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo): TWGPUFuture;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure Submit(aCommandCount: NativeUInt; const aCommands: PWGPUCommandBuffer);
      procedure WriteBuffer(const aBuffer: IWGPUBuffer; aBufferOffset: UInt64; const aData: Pointer; aSize: NativeUInt);
      procedure WriteTexture(const aDestination: PWGPUImageCopyTexture; const aData: Pointer; aDataSize: NativeUInt; const aDataLayout: PWGPUTextureDataLayout; const aWriteSize: PWGPUExtent3D);
   end;

   IWGPURenderBundle = interface
      ['{62CFDD16-CFEF-9D6B-B8B8-EC7C813247D8}']
      function GetHandle: TWGPURenderBundle;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPURenderBundleEncoder = interface
      ['{1DE4BD41-8BB4-6B2D-D0F9-5B641D6283FC}']
      function GetHandle: TWGPURenderBundleEncoder;
      procedure Draw(aVertexCount: UInt32; aInstanceCount: UInt32; aFirstVertex: UInt32; aFirstInstance: UInt32);
      procedure DrawIndexed(aIndexCount: UInt32; aInstanceCount: UInt32; aFirstIndex: UInt32; const aBaseVertex: Int32; aFirstInstance: UInt32);
      procedure DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure DrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      function Finish(const aDescriptor: PWGPURenderBundleDescriptor): IWGPURenderBundle;
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
      procedure SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; aOffset: UInt64; aSize: UInt64);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetPipeline(const aPipeline: IWGPURenderPipeline);
      procedure SetVertexBuffer(aSlot: UInt32; const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
   end;

   IWGPURenderPassEncoder = interface
      ['{36C89154-C8D5-1E4C-BC9D-3D9325DFAF9B}']
      function GetHandle: TWGPURenderPassEncoder;
      procedure BeginOcclusionQuery(aQueryIndex: UInt32);
      procedure Draw(aVertexCount: UInt32; aInstanceCount: UInt32; aFirstVertex: UInt32; aFirstInstance: UInt32);
      procedure DrawIndexed(aIndexCount: UInt32; aInstanceCount: UInt32; aFirstIndex: UInt32; const aBaseVertex: Int32; aFirstInstance: UInt32);
      procedure DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure DrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure &End;
      procedure EndOcclusionQuery;
      procedure ExecuteBundles(aBundleCount: NativeUInt; const aBundles: PWGPURenderBundle);
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure MultiDrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64; aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; aDrawCountBufferOffset: UInt64);
      procedure MultiDrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64; aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; aDrawCountBufferOffset: UInt64);
      procedure PixelLocalStorageBarrier;
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
      procedure SetBlendConstant(const aColor: PWGPUColor);
      procedure SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; aOffset: UInt64; aSize: UInt64);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetPipeline(const aPipeline: IWGPURenderPipeline);
      procedure SetScissorRect(aX: UInt32; aY: UInt32; aWidth: UInt32; aHeight: UInt32);
      procedure SetStencilReference(aReference: UInt32);
      procedure SetVertexBuffer(aSlot: UInt32; const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
      procedure SetViewport(const aX: Single; const aY: Single; const aWidth: Single; const aHeight: Single; const aMinDepth: Single; const aMaxDepth: Single);
      procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
   end;

   IWGPURenderPipeline = interface
      ['{54B16051-8009-561C-74DD-9E4DB3461191}']
      function GetHandle: TWGPURenderPipeline;
      function GetBindGroupLayout(aGroupIndex: UInt32): IWGPUBindGroupLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUSampler = interface
      ['{CC574ADD-E54C-F740-ECCF-8F3063233408}']
      function GetHandle: TWGPUSampler;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUShaderModule = interface
      ['{4CD3FBBA-8F0C-7203-F991-549B9034BE77}']
      function GetHandle: TWGPUShaderModule;
      procedure GetCompilationInfo(const aCallback: TWGPUCompilationInfoCallback; const aUserdata: Pointer);
      function GetCompilationInfo2(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo2): TWGPUFuture;
      function GetCompilationInfoF(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo): TWGPUFuture;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUSharedBufferMemory = interface
      ['{E6D9BCD6-F3CC-C067-E33A-093C6D0FFBF5}']
      function GetHandle: TWGPUSharedBufferMemory;
      function BeginAccess(const aBuffer: IWGPUBuffer; const aDescriptor: TWGPUSharedBufferMemoryBeginAccessDescriptor): TWGPUStatus;
      function CreateBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
      function EndAccess(const aBuffer: IWGPUBuffer; const aDescriptor: PWGPUSharedBufferMemoryEndAccessState): TWGPUStatus;
      function GetProperties(const aProperties: PWGPUSharedBufferMemoryProperties): TWGPUStatus;
      function IsDeviceLost: TWGPUBool;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUSharedFence = interface
      ['{37AF18F5-47F4-C274-5509-855D8D609392}']
      function GetHandle: TWGPUSharedFence;
      procedure ExportInfo(const aInfo: PWGPUSharedFenceExportInfo);
   end;

   IWGPUSharedTextureMemory = interface
      ['{B5C272BE-10AD-2E36-346D-180B924B4AC6}']
      function GetHandle: TWGPUSharedTextureMemory;
      function BeginAccess(const aTexture: IWGPUTexture; const aDescriptor: TWGPUSharedTextureMemoryBeginAccessDescriptor): TWGPUStatus;
      function CreateTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
      function EndAccess(const aTexture: IWGPUTexture; const aDescriptor: PWGPUSharedTextureMemoryEndAccessState): TWGPUStatus;
      function GetProperties(const aProperties: PWGPUSharedTextureMemoryProperties): TWGPUStatus;
      function IsDeviceLost: TWGPUBool;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUSurface = interface
      ['{8452B981-4E40-3147-AF59-71F11D12A43C}']
      function GetHandle: TWGPUSurface;
      procedure Configure(const aConfig: TWGPUSurfaceConfiguration);
      function GetCapabilities(const aAdapter: IWGPUAdapter; const aCapabilities: PWGPUSurfaceCapabilities): TWGPUStatus;
      procedure GetCurrentTexture(const aSurfaceTexture: PWGPUSurfaceTexture);
      function GetPreferredFormat(const aAdapter: IWGPUAdapter): TWGPUTextureFormat;
      procedure Present;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure Unconfigure;
   end;

   IWGPUSwapChain = interface
      ['{B04973B1-5BFA-1BB3-40F9-701E79FDF390}']
      function GetHandle: TWGPUSwapChain;
      function GetCurrentTexture: IWGPUTexture;
      function GetCurrentTextureView: IWGPUTextureView;
      procedure Present;
   end;

   IWGPUTexture = interface
      ['{13DB8189-BFB9-23F7-C715-19710FB0C5B6}']
      function GetHandle: TWGPUTexture;
      function CreateErrorView(const aDescriptor: TWGPUTextureViewDescriptor): IWGPUTextureView;
      function CreateView(const aDescriptor: TWGPUTextureViewDescriptor): IWGPUTextureView;
      function GetDepthOrArrayLayers: UInt32;
      function GetDimension: TWGPUTextureDimension;
      function GetFormat: TWGPUTextureFormat;
      function GetHeight: UInt32;
      function GetMipLevelCount: UInt32;
      function GetSampleCount: UInt32;
      function GetUsage: TWGPUTextureUsage;
      function GetWidth: UInt32;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   IWGPUTextureView = interface
      ['{3F5BC914-7392-CA2E-12C6-C9793448F797}']
      function GetHandle: TWGPUTextureView;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   WGPUFactory = class sealed
      public
         // To create top level instance
         class function CreateInstance(const aInstanceDescriptor : TWGPUInstanceDescriptor) : IWGPUInstance; static;
         // To wrap entities received in request callbacks
         class function WrapAdapter(const aAdapter : TWGPUAdapter) : IWGPUAdapter; static;
         class function WrapDevice(const aDevice : TWGPUDevice) : IWGPUDevice; static;
   end;

implementation

type
   TiwgpuAdapter = class(TInterfacedObject, IWGPUAdapter)
      FHandle: TWGPUAdapter;
      constructor Create(const h: TWGPUAdapter);
      destructor Destroy; override;
      function GetHandle: TWGPUAdapter;
      function CreateDevice(const aDescriptor: TWGPUDeviceDescriptor): IWGPUDevice;
      function EnumerateFeatures(const aFeatures: PWGPUFeatureName): NativeUInt;
      function GetFormatCapabilities(const aFormat: TWGPUTextureFormat; const aCapabilities: PWGPUFormatCapabilities): TWGPUStatus;
      function GetInfo(const aInfo: PWGPUAdapterInfo): TWGPUStatus;
      function GetInstance: IWGPUInstance;
      function GetLimits(const aLimits: PWGPUSupportedLimits): TWGPUStatus;
      function HasFeature(const aFeature: TWGPUFeatureName): TWGPUBool;
      procedure RequestDevice(const aDescriptor: TWGPUDeviceDescriptor; const aCallback: TWGPURequestDeviceCallback; const aUserdata: Pointer);
      function RequestDevice2(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo2): TWGPUFuture;
      function RequestDeviceF(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo): TWGPUFuture;
   end;

   TiwgpuBindGroup = class(TInterfacedObject, IWGPUBindGroup)
      FHandle: TWGPUBindGroup;
      constructor Create(const h: TWGPUBindGroup);
      destructor Destroy; override;
      function GetHandle: TWGPUBindGroup;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuBindGroupLayout = class(TInterfacedObject, IWGPUBindGroupLayout)
      FHandle: TWGPUBindGroupLayout;
      constructor Create(const h: TWGPUBindGroupLayout);
      destructor Destroy; override;
      function GetHandle: TWGPUBindGroupLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuBuffer = class(TInterfacedObject, IWGPUBuffer)
      FHandle: TWGPUBuffer;
      constructor Create(const h: TWGPUBuffer);
      destructor Destroy; override;
      function GetHandle: TWGPUBuffer;
      function GetConstMappedRange(aOffset: NativeUInt; aSize: NativeUInt): Pointer;
      function GetMapState: TWGPUBufferMapState;
      function GetMappedRange(aOffset: NativeUInt; aSize: NativeUInt): Pointer;
      function GetSize: UInt64;
      function GetUsage: TWGPUBufferUsage;
      procedure MapAsync(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallback: TWGPUBufferMapCallback; const aUserdata: Pointer);
      function MapAsync2(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo2): TWGPUFuture;
      function MapAsyncF(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo): TWGPUFuture;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure Unmap;
   end;

   TiwgpuCommandBuffer = class(TInterfacedObject, IWGPUCommandBuffer)
      FHandle: TWGPUCommandBuffer;
      constructor Create(const h: TWGPUCommandBuffer);
      destructor Destroy; override;
      function GetHandle: TWGPUCommandBuffer;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuCommandEncoder = class(TInterfacedObject, IWGPUCommandEncoder)
      FHandle: TWGPUCommandEncoder;
      constructor Create(const h: TWGPUCommandEncoder);
      destructor Destroy; override;
      function GetHandle: TWGPUCommandEncoder;
      function BeginComputePass(const aDescriptor: TWGPUComputePassDescriptor): IWGPUComputePassEncoder;
      function BeginRenderPass(const aDescriptor: TWGPURenderPassDescriptor): IWGPURenderPassEncoder;
      procedure ClearBuffer(const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
      procedure CopyBufferToBuffer(const aSource: IWGPUBuffer; aSourceOffset: UInt64; const aDestination: IWGPUBuffer; aDestinationOffset: UInt64; aSize: UInt64);
      procedure CopyBufferToTexture(const aSource: PWGPUImageCopyBuffer; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D);
      procedure CopyTextureToBuffer(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyBuffer; const aCopySize: PWGPUExtent3D);
      procedure CopyTextureToTexture(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D);
      function Finish(const aDescriptor: PWGPUCommandBufferDescriptor): IWGPUCommandBuffer;
      procedure InjectValidationError(const aMessage: UTF8String);
      procedure InjectValidationError2(const aMessage: TWGPUStringView);
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure ResolveQuerySet(const aQuerySet: IWGPUQuerySet; aFirstQuery: UInt32; aQueryCount: UInt32; const aDestination: IWGPUBuffer; aDestinationOffset: UInt64);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure WriteBuffer(const aBuffer: IWGPUBuffer; aBufferOffset: UInt64; const aData: PUInt8; aSize: UInt64);
      procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
   end;

   TiwgpuComputePassEncoder = class(TInterfacedObject, IWGPUComputePassEncoder)
      FHandle: TWGPUComputePassEncoder;
      constructor Create(const h: TWGPUComputePassEncoder);
      destructor Destroy; override;
      function GetHandle: TWGPUComputePassEncoder;
      procedure DispatchWorkgroups(aWorkgroupCountX: UInt32; aWorkgroupCountY: UInt32; aWorkgroupCountZ: UInt32);
      procedure DispatchWorkgroupsIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure &End;
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetPipeline(const aPipeline: IWGPUComputePipeline);
      procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
   end;

   TiwgpuComputePipeline = class(TInterfacedObject, IWGPUComputePipeline)
      FHandle: TWGPUComputePipeline;
      constructor Create(const h: TWGPUComputePipeline);
      destructor Destroy; override;
      function GetHandle: TWGPUComputePipeline;
      function GetBindGroupLayout(aGroupIndex: UInt32): IWGPUBindGroupLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuDevice = class(TInterfacedObject, IWGPUDevice)
      FHandle: TWGPUDevice;
      constructor Create(const h: TWGPUDevice);
      destructor Destroy; override;
      function GetHandle: TWGPUDevice;
      function GetProcAddress(const aProcName: UTF8String): TWGPUProc;
      function GetProcAddress2(const aProcName: TWGPUStringView): TWGPUProc;
      function CreateBindGroup(const aDescriptor: TWGPUBindGroupDescriptor): IWGPUBindGroup;
      function CreateBindGroupLayout(const aDescriptor: TWGPUBindGroupLayoutDescriptor): IWGPUBindGroupLayout;
      function CreateBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
      function CreateCommandEncoder(const aDescriptor: TWGPUCommandEncoderDescriptor): IWGPUCommandEncoder;
      function CreateComputePipeline(const aDescriptor: TWGPUComputePipelineDescriptor): IWGPUComputePipeline;
      procedure CreateComputePipelineAsync(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallback: TWGPUCreateComputePipelineAsyncCallback; const aUserdata: Pointer);
      function CreateComputePipelineAsync2(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallbackInfo: TWGPUCreateComputePipelineAsyncCallbackInfo2): TWGPUFuture;
      function CreateComputePipelineAsyncF(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallbackInfo: TWGPUCreateComputePipelineAsyncCallbackInfo): TWGPUFuture;
      function CreateErrorBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
      function CreateErrorExternalTexture: IWGPUExternalTexture;
      function CreateErrorShaderModule(const aDescriptor: TWGPUShaderModuleDescriptor; const aErrorMessage: UTF8String): IWGPUShaderModule;
      function CreateErrorShaderModule2(const aDescriptor: TWGPUShaderModuleDescriptor; const aErrorMessage: TWGPUStringView): IWGPUShaderModule;
      function CreateErrorTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
      function CreateExternalTexture(const aExternalTextureDescriptor: TWGPUExternalTextureDescriptor): IWGPUExternalTexture;
      function CreatePipelineLayout(const aDescriptor: TWGPUPipelineLayoutDescriptor): IWGPUPipelineLayout;
      function CreateQuerySet(const aDescriptor: TWGPUQuerySetDescriptor): IWGPUQuerySet;
      function CreateRenderBundleEncoder(const aDescriptor: TWGPURenderBundleEncoderDescriptor): IWGPURenderBundleEncoder;
      function CreateRenderPipeline(const aDescriptor: TWGPURenderPipelineDescriptor): IWGPURenderPipeline;
      procedure CreateRenderPipelineAsync(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallback: TWGPUCreateRenderPipelineAsyncCallback; const aUserdata: Pointer);
      function CreateRenderPipelineAsync2(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallbackInfo: TWGPUCreateRenderPipelineAsyncCallbackInfo2): TWGPUFuture;
      function CreateRenderPipelineAsyncF(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallbackInfo: TWGPUCreateRenderPipelineAsyncCallbackInfo): TWGPUFuture;
      function CreateSampler(const aDescriptor: TWGPUSamplerDescriptor): IWGPUSampler;
      function CreateShaderModule(const aDescriptor: TWGPUShaderModuleDescriptor): IWGPUShaderModule;
      function CreateSwapChain(const aSurface: IWGPUSurface; const aDescriptor: TWGPUSwapChainDescriptor): IWGPUSwapChain;
      function CreateTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
      function EnumerateFeatures(const aFeatures: PWGPUFeatureName): NativeUInt;
      procedure ForceLoss(const aType: TWGPUDeviceLostReason; const aMessage: UTF8String);
      procedure ForceLoss2(const aType: TWGPUDeviceLostReason; const aMessage: TWGPUStringView);
      function GetAHardwareBufferProperties(const aHandle: Pointer; const aProperties: PWGPUAHardwareBufferProperties): TWGPUStatus;
      function GetAdapter: IWGPUAdapter;
      function GetLimits(const aLimits: PWGPUSupportedLimits): TWGPUStatus;
      function GetQueue: IWGPUQueue;
      function GetSupportedSurfaceUsage(const aSurface: IWGPUSurface): TWGPUTextureUsage;
      function HasFeature(const aFeature: TWGPUFeatureName): TWGPUBool;
      function ImportSharedBufferMemory(const aDescriptor: TWGPUSharedBufferMemoryDescriptor): IWGPUSharedBufferMemory;
      function ImportSharedFence(const aDescriptor: TWGPUSharedFenceDescriptor): IWGPUSharedFence;
      function ImportSharedTextureMemory(const aDescriptor: TWGPUSharedTextureMemoryDescriptor): IWGPUSharedTextureMemory;
      procedure InjectError(const aType: TWGPUErrorType; const aMessage: UTF8String);
      procedure InjectError2(const aType: TWGPUErrorType; const aMessage: TWGPUStringView);
      procedure PopErrorScope(const aOldCallback: TWGPUErrorCallback; const aUserdata: Pointer);
      function PopErrorScope2(const aCallbackInfo: TWGPUPopErrorScopeCallbackInfo2): TWGPUFuture;
      function PopErrorScopeF(const aCallbackInfo: TWGPUPopErrorScopeCallbackInfo): TWGPUFuture;
      procedure PushErrorScope(const aFilter: TWGPUErrorFilter);
      procedure SetDeviceLostCallback(const aCallback: TWGPUDeviceLostCallback; const aUserdata: Pointer);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetLoggingCallback(const aCallback: TWGPULoggingCallback; const aUserdata: Pointer);
      procedure SetUncapturedErrorCallback(const aCallback: TWGPUErrorCallback; const aUserdata: Pointer);
      procedure Tick;
      procedure ValidateTextureDescriptor(const aDescriptor: TWGPUTextureDescriptor);
   end;

   TiwgpuExternalTexture = class(TInterfacedObject, IWGPUExternalTexture)
      FHandle: TWGPUExternalTexture;
      constructor Create(const h: TWGPUExternalTexture);
      destructor Destroy; override;
      function GetHandle: TWGPUExternalTexture;
      procedure Expire;
      procedure Refresh;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuInstance = class(TInterfacedObject, IWGPUInstance)
      FHandle: TWGPUInstance;
      constructor Create(const h: TWGPUInstance);
      destructor Destroy; override;
      function GetHandle: TWGPUInstance;
      function CreateSurface(const aDescriptor: TWGPUSurfaceDescriptor): IWGPUSurface;
      function EnumerateWGSLLanguageFeatures(const aFeatures: PWGPUWGSLFeatureName): NativeUInt;
      function HasWGSLLanguageFeature(const aFeature: TWGPUWGSLFeatureName): TWGPUBool;
      procedure ProcessEvents;
      procedure RequestAdapter(const aOptions: TWGPURequestAdapterOptions; const aCallback: TWGPURequestAdapterCallback; const aUserdata: Pointer);
      function RequestAdapter2(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo2): TWGPUFuture;
      function RequestAdapterF(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo): TWGPUFuture;
      function WaitAny(aFutureCount: NativeUInt; const aFutures: PWGPUFutureWaitInfo; aTimeoutNS: UInt64): TWGPUWaitStatus;
   end;

   TiwgpuPipelineLayout = class(TInterfacedObject, IWGPUPipelineLayout)
      FHandle: TWGPUPipelineLayout;
      constructor Create(const h: TWGPUPipelineLayout);
      destructor Destroy; override;
      function GetHandle: TWGPUPipelineLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuQuerySet = class(TInterfacedObject, IWGPUQuerySet)
      FHandle: TWGPUQuerySet;
      constructor Create(const h: TWGPUQuerySet);
      destructor Destroy; override;
      function GetHandle: TWGPUQuerySet;
      function GetCount: UInt32;
      function GetType: TWGPUQueryType;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuQueue = class(TInterfacedObject, IWGPUQueue)
      FHandle: TWGPUQueue;
      constructor Create(const h: TWGPUQueue);
      destructor Destroy; override;
      function GetHandle: TWGPUQueue;
      procedure CopyExternalTextureForBrowser(const aSource: PWGPUImageCopyExternalTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
      procedure CopyTextureForBrowser(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
      procedure OnSubmittedWorkDone(const aCallback: TWGPUQueueWorkDoneCallback; const aUserdata: Pointer);
      function OnSubmittedWorkDone2(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo2): TWGPUFuture;
      function OnSubmittedWorkDoneF(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo): TWGPUFuture;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure Submit(aCommandCount: NativeUInt; const aCommands: PWGPUCommandBuffer);
      procedure WriteBuffer(const aBuffer: IWGPUBuffer; aBufferOffset: UInt64; const aData: Pointer; aSize: NativeUInt);
      procedure WriteTexture(const aDestination: PWGPUImageCopyTexture; const aData: Pointer; aDataSize: NativeUInt; const aDataLayout: PWGPUTextureDataLayout; const aWriteSize: PWGPUExtent3D);
   end;

   TiwgpuRenderBundle = class(TInterfacedObject, IWGPURenderBundle)
      FHandle: TWGPURenderBundle;
      constructor Create(const h: TWGPURenderBundle);
      destructor Destroy; override;
      function GetHandle: TWGPURenderBundle;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuRenderBundleEncoder = class(TInterfacedObject, IWGPURenderBundleEncoder)
      FHandle: TWGPURenderBundleEncoder;
      constructor Create(const h: TWGPURenderBundleEncoder);
      destructor Destroy; override;
      function GetHandle: TWGPURenderBundleEncoder;
      procedure Draw(aVertexCount: UInt32; aInstanceCount: UInt32; aFirstVertex: UInt32; aFirstInstance: UInt32);
      procedure DrawIndexed(aIndexCount: UInt32; aInstanceCount: UInt32; aFirstIndex: UInt32; const aBaseVertex: Int32; aFirstInstance: UInt32);
      procedure DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure DrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      function Finish(const aDescriptor: PWGPURenderBundleDescriptor): IWGPURenderBundle;
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
      procedure SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; aOffset: UInt64; aSize: UInt64);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetPipeline(const aPipeline: IWGPURenderPipeline);
      procedure SetVertexBuffer(aSlot: UInt32; const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
   end;

   TiwgpuRenderPassEncoder = class(TInterfacedObject, IWGPURenderPassEncoder)
      FHandle: TWGPURenderPassEncoder;
      constructor Create(const h: TWGPURenderPassEncoder);
      destructor Destroy; override;
      function GetHandle: TWGPURenderPassEncoder;
      procedure BeginOcclusionQuery(aQueryIndex: UInt32);
      procedure Draw(aVertexCount: UInt32; aInstanceCount: UInt32; aFirstVertex: UInt32; aFirstInstance: UInt32);
      procedure DrawIndexed(aIndexCount: UInt32; aInstanceCount: UInt32; aFirstIndex: UInt32; const aBaseVertex: Int32; aFirstInstance: UInt32);
      procedure DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure DrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
      procedure &End;
      procedure EndOcclusionQuery;
      procedure ExecuteBundles(aBundleCount: NativeUInt; const aBundles: PWGPURenderBundle);
      procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
      procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
      procedure MultiDrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64; aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; aDrawCountBufferOffset: UInt64);
      procedure MultiDrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64; aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; aDrawCountBufferOffset: UInt64);
      procedure PixelLocalStorageBarrier;
      procedure PopDebugGroup;
      procedure PushDebugGroup(const aGroupLabel: UTF8String);
      procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
      procedure SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
      procedure SetBlendConstant(const aColor: PWGPUColor);
      procedure SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; aOffset: UInt64; aSize: UInt64);
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure SetPipeline(const aPipeline: IWGPURenderPipeline);
      procedure SetScissorRect(aX: UInt32; aY: UInt32; aWidth: UInt32; aHeight: UInt32);
      procedure SetStencilReference(aReference: UInt32);
      procedure SetVertexBuffer(aSlot: UInt32; const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
      procedure SetViewport(const aX: Single; const aY: Single; const aWidth: Single; const aHeight: Single; const aMinDepth: Single; const aMaxDepth: Single);
      procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
   end;

   TiwgpuRenderPipeline = class(TInterfacedObject, IWGPURenderPipeline)
      FHandle: TWGPURenderPipeline;
      constructor Create(const h: TWGPURenderPipeline);
      destructor Destroy; override;
      function GetHandle: TWGPURenderPipeline;
      function GetBindGroupLayout(aGroupIndex: UInt32): IWGPUBindGroupLayout;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuSampler = class(TInterfacedObject, IWGPUSampler)
      FHandle: TWGPUSampler;
      constructor Create(const h: TWGPUSampler);
      destructor Destroy; override;
      function GetHandle: TWGPUSampler;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuShaderModule = class(TInterfacedObject, IWGPUShaderModule)
      FHandle: TWGPUShaderModule;
      constructor Create(const h: TWGPUShaderModule);
      destructor Destroy; override;
      function GetHandle: TWGPUShaderModule;
      procedure GetCompilationInfo(const aCallback: TWGPUCompilationInfoCallback; const aUserdata: Pointer);
      function GetCompilationInfo2(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo2): TWGPUFuture;
      function GetCompilationInfoF(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo): TWGPUFuture;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuSharedBufferMemory = class(TInterfacedObject, IWGPUSharedBufferMemory)
      FHandle: TWGPUSharedBufferMemory;
      constructor Create(const h: TWGPUSharedBufferMemory);
      destructor Destroy; override;
      function GetHandle: TWGPUSharedBufferMemory;
      function BeginAccess(const aBuffer: IWGPUBuffer; const aDescriptor: TWGPUSharedBufferMemoryBeginAccessDescriptor): TWGPUStatus;
      function CreateBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
      function EndAccess(const aBuffer: IWGPUBuffer; const aDescriptor: PWGPUSharedBufferMemoryEndAccessState): TWGPUStatus;
      function GetProperties(const aProperties: PWGPUSharedBufferMemoryProperties): TWGPUStatus;
      function IsDeviceLost: TWGPUBool;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuSharedFence = class(TInterfacedObject, IWGPUSharedFence)
      FHandle: TWGPUSharedFence;
      constructor Create(const h: TWGPUSharedFence);
      destructor Destroy; override;
      function GetHandle: TWGPUSharedFence;
      procedure ExportInfo(const aInfo: PWGPUSharedFenceExportInfo);
   end;

   TiwgpuSharedTextureMemory = class(TInterfacedObject, IWGPUSharedTextureMemory)
      FHandle: TWGPUSharedTextureMemory;
      constructor Create(const h: TWGPUSharedTextureMemory);
      destructor Destroy; override;
      function GetHandle: TWGPUSharedTextureMemory;
      function BeginAccess(const aTexture: IWGPUTexture; const aDescriptor: TWGPUSharedTextureMemoryBeginAccessDescriptor): TWGPUStatus;
      function CreateTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
      function EndAccess(const aTexture: IWGPUTexture; const aDescriptor: PWGPUSharedTextureMemoryEndAccessState): TWGPUStatus;
      function GetProperties(const aProperties: PWGPUSharedTextureMemoryProperties): TWGPUStatus;
      function IsDeviceLost: TWGPUBool;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuSurface = class(TInterfacedObject, IWGPUSurface)
      FHandle: TWGPUSurface;
      constructor Create(const h: TWGPUSurface);
      destructor Destroy; override;
      function GetHandle: TWGPUSurface;
      procedure Configure(const aConfig: TWGPUSurfaceConfiguration);
      function GetCapabilities(const aAdapter: IWGPUAdapter; const aCapabilities: PWGPUSurfaceCapabilities): TWGPUStatus;
      procedure GetCurrentTexture(const aSurfaceTexture: PWGPUSurfaceTexture);
      function GetPreferredFormat(const aAdapter: IWGPUAdapter): TWGPUTextureFormat;
      procedure Present;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
      procedure Unconfigure;
   end;

   TiwgpuSwapChain = class(TInterfacedObject, IWGPUSwapChain)
      FHandle: TWGPUSwapChain;
      constructor Create(const h: TWGPUSwapChain);
      destructor Destroy; override;
      function GetHandle: TWGPUSwapChain;
      function GetCurrentTexture: IWGPUTexture;
      function GetCurrentTextureView: IWGPUTextureView;
      procedure Present;
   end;

   TiwgpuTexture = class(TInterfacedObject, IWGPUTexture)
      FHandle: TWGPUTexture;
      constructor Create(const h: TWGPUTexture);
      destructor Destroy; override;
      function GetHandle: TWGPUTexture;
      function CreateErrorView(const aDescriptor: TWGPUTextureViewDescriptor): IWGPUTextureView;
      function CreateView(const aDescriptor: TWGPUTextureViewDescriptor): IWGPUTextureView;
      function GetDepthOrArrayLayers: UInt32;
      function GetDimension: TWGPUTextureDimension;
      function GetFormat: TWGPUTextureFormat;
      function GetHeight: UInt32;
      function GetMipLevelCount: UInt32;
      function GetSampleCount: UInt32;
      function GetUsage: TWGPUTextureUsage;
      function GetWidth: UInt32;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

   TiwgpuTextureView = class(TInterfacedObject, IWGPUTextureView)
      FHandle: TWGPUTextureView;
      constructor Create(const h: TWGPUTextureView);
      destructor Destroy; override;
      function GetHandle: TWGPUTextureView;
      procedure SetLabel(const aLabel: UTF8String);
      procedure SetLabel2(const aLabel: TWGPUStringView);
   end;

constructor TiwgpuAdapter.Create(const h: TWGPUAdapter);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuAdapter.Destroy;
begin
   inherited Destroy;
   wgpuAdapterRelease(FHandle);
end;

function TiwgpuAdapter.GetHandle: TWGPUAdapter;
begin
   Result := FHandle;
end;

function TiwgpuAdapter.CreateDevice(const aDescriptor: TWGPUDeviceDescriptor): IWGPUDevice;
begin
   Result := TiwgpuDevice.Create(wgpuAdapterCreateDevice(FHandle, @aDescriptor));
end;

function TiwgpuAdapter.EnumerateFeatures(const aFeatures: PWGPUFeatureName): NativeUInt;
begin
   Result := wgpuAdapterEnumerateFeatures(FHandle, aFeatures);
end;

function TiwgpuAdapter.GetFormatCapabilities(const aFormat: TWGPUTextureFormat; const aCapabilities: PWGPUFormatCapabilities): TWGPUStatus;
begin
   Result := wgpuAdapterGetFormatCapabilities(FHandle, aFormat, aCapabilities);
end;

function TiwgpuAdapter.GetInfo(const aInfo: PWGPUAdapterInfo): TWGPUStatus;
begin
   Result := wgpuAdapterGetInfo(FHandle, aInfo);
end;

function TiwgpuAdapter.GetInstance: IWGPUInstance;
begin
   Result := TiwgpuInstance.Create(wgpuAdapterGetInstance(FHandle));
end;

function TiwgpuAdapter.GetLimits(const aLimits: PWGPUSupportedLimits): TWGPUStatus;
begin
   Result := wgpuAdapterGetLimits(FHandle, aLimits);
end;

function TiwgpuAdapter.HasFeature(const aFeature: TWGPUFeatureName): TWGPUBool;
begin
   Result := wgpuAdapterHasFeature(FHandle, aFeature);
end;

procedure TiwgpuAdapter.RequestDevice(const aDescriptor: TWGPUDeviceDescriptor; const aCallback: TWGPURequestDeviceCallback; const aUserdata: Pointer);
begin
   wgpuAdapterRequestDevice(FHandle, @aDescriptor, aCallback, aUserdata);
end;

function TiwgpuAdapter.RequestDevice2(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuAdapterRequestDevice2(FHandle, @aOptions, aCallbackInfo);
end;

function TiwgpuAdapter.RequestDeviceF(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo): TWGPUFuture;
begin
   Result := wgpuAdapterRequestDeviceF(FHandle, @aOptions, aCallbackInfo);
end;

constructor TiwgpuBindGroup.Create(const h: TWGPUBindGroup);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuBindGroup.Destroy;
begin
   inherited Destroy;
   wgpuBindGroupRelease(FHandle);
end;

function TiwgpuBindGroup.GetHandle: TWGPUBindGroup;
begin
   Result := FHandle;
end;

procedure TiwgpuBindGroup.SetLabel(const aLabel: UTF8String);
begin
   wgpuBindGroupSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuBindGroup.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuBindGroupSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuBindGroupLayout.Create(const h: TWGPUBindGroupLayout);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuBindGroupLayout.Destroy;
begin
   inherited Destroy;
   wgpuBindGroupLayoutRelease(FHandle);
end;

function TiwgpuBindGroupLayout.GetHandle: TWGPUBindGroupLayout;
begin
   Result := FHandle;
end;

procedure TiwgpuBindGroupLayout.SetLabel(const aLabel: UTF8String);
begin
   wgpuBindGroupLayoutSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuBindGroupLayout.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuBindGroupLayoutSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuBuffer.Create(const h: TWGPUBuffer);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuBuffer.Destroy;
begin
   inherited Destroy;
   wgpuBufferRelease(FHandle);
end;

function TiwgpuBuffer.GetHandle: TWGPUBuffer;
begin
   Result := FHandle;
end;

function TiwgpuBuffer.GetConstMappedRange(aOffset: NativeUInt; aSize: NativeUInt): Pointer;
begin
   Result := wgpuBufferGetConstMappedRange(FHandle, aOffset, aSize);
end;

function TiwgpuBuffer.GetMapState: TWGPUBufferMapState;
begin
   Result := wgpuBufferGetMapState(FHandle);
end;

function TiwgpuBuffer.GetMappedRange(aOffset: NativeUInt; aSize: NativeUInt): Pointer;
begin
   Result := wgpuBufferGetMappedRange(FHandle, aOffset, aSize);
end;

function TiwgpuBuffer.GetSize: UInt64;
begin
   Result := wgpuBufferGetSize(FHandle);
end;

function TiwgpuBuffer.GetUsage: TWGPUBufferUsage;
begin
   Result := wgpuBufferGetUsage(FHandle);
end;

procedure TiwgpuBuffer.MapAsync(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallback: TWGPUBufferMapCallback; const aUserdata: Pointer);
begin
   wgpuBufferMapAsync(FHandle, aMode, aOffset, aSize, aCallback, aUserdata);
end;

function TiwgpuBuffer.MapAsync2(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuBufferMapAsync2(FHandle, aMode, aOffset, aSize, aCallbackInfo);
end;

function TiwgpuBuffer.MapAsyncF(const aMode: TWGPUMapMode; aOffset: NativeUInt; aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo): TWGPUFuture;
begin
   Result := wgpuBufferMapAsyncF(FHandle, aMode, aOffset, aSize, aCallbackInfo);
end;

procedure TiwgpuBuffer.SetLabel(const aLabel: UTF8String);
begin
   wgpuBufferSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuBuffer.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuBufferSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuBuffer.Unmap;
begin
   wgpuBufferUnmap(FHandle);
end;

constructor TiwgpuCommandBuffer.Create(const h: TWGPUCommandBuffer);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuCommandBuffer.Destroy;
begin
   inherited Destroy;
   wgpuCommandBufferRelease(FHandle);
end;

function TiwgpuCommandBuffer.GetHandle: TWGPUCommandBuffer;
begin
   Result := FHandle;
end;

procedure TiwgpuCommandBuffer.SetLabel(const aLabel: UTF8String);
begin
   wgpuCommandBufferSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuCommandBuffer.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuCommandBufferSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuCommandEncoder.Create(const h: TWGPUCommandEncoder);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuCommandEncoder.Destroy;
begin
   inherited Destroy;
   wgpuCommandEncoderRelease(FHandle);
end;

function TiwgpuCommandEncoder.GetHandle: TWGPUCommandEncoder;
begin
   Result := FHandle;
end;

function TiwgpuCommandEncoder.BeginComputePass(const aDescriptor: TWGPUComputePassDescriptor): IWGPUComputePassEncoder;
begin
   Result := TiwgpuComputePassEncoder.Create(wgpuCommandEncoderBeginComputePass(FHandle, @aDescriptor));
end;

function TiwgpuCommandEncoder.BeginRenderPass(const aDescriptor: TWGPURenderPassDescriptor): IWGPURenderPassEncoder;
begin
   Result := TiwgpuRenderPassEncoder.Create(wgpuCommandEncoderBeginRenderPass(FHandle, @aDescriptor));
end;

procedure TiwgpuCommandEncoder.ClearBuffer(const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
begin
   wgpuCommandEncoderClearBuffer(FHandle, aBuffer.GetHandle, aOffset, aSize);
end;

procedure TiwgpuCommandEncoder.CopyBufferToBuffer(const aSource: IWGPUBuffer; aSourceOffset: UInt64; const aDestination: IWGPUBuffer; aDestinationOffset: UInt64; aSize: UInt64);
begin
   wgpuCommandEncoderCopyBufferToBuffer(FHandle, aSource.GetHandle, aSourceOffset, aDestination.GetHandle, aDestinationOffset, aSize);
end;

procedure TiwgpuCommandEncoder.CopyBufferToTexture(const aSource: PWGPUImageCopyBuffer; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D);
begin
   wgpuCommandEncoderCopyBufferToTexture(FHandle, aSource, aDestination, aCopySize);
end;

procedure TiwgpuCommandEncoder.CopyTextureToBuffer(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyBuffer; const aCopySize: PWGPUExtent3D);
begin
   wgpuCommandEncoderCopyTextureToBuffer(FHandle, aSource, aDestination, aCopySize);
end;

procedure TiwgpuCommandEncoder.CopyTextureToTexture(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D);
begin
   wgpuCommandEncoderCopyTextureToTexture(FHandle, aSource, aDestination, aCopySize);
end;

function TiwgpuCommandEncoder.Finish(const aDescriptor: PWGPUCommandBufferDescriptor): IWGPUCommandBuffer;
begin
   Result := TiwgpuCommandBuffer.Create(wgpuCommandEncoderFinish(FHandle, @aDescriptor));
end;

procedure TiwgpuCommandEncoder.InjectValidationError(const aMessage: UTF8String);
begin
   wgpuCommandEncoderInjectValidationError(FHandle, Pointer(aMessage));
end;

procedure TiwgpuCommandEncoder.InjectValidationError2(const aMessage: TWGPUStringView);
begin
   wgpuCommandEncoderInjectValidationError2(FHandle, aMessage);
end;

procedure TiwgpuCommandEncoder.InsertDebugMarker(const aMarkerLabel: UTF8String);
begin
   wgpuCommandEncoderInsertDebugMarker(FHandle, Pointer(aMarkerLabel));
end;

procedure TiwgpuCommandEncoder.InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
begin
   wgpuCommandEncoderInsertDebugMarker2(FHandle, aMarkerLabel);
end;

procedure TiwgpuCommandEncoder.PopDebugGroup;
begin
   wgpuCommandEncoderPopDebugGroup(FHandle);
end;

procedure TiwgpuCommandEncoder.PushDebugGroup(const aGroupLabel: UTF8String);
begin
   wgpuCommandEncoderPushDebugGroup(FHandle, Pointer(aGroupLabel));
end;

procedure TiwgpuCommandEncoder.PushDebugGroup2(const aGroupLabel: TWGPUStringView);
begin
   wgpuCommandEncoderPushDebugGroup2(FHandle, aGroupLabel);
end;

procedure TiwgpuCommandEncoder.ResolveQuerySet(const aQuerySet: IWGPUQuerySet; aFirstQuery: UInt32; aQueryCount: UInt32; const aDestination: IWGPUBuffer; aDestinationOffset: UInt64);
begin
   wgpuCommandEncoderResolveQuerySet(FHandle, aQuerySet.GetHandle, aFirstQuery, aQueryCount, aDestination.GetHandle, aDestinationOffset);
end;

procedure TiwgpuCommandEncoder.SetLabel(const aLabel: UTF8String);
begin
   wgpuCommandEncoderSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuCommandEncoder.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuCommandEncoderSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuCommandEncoder.WriteBuffer(const aBuffer: IWGPUBuffer; aBufferOffset: UInt64; const aData: PUInt8; aSize: UInt64);
begin
   wgpuCommandEncoderWriteBuffer(FHandle, aBuffer.GetHandle, aBufferOffset, aData, aSize);
end;

procedure TiwgpuCommandEncoder.WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
begin
   wgpuCommandEncoderWriteTimestamp(FHandle, aQuerySet.GetHandle, aQueryIndex);
end;

constructor TiwgpuComputePassEncoder.Create(const h: TWGPUComputePassEncoder);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuComputePassEncoder.Destroy;
begin
   inherited Destroy;
   wgpuComputePassEncoderRelease(FHandle);
end;

function TiwgpuComputePassEncoder.GetHandle: TWGPUComputePassEncoder;
begin
   Result := FHandle;
end;

procedure TiwgpuComputePassEncoder.DispatchWorkgroups(aWorkgroupCountX: UInt32; aWorkgroupCountY: UInt32; aWorkgroupCountZ: UInt32);
begin
   wgpuComputePassEncoderDispatchWorkgroups(FHandle, aWorkgroupCountX, aWorkgroupCountY, aWorkgroupCountZ);
end;

procedure TiwgpuComputePassEncoder.DispatchWorkgroupsIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
begin
   wgpuComputePassEncoderDispatchWorkgroupsIndirect(FHandle, aIndirectBuffer.GetHandle, aIndirectOffset);
end;

procedure TiwgpuComputePassEncoder.&End;
begin
   wgpuComputePassEncoderEnd(FHandle);
end;

procedure TiwgpuComputePassEncoder.InsertDebugMarker(const aMarkerLabel: UTF8String);
begin
   wgpuComputePassEncoderInsertDebugMarker(FHandle, Pointer(aMarkerLabel));
end;

procedure TiwgpuComputePassEncoder.InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
begin
   wgpuComputePassEncoderInsertDebugMarker2(FHandle, aMarkerLabel);
end;

procedure TiwgpuComputePassEncoder.PopDebugGroup;
begin
   wgpuComputePassEncoderPopDebugGroup(FHandle);
end;

procedure TiwgpuComputePassEncoder.PushDebugGroup(const aGroupLabel: UTF8String);
begin
   wgpuComputePassEncoderPushDebugGroup(FHandle, Pointer(aGroupLabel));
end;

procedure TiwgpuComputePassEncoder.PushDebugGroup2(const aGroupLabel: TWGPUStringView);
begin
   wgpuComputePassEncoderPushDebugGroup2(FHandle, aGroupLabel);
end;

procedure TiwgpuComputePassEncoder.SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
begin
   wgpuComputePassEncoderSetBindGroup(FHandle, aGroupIndex, aGroup.GetHandle, aDynamicOffsetCount, aDynamicOffsets);
end;

procedure TiwgpuComputePassEncoder.SetLabel(const aLabel: UTF8String);
begin
   wgpuComputePassEncoderSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuComputePassEncoder.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuComputePassEncoderSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuComputePassEncoder.SetPipeline(const aPipeline: IWGPUComputePipeline);
begin
   wgpuComputePassEncoderSetPipeline(FHandle, aPipeline.GetHandle);
end;

procedure TiwgpuComputePassEncoder.WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
begin
   wgpuComputePassEncoderWriteTimestamp(FHandle, aQuerySet.GetHandle, aQueryIndex);
end;

constructor TiwgpuComputePipeline.Create(const h: TWGPUComputePipeline);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuComputePipeline.Destroy;
begin
   inherited Destroy;
   wgpuComputePipelineRelease(FHandle);
end;

function TiwgpuComputePipeline.GetHandle: TWGPUComputePipeline;
begin
   Result := FHandle;
end;

function TiwgpuComputePipeline.GetBindGroupLayout(aGroupIndex: UInt32): IWGPUBindGroupLayout;
begin
   Result := TiwgpuBindGroupLayout.Create(wgpuComputePipelineGetBindGroupLayout(FHandle, aGroupIndex));
end;

procedure TiwgpuComputePipeline.SetLabel(const aLabel: UTF8String);
begin
   wgpuComputePipelineSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuComputePipeline.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuComputePipelineSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuDevice.Create(const h: TWGPUDevice);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuDevice.Destroy;
begin
   inherited Destroy;
   wgpuDeviceRelease(FHandle);
end;

function TiwgpuDevice.GetHandle: TWGPUDevice;
begin
   Result := FHandle;
end;

function TiwgpuDevice.GetProcAddress(const aProcName: UTF8String): TWGPUProc;
begin
   Result := wgpuGetProcAddress(FHandle, Pointer(aProcName));
end;

function TiwgpuDevice.GetProcAddress2(const aProcName: TWGPUStringView): TWGPUProc;
begin
   Result := wgpuGetProcAddress2(FHandle, aProcName);
end;

function TiwgpuDevice.CreateBindGroup(const aDescriptor: TWGPUBindGroupDescriptor): IWGPUBindGroup;
begin
   Result := TiwgpuBindGroup.Create(wgpuDeviceCreateBindGroup(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateBindGroupLayout(const aDescriptor: TWGPUBindGroupLayoutDescriptor): IWGPUBindGroupLayout;
begin
   Result := TiwgpuBindGroupLayout.Create(wgpuDeviceCreateBindGroupLayout(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
begin
   Result := TiwgpuBuffer.Create(wgpuDeviceCreateBuffer(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateCommandEncoder(const aDescriptor: TWGPUCommandEncoderDescriptor): IWGPUCommandEncoder;
begin
   Result := TiwgpuCommandEncoder.Create(wgpuDeviceCreateCommandEncoder(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateComputePipeline(const aDescriptor: TWGPUComputePipelineDescriptor): IWGPUComputePipeline;
begin
   Result := TiwgpuComputePipeline.Create(wgpuDeviceCreateComputePipeline(FHandle, @aDescriptor));
end;

procedure TiwgpuDevice.CreateComputePipelineAsync(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallback: TWGPUCreateComputePipelineAsyncCallback; const aUserdata: Pointer);
begin
   wgpuDeviceCreateComputePipelineAsync(FHandle, @aDescriptor, aCallback, aUserdata);
end;

function TiwgpuDevice.CreateComputePipelineAsync2(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallbackInfo: TWGPUCreateComputePipelineAsyncCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuDeviceCreateComputePipelineAsync2(FHandle, @aDescriptor, aCallbackInfo);
end;

function TiwgpuDevice.CreateComputePipelineAsyncF(const aDescriptor: TWGPUComputePipelineDescriptor; const aCallbackInfo: TWGPUCreateComputePipelineAsyncCallbackInfo): TWGPUFuture;
begin
   Result := wgpuDeviceCreateComputePipelineAsyncF(FHandle, @aDescriptor, aCallbackInfo);
end;

function TiwgpuDevice.CreateErrorBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
begin
   Result := TiwgpuBuffer.Create(wgpuDeviceCreateErrorBuffer(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateErrorExternalTexture: IWGPUExternalTexture;
begin
   Result := TiwgpuExternalTexture.Create(wgpuDeviceCreateErrorExternalTexture(FHandle));
end;

function TiwgpuDevice.CreateErrorShaderModule(const aDescriptor: TWGPUShaderModuleDescriptor; const aErrorMessage: UTF8String): IWGPUShaderModule;
begin
   Result := TiwgpuShaderModule.Create(wgpuDeviceCreateErrorShaderModule(FHandle, @aDescriptor, Pointer(aErrorMessage)));
end;

function TiwgpuDevice.CreateErrorShaderModule2(const aDescriptor: TWGPUShaderModuleDescriptor; const aErrorMessage: TWGPUStringView): IWGPUShaderModule;
begin
   Result := TiwgpuShaderModule.Create(wgpuDeviceCreateErrorShaderModule2(FHandle, @aDescriptor, aErrorMessage));
end;

function TiwgpuDevice.CreateErrorTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
begin
   Result := TiwgpuTexture.Create(wgpuDeviceCreateErrorTexture(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateExternalTexture(const aExternalTextureDescriptor: TWGPUExternalTextureDescriptor): IWGPUExternalTexture;
begin
   Result := TiwgpuExternalTexture.Create(wgpuDeviceCreateExternalTexture(FHandle, @aExternalTextureDescriptor));
end;

function TiwgpuDevice.CreatePipelineLayout(const aDescriptor: TWGPUPipelineLayoutDescriptor): IWGPUPipelineLayout;
begin
   Result := TiwgpuPipelineLayout.Create(wgpuDeviceCreatePipelineLayout(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateQuerySet(const aDescriptor: TWGPUQuerySetDescriptor): IWGPUQuerySet;
begin
   Result := TiwgpuQuerySet.Create(wgpuDeviceCreateQuerySet(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateRenderBundleEncoder(const aDescriptor: TWGPURenderBundleEncoderDescriptor): IWGPURenderBundleEncoder;
begin
   Result := TiwgpuRenderBundleEncoder.Create(wgpuDeviceCreateRenderBundleEncoder(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateRenderPipeline(const aDescriptor: TWGPURenderPipelineDescriptor): IWGPURenderPipeline;
begin
   Result := TiwgpuRenderPipeline.Create(wgpuDeviceCreateRenderPipeline(FHandle, @aDescriptor));
end;

procedure TiwgpuDevice.CreateRenderPipelineAsync(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallback: TWGPUCreateRenderPipelineAsyncCallback; const aUserdata: Pointer);
begin
   wgpuDeviceCreateRenderPipelineAsync(FHandle, @aDescriptor, aCallback, aUserdata);
end;

function TiwgpuDevice.CreateRenderPipelineAsync2(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallbackInfo: TWGPUCreateRenderPipelineAsyncCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuDeviceCreateRenderPipelineAsync2(FHandle, @aDescriptor, aCallbackInfo);
end;

function TiwgpuDevice.CreateRenderPipelineAsyncF(const aDescriptor: TWGPURenderPipelineDescriptor; const aCallbackInfo: TWGPUCreateRenderPipelineAsyncCallbackInfo): TWGPUFuture;
begin
   Result := wgpuDeviceCreateRenderPipelineAsyncF(FHandle, @aDescriptor, aCallbackInfo);
end;

function TiwgpuDevice.CreateSampler(const aDescriptor: TWGPUSamplerDescriptor): IWGPUSampler;
begin
   Result := TiwgpuSampler.Create(wgpuDeviceCreateSampler(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateShaderModule(const aDescriptor: TWGPUShaderModuleDescriptor): IWGPUShaderModule;
begin
   Result := TiwgpuShaderModule.Create(wgpuDeviceCreateShaderModule(FHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateSwapChain(const aSurface: IWGPUSurface; const aDescriptor: TWGPUSwapChainDescriptor): IWGPUSwapChain;
begin
   Result := TiwgpuSwapChain.Create(wgpuDeviceCreateSwapChain(FHandle, aSurface.GetHandle, @aDescriptor));
end;

function TiwgpuDevice.CreateTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
begin
   Result := TiwgpuTexture.Create(wgpuDeviceCreateTexture(FHandle, @aDescriptor));
end;

function TiwgpuDevice.EnumerateFeatures(const aFeatures: PWGPUFeatureName): NativeUInt;
begin
   Result := wgpuDeviceEnumerateFeatures(FHandle, aFeatures);
end;

procedure TiwgpuDevice.ForceLoss(const aType: TWGPUDeviceLostReason; const aMessage: UTF8String);
begin
   wgpuDeviceForceLoss(FHandle, aType, Pointer(aMessage));
end;

procedure TiwgpuDevice.ForceLoss2(const aType: TWGPUDeviceLostReason; const aMessage: TWGPUStringView);
begin
   wgpuDeviceForceLoss2(FHandle, aType, aMessage);
end;

function TiwgpuDevice.GetAHardwareBufferProperties(const aHandle: Pointer; const aProperties: PWGPUAHardwareBufferProperties): TWGPUStatus;
begin
   Result := wgpuDeviceGetAHardwareBufferProperties(FHandle, aHandle, aProperties);
end;

function TiwgpuDevice.GetAdapter: IWGPUAdapter;
begin
   Result := TiwgpuAdapter.Create(wgpuDeviceGetAdapter(FHandle));
end;

function TiwgpuDevice.GetLimits(const aLimits: PWGPUSupportedLimits): TWGPUStatus;
begin
   Result := wgpuDeviceGetLimits(FHandle, aLimits);
end;

function TiwgpuDevice.GetQueue: IWGPUQueue;
begin
   Result := TiwgpuQueue.Create(wgpuDeviceGetQueue(FHandle));
end;

function TiwgpuDevice.GetSupportedSurfaceUsage(const aSurface: IWGPUSurface): TWGPUTextureUsage;
begin
   Result := wgpuDeviceGetSupportedSurfaceUsage(FHandle, aSurface.GetHandle);
end;

function TiwgpuDevice.HasFeature(const aFeature: TWGPUFeatureName): TWGPUBool;
begin
   Result := wgpuDeviceHasFeature(FHandle, aFeature);
end;

function TiwgpuDevice.ImportSharedBufferMemory(const aDescriptor: TWGPUSharedBufferMemoryDescriptor): IWGPUSharedBufferMemory;
begin
   Result := TiwgpuSharedBufferMemory.Create(wgpuDeviceImportSharedBufferMemory(FHandle, @aDescriptor));
end;

function TiwgpuDevice.ImportSharedFence(const aDescriptor: TWGPUSharedFenceDescriptor): IWGPUSharedFence;
begin
   Result := TiwgpuSharedFence.Create(wgpuDeviceImportSharedFence(FHandle, @aDescriptor));
end;

function TiwgpuDevice.ImportSharedTextureMemory(const aDescriptor: TWGPUSharedTextureMemoryDescriptor): IWGPUSharedTextureMemory;
begin
   Result := TiwgpuSharedTextureMemory.Create(wgpuDeviceImportSharedTextureMemory(FHandle, @aDescriptor));
end;

procedure TiwgpuDevice.InjectError(const aType: TWGPUErrorType; const aMessage: UTF8String);
begin
   wgpuDeviceInjectError(FHandle, aType, Pointer(aMessage));
end;

procedure TiwgpuDevice.InjectError2(const aType: TWGPUErrorType; const aMessage: TWGPUStringView);
begin
   wgpuDeviceInjectError2(FHandle, aType, aMessage);
end;

procedure TiwgpuDevice.PopErrorScope(const aOldCallback: TWGPUErrorCallback; const aUserdata: Pointer);
begin
   wgpuDevicePopErrorScope(FHandle, aOldCallback, aUserdata);
end;

function TiwgpuDevice.PopErrorScope2(const aCallbackInfo: TWGPUPopErrorScopeCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuDevicePopErrorScope2(FHandle, aCallbackInfo);
end;

function TiwgpuDevice.PopErrorScopeF(const aCallbackInfo: TWGPUPopErrorScopeCallbackInfo): TWGPUFuture;
begin
   Result := wgpuDevicePopErrorScopeF(FHandle, aCallbackInfo);
end;

procedure TiwgpuDevice.PushErrorScope(const aFilter: TWGPUErrorFilter);
begin
   wgpuDevicePushErrorScope(FHandle, aFilter);
end;

procedure TiwgpuDevice.SetDeviceLostCallback(const aCallback: TWGPUDeviceLostCallback; const aUserdata: Pointer);
begin
   wgpuDeviceSetDeviceLostCallback(FHandle, aCallback, aUserdata);
end;

procedure TiwgpuDevice.SetLabel(const aLabel: UTF8String);
begin
   wgpuDeviceSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuDevice.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuDeviceSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuDevice.SetLoggingCallback(const aCallback: TWGPULoggingCallback; const aUserdata: Pointer);
begin
   wgpuDeviceSetLoggingCallback(FHandle, aCallback, aUserdata);
end;

procedure TiwgpuDevice.SetUncapturedErrorCallback(const aCallback: TWGPUErrorCallback; const aUserdata: Pointer);
begin
   wgpuDeviceSetUncapturedErrorCallback(FHandle, aCallback, aUserdata);
end;

procedure TiwgpuDevice.Tick;
begin
   wgpuDeviceTick(FHandle);
end;

procedure TiwgpuDevice.ValidateTextureDescriptor(const aDescriptor: TWGPUTextureDescriptor);
begin
   wgpuDeviceValidateTextureDescriptor(FHandle, @aDescriptor);
end;

constructor TiwgpuExternalTexture.Create(const h: TWGPUExternalTexture);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuExternalTexture.Destroy;
begin
   inherited Destroy;
   wgpuExternalTextureRelease(FHandle);
end;

function TiwgpuExternalTexture.GetHandle: TWGPUExternalTexture;
begin
   Result := FHandle;
end;

procedure TiwgpuExternalTexture.Expire;
begin
   wgpuExternalTextureExpire(FHandle);
end;

procedure TiwgpuExternalTexture.Refresh;
begin
   wgpuExternalTextureRefresh(FHandle);
end;

procedure TiwgpuExternalTexture.SetLabel(const aLabel: UTF8String);
begin
   wgpuExternalTextureSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuExternalTexture.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuExternalTextureSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuInstance.Create(const h: TWGPUInstance);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuInstance.Destroy;
begin
   inherited Destroy;
   wgpuInstanceRelease(FHandle);
end;

function TiwgpuInstance.GetHandle: TWGPUInstance;
begin
   Result := FHandle;
end;

function TiwgpuInstance.CreateSurface(const aDescriptor: TWGPUSurfaceDescriptor): IWGPUSurface;
begin
   Result := TiwgpuSurface.Create(wgpuInstanceCreateSurface(FHandle, @aDescriptor));
end;

function TiwgpuInstance.EnumerateWGSLLanguageFeatures(const aFeatures: PWGPUWGSLFeatureName): NativeUInt;
begin
   Result := wgpuInstanceEnumerateWGSLLanguageFeatures(FHandle, aFeatures);
end;

function TiwgpuInstance.HasWGSLLanguageFeature(const aFeature: TWGPUWGSLFeatureName): TWGPUBool;
begin
   Result := wgpuInstanceHasWGSLLanguageFeature(FHandle, aFeature);
end;

procedure TiwgpuInstance.ProcessEvents;
begin
   wgpuInstanceProcessEvents(FHandle);
end;

procedure TiwgpuInstance.RequestAdapter(const aOptions: TWGPURequestAdapterOptions; const aCallback: TWGPURequestAdapterCallback; const aUserdata: Pointer);
begin
   wgpuInstanceRequestAdapter(FHandle, @aOptions, aCallback, aUserdata);
end;

function TiwgpuInstance.RequestAdapter2(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuInstanceRequestAdapter2(FHandle, @aOptions, aCallbackInfo);
end;

function TiwgpuInstance.RequestAdapterF(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo): TWGPUFuture;
begin
   Result := wgpuInstanceRequestAdapterF(FHandle, @aOptions, aCallbackInfo);
end;

function TiwgpuInstance.WaitAny(aFutureCount: NativeUInt; const aFutures: PWGPUFutureWaitInfo; aTimeoutNS: UInt64): TWGPUWaitStatus;
begin
   Result := wgpuInstanceWaitAny(FHandle, aFutureCount, aFutures, aTimeoutNS);
end;

constructor TiwgpuPipelineLayout.Create(const h: TWGPUPipelineLayout);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuPipelineLayout.Destroy;
begin
   inherited Destroy;
   wgpuPipelineLayoutRelease(FHandle);
end;

function TiwgpuPipelineLayout.GetHandle: TWGPUPipelineLayout;
begin
   Result := FHandle;
end;

procedure TiwgpuPipelineLayout.SetLabel(const aLabel: UTF8String);
begin
   wgpuPipelineLayoutSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuPipelineLayout.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuPipelineLayoutSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuQuerySet.Create(const h: TWGPUQuerySet);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuQuerySet.Destroy;
begin
   inherited Destroy;
   wgpuQuerySetRelease(FHandle);
end;

function TiwgpuQuerySet.GetHandle: TWGPUQuerySet;
begin
   Result := FHandle;
end;

function TiwgpuQuerySet.GetCount: UInt32;
begin
   Result := wgpuQuerySetGetCount(FHandle);
end;

function TiwgpuQuerySet.GetType: TWGPUQueryType;
begin
   Result := wgpuQuerySetGetType(FHandle);
end;

procedure TiwgpuQuerySet.SetLabel(const aLabel: UTF8String);
begin
   wgpuQuerySetSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuQuerySet.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuQuerySetSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuQueue.Create(const h: TWGPUQueue);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuQueue.Destroy;
begin
   inherited Destroy;
   wgpuQueueRelease(FHandle);
end;

function TiwgpuQueue.GetHandle: TWGPUQueue;
begin
   Result := FHandle;
end;

procedure TiwgpuQueue.CopyExternalTextureForBrowser(const aSource: PWGPUImageCopyExternalTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
begin
   wgpuQueueCopyExternalTextureForBrowser(FHandle, aSource, aDestination, aCopySize, @aOptions);
end;

procedure TiwgpuQueue.CopyTextureForBrowser(const aSource: PWGPUImageCopyTexture; const aDestination: PWGPUImageCopyTexture; const aCopySize: PWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
begin
   wgpuQueueCopyTextureForBrowser(FHandle, aSource, aDestination, aCopySize, @aOptions);
end;

procedure TiwgpuQueue.OnSubmittedWorkDone(const aCallback: TWGPUQueueWorkDoneCallback; const aUserdata: Pointer);
begin
   wgpuQueueOnSubmittedWorkDone(FHandle, aCallback, aUserdata);
end;

function TiwgpuQueue.OnSubmittedWorkDone2(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuQueueOnSubmittedWorkDone2(FHandle, aCallbackInfo);
end;

function TiwgpuQueue.OnSubmittedWorkDoneF(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo): TWGPUFuture;
begin
   Result := wgpuQueueOnSubmittedWorkDoneF(FHandle, aCallbackInfo);
end;

procedure TiwgpuQueue.SetLabel(const aLabel: UTF8String);
begin
   wgpuQueueSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuQueue.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuQueueSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuQueue.Submit(aCommandCount: NativeUInt; const aCommands: PWGPUCommandBuffer);
begin
   wgpuQueueSubmit(FHandle, aCommandCount, aCommands);
end;

procedure TiwgpuQueue.WriteBuffer(const aBuffer: IWGPUBuffer; aBufferOffset: UInt64; const aData: Pointer; aSize: NativeUInt);
begin
   wgpuQueueWriteBuffer(FHandle, aBuffer.GetHandle, aBufferOffset, aData, aSize);
end;

procedure TiwgpuQueue.WriteTexture(const aDestination: PWGPUImageCopyTexture; const aData: Pointer; aDataSize: NativeUInt; const aDataLayout: PWGPUTextureDataLayout; const aWriteSize: PWGPUExtent3D);
begin
   wgpuQueueWriteTexture(FHandle, aDestination, aData, aDataSize, aDataLayout, aWriteSize);
end;

constructor TiwgpuRenderBundle.Create(const h: TWGPURenderBundle);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuRenderBundle.Destroy;
begin
   inherited Destroy;
   wgpuRenderBundleRelease(FHandle);
end;

function TiwgpuRenderBundle.GetHandle: TWGPURenderBundle;
begin
   Result := FHandle;
end;

procedure TiwgpuRenderBundle.SetLabel(const aLabel: UTF8String);
begin
   wgpuRenderBundleSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuRenderBundle.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuRenderBundleSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuRenderBundleEncoder.Create(const h: TWGPURenderBundleEncoder);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuRenderBundleEncoder.Destroy;
begin
   inherited Destroy;
   wgpuRenderBundleEncoderRelease(FHandle);
end;

function TiwgpuRenderBundleEncoder.GetHandle: TWGPURenderBundleEncoder;
begin
   Result := FHandle;
end;

procedure TiwgpuRenderBundleEncoder.Draw(aVertexCount: UInt32; aInstanceCount: UInt32; aFirstVertex: UInt32; aFirstInstance: UInt32);
begin
   wgpuRenderBundleEncoderDraw(FHandle, aVertexCount, aInstanceCount, aFirstVertex, aFirstInstance);
end;

procedure TiwgpuRenderBundleEncoder.DrawIndexed(aIndexCount: UInt32; aInstanceCount: UInt32; aFirstIndex: UInt32; const aBaseVertex: Int32; aFirstInstance: UInt32);
begin
   wgpuRenderBundleEncoderDrawIndexed(FHandle, aIndexCount, aInstanceCount, aFirstIndex, aBaseVertex, aFirstInstance);
end;

procedure TiwgpuRenderBundleEncoder.DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
begin
   wgpuRenderBundleEncoderDrawIndexedIndirect(FHandle, aIndirectBuffer.GetHandle, aIndirectOffset);
end;

procedure TiwgpuRenderBundleEncoder.DrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
begin
   wgpuRenderBundleEncoderDrawIndirect(FHandle, aIndirectBuffer.GetHandle, aIndirectOffset);
end;

function TiwgpuRenderBundleEncoder.Finish(const aDescriptor: PWGPURenderBundleDescriptor): IWGPURenderBundle;
begin
   Result := TiwgpuRenderBundle.Create(wgpuRenderBundleEncoderFinish(FHandle, @aDescriptor));
end;

procedure TiwgpuRenderBundleEncoder.InsertDebugMarker(const aMarkerLabel: UTF8String);
begin
   wgpuRenderBundleEncoderInsertDebugMarker(FHandle, Pointer(aMarkerLabel));
end;

procedure TiwgpuRenderBundleEncoder.InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
begin
   wgpuRenderBundleEncoderInsertDebugMarker2(FHandle, aMarkerLabel);
end;

procedure TiwgpuRenderBundleEncoder.PopDebugGroup;
begin
   wgpuRenderBundleEncoderPopDebugGroup(FHandle);
end;

procedure TiwgpuRenderBundleEncoder.PushDebugGroup(const aGroupLabel: UTF8String);
begin
   wgpuRenderBundleEncoderPushDebugGroup(FHandle, Pointer(aGroupLabel));
end;

procedure TiwgpuRenderBundleEncoder.PushDebugGroup2(const aGroupLabel: TWGPUStringView);
begin
   wgpuRenderBundleEncoderPushDebugGroup2(FHandle, aGroupLabel);
end;

procedure TiwgpuRenderBundleEncoder.SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
begin
   wgpuRenderBundleEncoderSetBindGroup(FHandle, aGroupIndex, aGroup.GetHandle, aDynamicOffsetCount, aDynamicOffsets);
end;

procedure TiwgpuRenderBundleEncoder.SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; aOffset: UInt64; aSize: UInt64);
begin
   wgpuRenderBundleEncoderSetIndexBuffer(FHandle, aBuffer.GetHandle, aFormat, aOffset, aSize);
end;

procedure TiwgpuRenderBundleEncoder.SetLabel(const aLabel: UTF8String);
begin
   wgpuRenderBundleEncoderSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuRenderBundleEncoder.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuRenderBundleEncoderSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuRenderBundleEncoder.SetPipeline(const aPipeline: IWGPURenderPipeline);
begin
   wgpuRenderBundleEncoderSetPipeline(FHandle, aPipeline.GetHandle);
end;

procedure TiwgpuRenderBundleEncoder.SetVertexBuffer(aSlot: UInt32; const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
begin
   wgpuRenderBundleEncoderSetVertexBuffer(FHandle, aSlot, aBuffer.GetHandle, aOffset, aSize);
end;

constructor TiwgpuRenderPassEncoder.Create(const h: TWGPURenderPassEncoder);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuRenderPassEncoder.Destroy;
begin
   inherited Destroy;
   wgpuRenderPassEncoderRelease(FHandle);
end;

function TiwgpuRenderPassEncoder.GetHandle: TWGPURenderPassEncoder;
begin
   Result := FHandle;
end;

procedure TiwgpuRenderPassEncoder.BeginOcclusionQuery(aQueryIndex: UInt32);
begin
   wgpuRenderPassEncoderBeginOcclusionQuery(FHandle, aQueryIndex);
end;

procedure TiwgpuRenderPassEncoder.Draw(aVertexCount: UInt32; aInstanceCount: UInt32; aFirstVertex: UInt32; aFirstInstance: UInt32);
begin
   wgpuRenderPassEncoderDraw(FHandle, aVertexCount, aInstanceCount, aFirstVertex, aFirstInstance);
end;

procedure TiwgpuRenderPassEncoder.DrawIndexed(aIndexCount: UInt32; aInstanceCount: UInt32; aFirstIndex: UInt32; const aBaseVertex: Int32; aFirstInstance: UInt32);
begin
   wgpuRenderPassEncoderDrawIndexed(FHandle, aIndexCount, aInstanceCount, aFirstIndex, aBaseVertex, aFirstInstance);
end;

procedure TiwgpuRenderPassEncoder.DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
begin
   wgpuRenderPassEncoderDrawIndexedIndirect(FHandle, aIndirectBuffer.GetHandle, aIndirectOffset);
end;

procedure TiwgpuRenderPassEncoder.DrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64);
begin
   wgpuRenderPassEncoderDrawIndirect(FHandle, aIndirectBuffer.GetHandle, aIndirectOffset);
end;

procedure TiwgpuRenderPassEncoder.&End;
begin
   wgpuRenderPassEncoderEnd(FHandle);
end;

procedure TiwgpuRenderPassEncoder.EndOcclusionQuery;
begin
   wgpuRenderPassEncoderEndOcclusionQuery(FHandle);
end;

procedure TiwgpuRenderPassEncoder.ExecuteBundles(aBundleCount: NativeUInt; const aBundles: PWGPURenderBundle);
begin
   wgpuRenderPassEncoderExecuteBundles(FHandle, aBundleCount, aBundles);
end;

procedure TiwgpuRenderPassEncoder.InsertDebugMarker(const aMarkerLabel: UTF8String);
begin
   wgpuRenderPassEncoderInsertDebugMarker(FHandle, Pointer(aMarkerLabel));
end;

procedure TiwgpuRenderPassEncoder.InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
begin
   wgpuRenderPassEncoderInsertDebugMarker2(FHandle, aMarkerLabel);
end;

procedure TiwgpuRenderPassEncoder.MultiDrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64; aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; aDrawCountBufferOffset: UInt64);
begin
   wgpuRenderPassEncoderMultiDrawIndexedIndirect(FHandle, aIndirectBuffer.GetHandle, aIndirectOffset, aMaxDrawCount, aDrawCountBuffer.GetHandle, aDrawCountBufferOffset);
end;

procedure TiwgpuRenderPassEncoder.MultiDrawIndirect(const aIndirectBuffer: IWGPUBuffer; aIndirectOffset: UInt64; aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; aDrawCountBufferOffset: UInt64);
begin
   wgpuRenderPassEncoderMultiDrawIndirect(FHandle, aIndirectBuffer.GetHandle, aIndirectOffset, aMaxDrawCount, aDrawCountBuffer.GetHandle, aDrawCountBufferOffset);
end;

procedure TiwgpuRenderPassEncoder.PixelLocalStorageBarrier;
begin
   wgpuRenderPassEncoderPixelLocalStorageBarrier(FHandle);
end;

procedure TiwgpuRenderPassEncoder.PopDebugGroup;
begin
   wgpuRenderPassEncoderPopDebugGroup(FHandle);
end;

procedure TiwgpuRenderPassEncoder.PushDebugGroup(const aGroupLabel: UTF8String);
begin
   wgpuRenderPassEncoderPushDebugGroup(FHandle, Pointer(aGroupLabel));
end;

procedure TiwgpuRenderPassEncoder.PushDebugGroup2(const aGroupLabel: TWGPUStringView);
begin
   wgpuRenderPassEncoderPushDebugGroup2(FHandle, aGroupLabel);
end;

procedure TiwgpuRenderPassEncoder.SetBindGroup(aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: PUInt32);
begin
   wgpuRenderPassEncoderSetBindGroup(FHandle, aGroupIndex, aGroup.GetHandle, aDynamicOffsetCount, aDynamicOffsets);
end;

procedure TiwgpuRenderPassEncoder.SetBlendConstant(const aColor: PWGPUColor);
begin
   wgpuRenderPassEncoderSetBlendConstant(FHandle, aColor);
end;

procedure TiwgpuRenderPassEncoder.SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; aOffset: UInt64; aSize: UInt64);
begin
   wgpuRenderPassEncoderSetIndexBuffer(FHandle, aBuffer.GetHandle, aFormat, aOffset, aSize);
end;

procedure TiwgpuRenderPassEncoder.SetLabel(const aLabel: UTF8String);
begin
   wgpuRenderPassEncoderSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuRenderPassEncoder.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuRenderPassEncoderSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuRenderPassEncoder.SetPipeline(const aPipeline: IWGPURenderPipeline);
begin
   wgpuRenderPassEncoderSetPipeline(FHandle, aPipeline.GetHandle);
end;

procedure TiwgpuRenderPassEncoder.SetScissorRect(aX: UInt32; aY: UInt32; aWidth: UInt32; aHeight: UInt32);
begin
   wgpuRenderPassEncoderSetScissorRect(FHandle, aX, aY, aWidth, aHeight);
end;

procedure TiwgpuRenderPassEncoder.SetStencilReference(aReference: UInt32);
begin
   wgpuRenderPassEncoderSetStencilReference(FHandle, aReference);
end;

procedure TiwgpuRenderPassEncoder.SetVertexBuffer(aSlot: UInt32; const aBuffer: IWGPUBuffer; aOffset: UInt64; aSize: UInt64);
begin
   wgpuRenderPassEncoderSetVertexBuffer(FHandle, aSlot, aBuffer.GetHandle, aOffset, aSize);
end;

procedure TiwgpuRenderPassEncoder.SetViewport(const aX: Single; const aY: Single; const aWidth: Single; const aHeight: Single; const aMinDepth: Single; const aMaxDepth: Single);
begin
   wgpuRenderPassEncoderSetViewport(FHandle, aX, aY, aWidth, aHeight, aMinDepth, aMaxDepth);
end;

procedure TiwgpuRenderPassEncoder.WriteTimestamp(const aQuerySet: IWGPUQuerySet; aQueryIndex: UInt32);
begin
   wgpuRenderPassEncoderWriteTimestamp(FHandle, aQuerySet.GetHandle, aQueryIndex);
end;

constructor TiwgpuRenderPipeline.Create(const h: TWGPURenderPipeline);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuRenderPipeline.Destroy;
begin
   inherited Destroy;
   wgpuRenderPipelineRelease(FHandle);
end;

function TiwgpuRenderPipeline.GetHandle: TWGPURenderPipeline;
begin
   Result := FHandle;
end;

function TiwgpuRenderPipeline.GetBindGroupLayout(aGroupIndex: UInt32): IWGPUBindGroupLayout;
begin
   Result := TiwgpuBindGroupLayout.Create(wgpuRenderPipelineGetBindGroupLayout(FHandle, aGroupIndex));
end;

procedure TiwgpuRenderPipeline.SetLabel(const aLabel: UTF8String);
begin
   wgpuRenderPipelineSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuRenderPipeline.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuRenderPipelineSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuSampler.Create(const h: TWGPUSampler);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuSampler.Destroy;
begin
   inherited Destroy;
   wgpuSamplerRelease(FHandle);
end;

function TiwgpuSampler.GetHandle: TWGPUSampler;
begin
   Result := FHandle;
end;

procedure TiwgpuSampler.SetLabel(const aLabel: UTF8String);
begin
   wgpuSamplerSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuSampler.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuSamplerSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuShaderModule.Create(const h: TWGPUShaderModule);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuShaderModule.Destroy;
begin
   inherited Destroy;
   wgpuShaderModuleRelease(FHandle);
end;

function TiwgpuShaderModule.GetHandle: TWGPUShaderModule;
begin
   Result := FHandle;
end;

procedure TiwgpuShaderModule.GetCompilationInfo(const aCallback: TWGPUCompilationInfoCallback; const aUserdata: Pointer);
begin
   wgpuShaderModuleGetCompilationInfo(FHandle, aCallback, aUserdata);
end;

function TiwgpuShaderModule.GetCompilationInfo2(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo2): TWGPUFuture;
begin
   Result := wgpuShaderModuleGetCompilationInfo2(FHandle, aCallbackInfo);
end;

function TiwgpuShaderModule.GetCompilationInfoF(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo): TWGPUFuture;
begin
   Result := wgpuShaderModuleGetCompilationInfoF(FHandle, aCallbackInfo);
end;

procedure TiwgpuShaderModule.SetLabel(const aLabel: UTF8String);
begin
   wgpuShaderModuleSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuShaderModule.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuShaderModuleSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuSharedBufferMemory.Create(const h: TWGPUSharedBufferMemory);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuSharedBufferMemory.Destroy;
begin
   inherited Destroy;
   wgpuSharedBufferMemoryRelease(FHandle);
end;

function TiwgpuSharedBufferMemory.GetHandle: TWGPUSharedBufferMemory;
begin
   Result := FHandle;
end;

function TiwgpuSharedBufferMemory.BeginAccess(const aBuffer: IWGPUBuffer; const aDescriptor: TWGPUSharedBufferMemoryBeginAccessDescriptor): TWGPUStatus;
begin
   Result := wgpuSharedBufferMemoryBeginAccess(FHandle, aBuffer.GetHandle, @aDescriptor);
end;

function TiwgpuSharedBufferMemory.CreateBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
begin
   Result := TiwgpuBuffer.Create(wgpuSharedBufferMemoryCreateBuffer(FHandle, @aDescriptor));
end;

function TiwgpuSharedBufferMemory.EndAccess(const aBuffer: IWGPUBuffer; const aDescriptor: PWGPUSharedBufferMemoryEndAccessState): TWGPUStatus;
begin
   Result := wgpuSharedBufferMemoryEndAccess(FHandle, aBuffer.GetHandle, aDescriptor);
end;

function TiwgpuSharedBufferMemory.GetProperties(const aProperties: PWGPUSharedBufferMemoryProperties): TWGPUStatus;
begin
   Result := wgpuSharedBufferMemoryGetProperties(FHandle, aProperties);
end;

function TiwgpuSharedBufferMemory.IsDeviceLost: TWGPUBool;
begin
   Result := wgpuSharedBufferMemoryIsDeviceLost(FHandle);
end;

procedure TiwgpuSharedBufferMemory.SetLabel(const aLabel: UTF8String);
begin
   wgpuSharedBufferMemorySetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuSharedBufferMemory.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuSharedBufferMemorySetLabel2(FHandle, aLabel);
end;

constructor TiwgpuSharedFence.Create(const h: TWGPUSharedFence);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuSharedFence.Destroy;
begin
   inherited Destroy;
   wgpuSharedFenceRelease(FHandle);
end;

function TiwgpuSharedFence.GetHandle: TWGPUSharedFence;
begin
   Result := FHandle;
end;

procedure TiwgpuSharedFence.ExportInfo(const aInfo: PWGPUSharedFenceExportInfo);
begin
   wgpuSharedFenceExportInfo(FHandle, aInfo);
end;

constructor TiwgpuSharedTextureMemory.Create(const h: TWGPUSharedTextureMemory);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuSharedTextureMemory.Destroy;
begin
   inherited Destroy;
   wgpuSharedTextureMemoryRelease(FHandle);
end;

function TiwgpuSharedTextureMemory.GetHandle: TWGPUSharedTextureMemory;
begin
   Result := FHandle;
end;

function TiwgpuSharedTextureMemory.BeginAccess(const aTexture: IWGPUTexture; const aDescriptor: TWGPUSharedTextureMemoryBeginAccessDescriptor): TWGPUStatus;
begin
   Result := wgpuSharedTextureMemoryBeginAccess(FHandle, aTexture.GetHandle, @aDescriptor);
end;

function TiwgpuSharedTextureMemory.CreateTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
begin
   Result := TiwgpuTexture.Create(wgpuSharedTextureMemoryCreateTexture(FHandle, @aDescriptor));
end;

function TiwgpuSharedTextureMemory.EndAccess(const aTexture: IWGPUTexture; const aDescriptor: PWGPUSharedTextureMemoryEndAccessState): TWGPUStatus;
begin
   Result := wgpuSharedTextureMemoryEndAccess(FHandle, aTexture.GetHandle, aDescriptor);
end;

function TiwgpuSharedTextureMemory.GetProperties(const aProperties: PWGPUSharedTextureMemoryProperties): TWGPUStatus;
begin
   Result := wgpuSharedTextureMemoryGetProperties(FHandle, aProperties);
end;

function TiwgpuSharedTextureMemory.IsDeviceLost: TWGPUBool;
begin
   Result := wgpuSharedTextureMemoryIsDeviceLost(FHandle);
end;

procedure TiwgpuSharedTextureMemory.SetLabel(const aLabel: UTF8String);
begin
   wgpuSharedTextureMemorySetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuSharedTextureMemory.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuSharedTextureMemorySetLabel2(FHandle, aLabel);
end;

constructor TiwgpuSurface.Create(const h: TWGPUSurface);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuSurface.Destroy;
begin
   inherited Destroy;
   wgpuSurfaceRelease(FHandle);
end;

function TiwgpuSurface.GetHandle: TWGPUSurface;
begin
   Result := FHandle;
end;

procedure TiwgpuSurface.Configure(const aConfig: TWGPUSurfaceConfiguration);
begin
   wgpuSurfaceConfigure(FHandle, @aConfig);
end;

function TiwgpuSurface.GetCapabilities(const aAdapter: IWGPUAdapter; const aCapabilities: PWGPUSurfaceCapabilities): TWGPUStatus;
begin
   Result := wgpuSurfaceGetCapabilities(FHandle, aAdapter.GetHandle, aCapabilities);
end;

procedure TiwgpuSurface.GetCurrentTexture(const aSurfaceTexture: PWGPUSurfaceTexture);
begin
   wgpuSurfaceGetCurrentTexture(FHandle, aSurfaceTexture);
end;

function TiwgpuSurface.GetPreferredFormat(const aAdapter: IWGPUAdapter): TWGPUTextureFormat;
begin
   Result := wgpuSurfaceGetPreferredFormat(FHandle, aAdapter.GetHandle);
end;

procedure TiwgpuSurface.Present;
begin
   wgpuSurfacePresent(FHandle);
end;

procedure TiwgpuSurface.SetLabel(const aLabel: UTF8String);
begin
   wgpuSurfaceSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuSurface.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuSurfaceSetLabel2(FHandle, aLabel);
end;

procedure TiwgpuSurface.Unconfigure;
begin
   wgpuSurfaceUnconfigure(FHandle);
end;

constructor TiwgpuSwapChain.Create(const h: TWGPUSwapChain);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuSwapChain.Destroy;
begin
   inherited Destroy;
   wgpuSwapChainRelease(FHandle);
end;

function TiwgpuSwapChain.GetHandle: TWGPUSwapChain;
begin
   Result := FHandle;
end;

function TiwgpuSwapChain.GetCurrentTexture: IWGPUTexture;
begin
   Result := TiwgpuTexture.Create(wgpuSwapChainGetCurrentTexture(FHandle));
end;

function TiwgpuSwapChain.GetCurrentTextureView: IWGPUTextureView;
begin
   Result := TiwgpuTextureView.Create(wgpuSwapChainGetCurrentTextureView(FHandle));
end;

procedure TiwgpuSwapChain.Present;
begin
   wgpuSwapChainPresent(FHandle);
end;

constructor TiwgpuTexture.Create(const h: TWGPUTexture);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuTexture.Destroy;
begin
   inherited Destroy;
   wgpuTextureRelease(FHandle);
end;

function TiwgpuTexture.GetHandle: TWGPUTexture;
begin
   Result := FHandle;
end;

function TiwgpuTexture.CreateErrorView(const aDescriptor: TWGPUTextureViewDescriptor): IWGPUTextureView;
begin
   Result := TiwgpuTextureView.Create(wgpuTextureCreateErrorView(FHandle, @aDescriptor));
end;

function TiwgpuTexture.CreateView(const aDescriptor: TWGPUTextureViewDescriptor): IWGPUTextureView;
begin
   Result := TiwgpuTextureView.Create(wgpuTextureCreateView(FHandle, @aDescriptor));
end;

function TiwgpuTexture.GetDepthOrArrayLayers: UInt32;
begin
   Result := wgpuTextureGetDepthOrArrayLayers(FHandle);
end;

function TiwgpuTexture.GetDimension: TWGPUTextureDimension;
begin
   Result := wgpuTextureGetDimension(FHandle);
end;

function TiwgpuTexture.GetFormat: TWGPUTextureFormat;
begin
   Result := wgpuTextureGetFormat(FHandle);
end;

function TiwgpuTexture.GetHeight: UInt32;
begin
   Result := wgpuTextureGetHeight(FHandle);
end;

function TiwgpuTexture.GetMipLevelCount: UInt32;
begin
   Result := wgpuTextureGetMipLevelCount(FHandle);
end;

function TiwgpuTexture.GetSampleCount: UInt32;
begin
   Result := wgpuTextureGetSampleCount(FHandle);
end;

function TiwgpuTexture.GetUsage: TWGPUTextureUsage;
begin
   Result := wgpuTextureGetUsage(FHandle);
end;

function TiwgpuTexture.GetWidth: UInt32;
begin
   Result := wgpuTextureGetWidth(FHandle);
end;

procedure TiwgpuTexture.SetLabel(const aLabel: UTF8String);
begin
   wgpuTextureSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuTexture.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuTextureSetLabel2(FHandle, aLabel);
end;

constructor TiwgpuTextureView.Create(const h: TWGPUTextureView);
begin
   inherited Create;
   FHandle := h;
end;

destructor TiwgpuTextureView.Destroy;
begin
   inherited Destroy;
   wgpuTextureViewRelease(FHandle);
end;

function TiwgpuTextureView.GetHandle: TWGPUTextureView;
begin
   Result := FHandle;
end;

procedure TiwgpuTextureView.SetLabel(const aLabel: UTF8String);
begin
   wgpuTextureViewSetLabel(FHandle, Pointer(aLabel));
end;

procedure TiwgpuTextureView.SetLabel2(const aLabel: TWGPUStringView);
begin
   wgpuTextureViewSetLabel2(FHandle, aLabel);
end;

//
// WGPUFactory
//

class function WGPUFactory.CreateInstance(const aInstanceDescriptor : TWGPUInstanceDescriptor) : IWGPUInstance;
begin
   var instance := wgpuCreateInstance(@aInstanceDescriptor);
   Assert(instance <> nil, 'Failed to CreateInstance');
   Result := TiwgpuInstance.Create(instance);
end;

class function WGPUFactory.WrapAdapter(const aAdapter : TWGPUAdapter) : IWGPUAdapter;
begin
   Result := TiwgpuAdapter.Create(aAdapter);
end;
class function WGPUFactory.WrapDevice(const aDevice : TWGPUDevice) : IWGPUDevice;
begin
   Result := TiwgpuDevice.Create(aDevice);
end;

end.

