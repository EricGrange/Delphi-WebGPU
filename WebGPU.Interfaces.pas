// WARNING: experimental and auto-generated, for comments only, not for use (yet)
//
unit WebGPU.Interfaces;

interface

type
	IWGPUAdapter = interface
		['{EF23B10E-8B6E-2044-D3F0-0FC89A2141C9}']
		function CreateDevice(const aDescriptor: TWGPUDeviceDescriptor): IWGPUDevice;
		function EnumerateFeatures(const aFeatures: PWGPUFeatureName): NativeUInt;
		function GetFormatCapabilities(const aFormat: TWGPUTextureFormat; const aCapabilities: PWGPUFormatCapabilities): TWGPUStatus;
		function GetInfo(const aInfo: PWGPUAdapterInfo): TWGPUStatus;
		function GetInstance: IWGPUInstance;
		function GetLimits(const aLimits: PWGPUSupportedLimits): TWGPUStatus;
		function GetProperties(const aProperties: PWGPUAdapterProperties): TWGPUStatus;
		function HasFeature(const aFeature: TWGPUFeatureName): TWGPUBool;
		procedure RequestDevice(const aDescriptor: TWGPUDeviceDescriptor; const aCallback: TWGPURequestDeviceCallback; const aUserdata: Pointer);
		function RequestDevice2(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo2): TWGPUFuture;
		function RequestDeviceF(const aOptions: TWGPUDeviceDescriptor; const aCallbackInfo: TWGPURequestDeviceCallbackInfo): TWGPUFuture;
	end;

	IWGPUAdapterInfo = interface
		['{493A0566-F066-DCE2-F17F-EC4874204709}']
		procedure FreeMembers;
	end;

	IWGPUAdapterProperties = interface
		['{CEB78544-D526-A6BF-A3D6-88D0ED6E2190}']
		procedure FreeMembers;
	end;

	IWGPUAdapterPropertiesMemoryHeaps = interface
		['{1EFCC814-9AF8-271A-6F4D-3640D25CF34E}']
		procedure FreeMembers;
	end;

	IWGPUBindGroup = interface
		['{4F7692CD-D873-5E0E-D182-0165EBF70A08}']
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUBindGroupLayout = interface
		['{9E5830F4-8237-8781-456F-06134F2ACE2C}']
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUBuffer = interface
		['{6FC46489-F0E8-72EC-11FB-7E5935592B2A}']
		function GetConstMappedRange(const aOffset: NativeUInt; const aSize: NativeUInt): Pointer;
		function GetMapState: TWGPUBufferMapState;
		function GetMappedRange(const aOffset: NativeUInt; const aSize: NativeUInt): Pointer;
		function GetSize: UInt64;
		function GetUsage: TWGPUBufferUsage;
		procedure MapAsync(const aMode: TWGPUMapMode; const aOffset: NativeUInt; const aSize: NativeUInt; const aCallback: TWGPUBufferMapCallback; const aUserdata: Pointer);
		function MapAsync2(const aMode: TWGPUMapMode; const aOffset: NativeUInt; const aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo2): TWGPUFuture;
		function MapAsyncF(const aMode: TWGPUMapMode; const aOffset: NativeUInt; const aSize: NativeUInt; const aCallbackInfo: TWGPUBufferMapCallbackInfo): TWGPUFuture;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
		procedure Unmap;
	end;

	IWGPUCommandBuffer = interface
		['{236B7E47-CC75-9118-0CA6-FE9A9AE1F74D}']
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUCommandEncoder = interface
		['{164CAC2F-76B4-7E3E-A25E-5EAE1600611F}']
		function BeginComputePass(const aDescriptor: TWGPUComputePassDescriptor): IWGPUComputePassEncoder;
		function BeginRenderPass(const aDescriptor: TWGPURenderPassDescriptor): IWGPURenderPassEncoder;
		procedure ClearBuffer(const aBuffer: IWGPUBuffer; const aOffset: UInt64; const aSize: UInt64);
		procedure CopyBufferToBuffer(const aSource: IWGPUBuffer; const aSourceOffset: UInt64; const aDestination: IWGPUBuffer; const aDestinationOffset: UInt64; const aSize: UInt64);
		procedure CopyBufferToTexture(const aSource: TWGPUImageCopyBuffer; const aDestination: TWGPUImageCopyTexture; const aCopySize: TWGPUExtent3D);
		procedure CopyTextureToBuffer(const aSource: TWGPUImageCopyTexture; const aDestination: TWGPUImageCopyBuffer; const aCopySize: TWGPUExtent3D);
		procedure CopyTextureToTexture(const aSource: TWGPUImageCopyTexture; const aDestination: TWGPUImageCopyTexture; const aCopySize: TWGPUExtent3D);
		function Finish(const aDescriptor: TWGPUCommandBufferDescriptor): IWGPUCommandBuffer;
		procedure InjectValidationError(const aMessage: UTF8String);
		procedure InjectValidationError2(const aMessage: TWGPUStringView);
		procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
		procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
		procedure PopDebugGroup;
		procedure PushDebugGroup(const aGroupLabel: UTF8String);
		procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
		procedure ResolveQuerySet(const aQuerySet: IWGPUQuerySet; const aFirstQuery: UInt32; const aQueryCount: UInt32; const aDestination: IWGPUBuffer; const aDestinationOffset: UInt64);
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
		procedure WriteBuffer(const aBuffer: IWGPUBuffer; const aBufferOffset: UInt64; const aData: TUInt8; const aSize: UInt64);
		procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; const aQueryIndex: UInt32);
	end;

	IWGPUComputePassEncoder = interface
		['{5717E3EE-0FD8-7D10-DD8F-5E82183A3C20}']
		procedure DispatchWorkgroups(const aWorkgroupCountX: UInt32; const aWorkgroupCountY: UInt32; const aWorkgroupCountZ: UInt32);
		procedure DispatchWorkgroupsIndirect(const aIndirectBuffer: IWGPUBuffer; const aIndirectOffset: UInt64);
		procedure End;
		procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
		procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
		procedure PopDebugGroup;
		procedure PushDebugGroup(const aGroupLabel: UTF8String);
		procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
		procedure SetBindGroup(const aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; const aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: TUInt32);
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
		procedure SetPipeline(const aPipeline: IWGPUComputePipeline);
		procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; const aQueryIndex: UInt32);
	end;

	IWGPUComputePipeline = interface
		['{D4CA07D2-FB2A-C067-A9E4-91F3403606A4}']
		function GetBindGroupLayout(const aGroupIndex: UInt32): IWGPUBindGroupLayout;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUDevice = interface
		['{5C020B62-26AA-E9DA-55D6-93B84ECEA57A}']
		function ;(const aProcName: UTF8String): TWGPUProc;
		function ;(const aProcName: TWGPUStringView): TWGPUProc;
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

	IWGPUDrmFormatCapabilities = interface
		['{FF88FE99-966E-EA3E-1140-9411E3B66E44}']
		procedure FreeMembers;
	end;

	IWGPUExternalTexture = interface
		['{0E1115A9-86F4-5155-65D6-5F010585CDF6}']
		procedure Expire;
		procedure Refresh;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUInstance = interface
		['{F1B8469C-6F36-DB74-B653-F2D1B7538413}']
		function CreateSurface(const aDescriptor: TWGPUSurfaceDescriptor): IWGPUSurface;
		function EnumerateWGSLLanguageFeatures(const aFeatures: PWGPUWGSLFeatureName): NativeUInt;
		function HasWGSLLanguageFeature(const aFeature: TWGPUWGSLFeatureName): TWGPUBool;
		procedure ProcessEvents;
		procedure RequestAdapter(const aOptions: TWGPURequestAdapterOptions; const aCallback: TWGPURequestAdapterCallback; const aUserdata: Pointer);
		function RequestAdapter2(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo2): TWGPUFuture;
		function RequestAdapterF(const aOptions: TWGPURequestAdapterOptions; const aCallbackInfo: TWGPURequestAdapterCallbackInfo): TWGPUFuture;
		function WaitAny(const aFutureCount: NativeUInt; const aFutures: PWGPUFutureWaitInfo; const aTimeoutNS: UInt64): TWGPUWaitStatus;
	end;

	IWGPUPipelineLayout = interface
		['{0B34D626-DCF4-7857-60A4-BA3D77C942B3}']
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUQuerySet = interface
		['{EB6DCE87-D4CC-8C4C-F6A4-CDA5E4488E6C}']
		function GetCount: UInt32;
		function GetType: TWGPUQueryType;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUQueue = interface
		['{4CBE6E56-BD36-266F-EEF2-D54D52FE5869}']
		procedure CopyExternalTextureForBrowser(const aSource: TWGPUImageCopyExternalTexture; const aDestination: TWGPUImageCopyTexture; const aCopySize: TWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
		procedure CopyTextureForBrowser(const aSource: TWGPUImageCopyTexture; const aDestination: TWGPUImageCopyTexture; const aCopySize: TWGPUExtent3D; const aOptions: TWGPUCopyTextureForBrowserOptions);
		procedure OnSubmittedWorkDone(const aCallback: TWGPUQueueWorkDoneCallback; const aUserdata: Pointer);
		function OnSubmittedWorkDone2(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo2): TWGPUFuture;
		function OnSubmittedWorkDoneF(const aCallbackInfo: TWGPUQueueWorkDoneCallbackInfo): TWGPUFuture;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
		procedure Submit(const aCommandCount: NativeUInt; const aCommands: TWGPUCommandBuffer);
		procedure WriteBuffer(const aBuffer: IWGPUBuffer; const aBufferOffset: UInt64; const aData: Tointer; const aSize: NativeUInt);
		procedure WriteTexture(const aDestination: TWGPUImageCopyTexture; const aData: Tointer; const aDataSize: NativeUInt; const aDataLayout: TWGPUTextureDataLayout; const aWriteSize: TWGPUExtent3D);
	end;

	IWGPURenderBundle = interface
		['{62CFDD16-CFEF-9D6B-B8B8-EC7C813247D8}']
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPURenderBundleEncoder = interface
		['{1DE4BD41-8BB4-6B2D-D0F9-5B641D6283FC}']
		procedure Draw(const aVertexCount: UInt32; const aInstanceCount: UInt32; const aFirstVertex: UInt32; const aFirstInstance: UInt32);
		procedure DrawIndexed(const aIndexCount: UInt32; const aInstanceCount: UInt32; const aFirstIndex: UInt32; const aBaseVertex: Int32; const aFirstInstance: UInt32);
		procedure DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; const aIndirectOffset: UInt64);
		procedure DrawIndirect(const aIndirectBuffer: IWGPUBuffer; const aIndirectOffset: UInt64);
		function Finish(const aDescriptor: TWGPURenderBundleDescriptor): IWGPURenderBundle;
		procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
		procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
		procedure PopDebugGroup;
		procedure PushDebugGroup(const aGroupLabel: UTF8String);
		procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
		procedure SetBindGroup(const aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; const aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: TUInt32);
		procedure SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; const aOffset: UInt64; const aSize: UInt64);
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
		procedure SetPipeline(const aPipeline: IWGPURenderPipeline);
		procedure SetVertexBuffer(const aSlot: UInt32; const aBuffer: IWGPUBuffer; const aOffset: UInt64; const aSize: UInt64);
	end;

	IWGPURenderPassEncoder = interface
		['{36C89154-C8D5-1E4C-BC9D-3D9325DFAF9B}']
		procedure BeginOcclusionQuery(const aQueryIndex: UInt32);
		procedure Draw(const aVertexCount: UInt32; const aInstanceCount: UInt32; const aFirstVertex: UInt32; const aFirstInstance: UInt32);
		procedure DrawIndexed(const aIndexCount: UInt32; const aInstanceCount: UInt32; const aFirstIndex: UInt32; const aBaseVertex: Int32; const aFirstInstance: UInt32);
		procedure DrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; const aIndirectOffset: UInt64);
		procedure DrawIndirect(const aIndirectBuffer: IWGPUBuffer; const aIndirectOffset: UInt64);
		procedure End;
		procedure EndOcclusionQuery;
		procedure ExecuteBundles(const aBundleCount: NativeUInt; const aBundles: TWGPURenderBundle);
		procedure InsertDebugMarker(const aMarkerLabel: UTF8String);
		procedure InsertDebugMarker2(const aMarkerLabel: TWGPUStringView);
		procedure MultiDrawIndexedIndirect(const aIndirectBuffer: IWGPUBuffer; const aIndirectOffset: UInt64; const aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; const aDrawCountBufferOffset: UInt64);
		procedure MultiDrawIndirect(const aIndirectBuffer: IWGPUBuffer; const aIndirectOffset: UInt64; const aMaxDrawCount: UInt32; const aDrawCountBuffer: IWGPUBuffer; const aDrawCountBufferOffset: UInt64);
		procedure PixelLocalStorageBarrier;
		procedure PopDebugGroup;
		procedure PushDebugGroup(const aGroupLabel: UTF8String);
		procedure PushDebugGroup2(const aGroupLabel: TWGPUStringView);
		procedure SetBindGroup(const aGroupIndex: UInt32; const aGroup: IWGPUBindGroup; const aDynamicOffsetCount: NativeUInt; const aDynamicOffsets: TUInt32);
		procedure SetBlendConstant(const aColor: TWGPUColor);
		procedure SetIndexBuffer(const aBuffer: IWGPUBuffer; const aFormat: TWGPUIndexFormat; const aOffset: UInt64; const aSize: UInt64);
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
		procedure SetPipeline(const aPipeline: IWGPURenderPipeline);
		procedure SetScissorRect(const aX: UInt32; const aY: UInt32; const aWidth: UInt32; const aHeight: UInt32);
		procedure SetStencilReference(const aReference: UInt32);
		procedure SetVertexBuffer(const aSlot: UInt32; const aBuffer: IWGPUBuffer; const aOffset: UInt64; const aSize: UInt64);
		procedure SetViewport(const aX: Single; const aY: Single; const aWidth: Single; const aHeight: Single; const aMinDepth: Single; const aMaxDepth: Single);
		procedure WriteTimestamp(const aQuerySet: IWGPUQuerySet; const aQueryIndex: UInt32);
	end;

	IWGPURenderPipeline = interface
		['{54B16051-8009-561C-74DD-9E4DB3461191}']
		function GetBindGroupLayout(const aGroupIndex: UInt32): IWGPUBindGroupLayout;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUSampler = interface
		['{CC574ADD-E54C-F740-ECCF-8F3063233408}']
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUShaderModule = interface
		['{4CD3FBBA-8F0C-7203-F991-549B9034BE77}']
		procedure GetCompilationInfo(const aCallback: TWGPUCompilationInfoCallback; const aUserdata: Pointer);
		function GetCompilationInfo2(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo2): TWGPUFuture;
		function GetCompilationInfoF(const aCallbackInfo: TWGPUCompilationInfoCallbackInfo): TWGPUFuture;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUSharedBufferMemory = interface
		['{E6D9BCD6-F3CC-C067-E33A-093C6D0FFBF5}']
		function BeginAccess(const aBuffer: IWGPUBuffer; const aDescriptor: TWGPUSharedBufferMemoryBeginAccessDescriptor): TWGPUStatus;
		function CreateBuffer(const aDescriptor: TWGPUBufferDescriptor): IWGPUBuffer;
		function EndAccess(const aBuffer: IWGPUBuffer; const aDescriptor: PWGPUSharedBufferMemoryEndAccessState): TWGPUStatus;
		function GetProperties(const aProperties: PWGPUSharedBufferMemoryProperties): TWGPUStatus;
		function IsDeviceLost: TWGPUBool;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUSharedBufferMemoryEndAccessState = interface
		['{C0A023D0-0DD2-1C7A-C828-ACCDEBF30575}']
		procedure FreeMembers;
	end;

	IWGPUSharedFence = interface
		['{37AF18F5-47F4-C274-5509-855D8D609392}']
		procedure ExportInfo(const aInfo: PWGPUSharedFenceExportInfo);
	end;

	IWGPUSharedTextureMemory = interface
		['{B5C272BE-10AD-2E36-346D-180B924B4AC6}']
		function BeginAccess(const aTexture: IWGPUTexture; const aDescriptor: TWGPUSharedTextureMemoryBeginAccessDescriptor): TWGPUStatus;
		function CreateTexture(const aDescriptor: TWGPUTextureDescriptor): IWGPUTexture;
		function EndAccess(const aTexture: IWGPUTexture; const aDescriptor: PWGPUSharedTextureMemoryEndAccessState): TWGPUStatus;
		function GetProperties(const aProperties: PWGPUSharedTextureMemoryProperties): TWGPUStatus;
		function IsDeviceLost: TWGPUBool;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

	IWGPUSharedTextureMemoryEndAccessState = interface
		['{99C23DA9-29ED-E958-ADB6-996E069F5BD1}']
		procedure FreeMembers;
	end;

	IWGPUSurface = interface
		['{8452B981-4E40-3147-AF59-71F11D12A43C}']
		procedure Configure(const aConfig: TWGPUSurfaceConfiguration);
		function GetCapabilities(const aAdapter: IWGPUAdapter; const aCapabilities: PWGPUSurfaceCapabilities): TWGPUStatus;
		procedure GetCurrentTexture(const aSurfaceTexture: PWGPUSurfaceTexture);
		function GetPreferredFormat(const aAdapter: IWGPUAdapter): TWGPUTextureFormat;
		procedure Present;
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
		procedure Unconfigure;
	end;

	IWGPUSurfaceCapabilities = interface
		['{B5E69716-6E5E-46EF-9FD2-7AC9FCA243E6}']
		procedure FreeMembers;
	end;

	IWGPUSwapChain = interface
		['{B04973B1-5BFA-1BB3-40F9-701E79FDF390}']
		function GetCurrentTexture: IWGPUTexture;
		function GetCurrentTextureView: IWGPUTextureView;
		procedure Present;
	end;

	IWGPUTexture = interface
		['{13DB8189-BFB9-23F7-C715-19710FB0C5B6}']
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
		procedure SetLabel(const aLabel: UTF8String);
		procedure SetLabel2(const aLabel: TWGPUStringView);
	end;

implementation

end.
