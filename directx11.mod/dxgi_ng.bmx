Strict

Import SRS.Win32
Import Pub.Win32
Import BRL.System

Import "dxgi_common.bmx"

Type DXGI_SWAP_CHAIN_DESC
	Field BufferDesc_Width
	Field BufferDesc_Height
	Field BufferDesc_RefreshRate_Numerator
	Field BufferDesc_RefreshRate_Denominator
	Field BufferDesc_Format
	Field BufferDesc_ScanlineOrdering
	Field BufferDesc_Scaling
	Field SampleDesc_Count
	Field SampleDesc_Quality
	Field BufferUsage
	Field BufferCount
	Field OutputWindow:Byte Ptr
	Field Windowed
	Field SwapEffect
	Field Flags
EndType

Extern"win32"

Interface IDXGIObject Extends IUnknown_
	Method SetPrivateData(Name:Byte Ptr,DataSize,pData:Byte Ptr)
	Method SetPrivateDataInterface(Name:Byte Ptr,pUnknown:Byte Ptr)
	Method GetPrivateData(Name:Byte Ptr,pDataSize:Int Var,pData:Byte Ptr)
	Method GetParent(riid:Byte Ptr,ppParent:IUnknown_ Var)
EndInterface 

Interface IDXGIDeviceSubObject Extends IDXGIObject
	Method GetDevice()
EndInterface 

Interface IDXGIResource Extends IDXGIDeviceSubObject
	Method GetSharedHandle(pShareHandle:Byte Ptr Var)
	Method GetUsage(pUsage:Int Var)
	Method SetEvictionPriority(EvictionPriority)
	Method GetEvictionPriority(pEvictionPriority:Int Var)
EndInterface 

Interface IDXGIKeyedMutex Extends IDXGIDeviceSubObject
	Method AcquireSync(Key:Long,dwMilliseconds:Int)
	Method ReleaseSync(Key:Long)
EndInterface 

Interface IDXGISurface Extends IDXGIDeviceSubObject
	Method GetDesc(pDesc:Byte Ptr)
	Method Map(pLockedRect:Byte Ptr,MpaFlags)
	Method UnMap()
EndInterface 

Interface IDXGISurface1 Extends IDXGISurface
	Method GetDC(Discard,pHdc:Byte Ptr Var)
	Method ReleaseDC(pDirectRect:Byte Ptr)
EndInterface 

Interface IDXGIAdapter Extends IDXGIObject
	Method EnumOutputs(Output,ppOutput:IDXGIOutput Var)
	Method GetDesc(pDesc:Byte Ptr)
	Method CheckInterfaceSupport(InterfaceName:Byte Ptr,pUMDVersion:Long Var)
EndInterface

Interface IDXGIOutput Extends IDXGIObject
	Method GetDesc(pDesc:Byte Ptr)
	Method GetDisplayModeList(EnumFormat,Flags,pNumModes:Int Var,pDesc:Byte Ptr)
	Method FindClosestMatchMode(pModeToMatch:Byte Ptr,pClosestMatch:Byte Ptr,pConcernedDevice:Byte Ptr)
	Method WaitForVBlank()
	Method TakeOwnership(pDevice:Byte Ptr,Exclusive)
	Method ReleaseOwnership()
	Method GetGammaControlCapabilities(pGammaCaps:Byte Ptr)
	Method SetGammaControl(pArray:Byte Ptr)
	Method GetGammaControl(pArray:Byte Ptr)
	Method SetDisplaySurface(pScanoutSurface:Byte Ptr)
	Method GetDisplaySurfaceData(pDestination:Byte Ptr)
	Method GetFrameStatistics(pStats:Byte Ptr)
EndInterface 

Interface IDXGISwapChain Extends IDXGIDeviceSubObject
	Method Present(SyncInterval,Flags)
	Method GetBuffer(Buffer,riid:Byte Ptr,ppSurface:IUnknown_ Var)
	Method SetFullscreenState(FullScreen,pTarget:IDXGIOutput)
	Method GetFullscreenState(pFullScreen Var,ppTarget:IDXGIOutput Var)
	Method GetDesc(pDesc:Byte Ptr)
	Method ResizeBuffers(BufferCount,Width,Hieght,NewFormat,SwapChainFlags)
	Method ResizeTarget(pNewTargetParameters:Byte Ptr)
	Method GetContainingOutput(ppOutput:IDXGIOutput Var)
	Method GetFrameStatistics(pStats:Byte Ptr)
	Method GetLastPresentCount(pLastPresentCount:Int Var)
EndInterface 

Interface IDXGIFactory Extends IDXGIObject
	Method EnumAdapters(Adapter,ppAdapter:IDXGIAdapter Var)
	Method MakeWindowAssociation(WindowHandle:Byte Ptr,Flags)
	Method GetWindowAssociation(pWindowHandle:Byte Ptr Var)
	Method CreateSwapChain(pDevice:IUnknown_,pDesc:Byte Ptr,ppSwapChain:IDXGISwapChain Var)
	Method CreateSoftwareAdapter(Module_:Byte Ptr,ppAdapter:IDXGIAdapter Var)
EndInterface 

Interface IDXGIDevice Extends IDXGIObject
	Method GetAdapter(pAdapter:IDXGIAdapter Var)
	Method CreateSurface(pDesc:Byte Ptr,NumSurfaces,Usage,pSharedResource,ppSurface:IDXGISurface Var)
	Method QueryResourceResidency(ppRresource:Byte Ptr,pResidencyStatus:Int Var,NumResources)
	Method SetGPUThreadPriority(Priority)
	Method GetGPUThreadPriority(pPriority:Int Var)
EndInterface 

Interface IDXGIFactory1 Extends IDXGIFactory
	Method EnumAdapters1(Adapter,ppAdapter:IDXGIAdapter1)
	Method IsCurrent()
EndInterface 

Interface IDXGIAdapter1 Extends IDXGIAdapter
	Method GetDesc1(pDesc:Byte Ptr)
EndInterface 

Interface IDXGIDevice1 Extends IDXGIDevice
	Method SetMaximumFrameLatency(MaxLatency)
	Method GetMaximumFrameLatency(pMaxLatency:Int Var)
EndInterface 

EndExtern

Global _DXGI:Byte Ptr = LoadLibraryW("dxgi.dll")
If Not _DXGI Return

Global IID_IDXGIFactory[]=[$7b7166ec,$44ae21c7,$aec91ab2,$69e31a32]
Global IID_IDXGIAdapter[]=[$2411e7e1,$4ccf12ac,$989714bd,$c04d53e8]
Global IID_IDXGIDevice[]= [$54ec77fa,$44e61377,$fd88328c,$4cc8445f]

Global CreateDXGIFactory:Byte Ptr(riid:Byte Ptr,ppFactory:IDXGIFactory Var)"win32" = GetProcAddress(_DXGI,"CreateDXGIFactory")