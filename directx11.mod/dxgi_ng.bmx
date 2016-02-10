SuperStrict

Import SRS.Win32
Import Pub.Win32
Import BRL.System

Import "dxgi_common.bmx"

Type DXGI_SWAP_CHAIN_DESC
	Field BufferDesc_Width:Int
	Field BufferDesc_Height:Int
	Field BufferDesc_RefreshRate_Numerator:Int
	Field BufferDesc_RefreshRate_Denominator:Int
	Field BufferDesc_Format:Int
	Field BufferDesc_ScanlineOrdering:Int
	Field BufferDesc_Scaling:Int
	Field SampleDesc_Count:Int
	Field SampleDesc_Quality:Int
	Field BufferUsage:Int
	Field BufferCount:Int
	Field OutputWindow:Byte Ptr
	Field Windowed:Int
	Field SwapEffect:Int
	Field Flags:Int
EndType

Extern"win32"

Interface IDXGIObject Extends IUnknown_
	Method SetPrivateData:Int(Name:Byte Ptr,DataSize:Int,pData:Byte Ptr)
	Method SetPrivateDataInterface:Int(Name:Byte Ptr,pUnknown:Byte Ptr)
	Method GetPrivateData:Int(Name:Byte Ptr,pDataSize:Int Var,pData:Byte Ptr)
	Method GetParent:Int(riid:Byte Ptr,ppParent:IUnknown_ Var)
EndInterface 

Interface IDXGIDeviceSubObject Extends IDXGIObject
	Method GetDevice:Int()
EndInterface 

Interface IDXGIResource Extends IDXGIDeviceSubObject
	Method GetSharedHandle:Int(pShareHandle:Byte Ptr Var)
	Method GetUsage:Int(pUsage:Int Var)
	Method SetEvictionPriority:Int(EvictionPriority:Int)
	Method GetEvictionPriority:Int(pEvictionPriority:Int Var)
EndInterface 

Interface IDXGIKeyedMutex Extends IDXGIDeviceSubObject
	Method AcquireSync:Int(Key:Long,dwMilliseconds:Int)
	Method ReleaseSync:Int(Key:Long)
EndInterface 

Interface IDXGISurface Extends IDXGIDeviceSubObject
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method Map:Int(pLockedRect:Byte Ptr,MapFlags:Int)
	Method UnMap:Int()
EndInterface 

Interface IDXGISurface1 Extends IDXGISurface
	Method GetDC:Int(Discard:Int,pHdc:Byte Ptr Var)
	Method ReleaseDC:Int(pDirectRect:Byte Ptr)
EndInterface 

Interface IDXGIAdapter Extends IDXGIObject
	Method EnumOutputs:Int(Output:Int,ppOutput:IDXGIOutput Var)
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method CheckInterfaceSupport:Int(InterfaceName:Byte Ptr,pUMDVersion:Long Var)
EndInterface

Interface IDXGIOutput Extends IDXGIObject
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetDisplayModeList:Int(EnumFormat:Int,Flags:Int,pNumModes:Int Var,pDesc:Byte Ptr)
	Method FindClosestMatchMode:Int(pModeToMatch:Byte Ptr,pClosestMatch:Byte Ptr,pConcernedDevice:Byte Ptr)
	Method WaitForVBlank:Int()
	Method TakeOwnership:Int(pDevice:Byte Ptr,Exclusive:Int)
	Method ReleaseOwnership:Int()
	Method GetGammaControlCapabilities:Int(pGammaCaps:Byte Ptr)
	Method SetGammaControl:Int(pArray:Byte Ptr)
	Method GetGammaControl:Int(pArray:Byte Ptr)
	Method SetDisplaySurface:Int(pScanoutSurface:Byte Ptr)
	Method GetDisplaySurfaceData:Int(pDestination:Byte Ptr)
	Method GetFrameStatistics:Int(pStats:Byte Ptr)
EndInterface 

Interface IDXGISwapChain Extends IDXGIDeviceSubObject
	Method Present:Int(SyncInterval:Int,Flags:Int)
	Method GetBuffer:Int(Buffer:Int,riid:Byte Ptr,ppSurface:IUnknown_ Var)
	Method SetFullscreenState:Int(FullScreen:Int,pTarget:IDXGIOutput)
	Method GetFullscreenState:Int(pFullScreen:Int Var,ppTarget:IDXGIOutput Var)
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method ResizeBuffers:Int(BufferCount:Int,Width:Int,Hieght:Int,NewFormat:Int,SwapChainFlags:Int)
	Method ResizeTarget:Int(pNewTargetParameters:Byte Ptr)
	Method GetContainingOutput:Int(ppOutput:IDXGIOutput Var)
	Method GetFrameStatistics:Int(pStats:Byte Ptr)
	Method GetLastPresentCount:Int(pLastPresentCount:Int Var)
EndInterface 

Interface IDXGIFactory Extends IDXGIObject
	Method EnumAdapters:Int(Adapter:Int,ppAdapter:IDXGIAdapter Var)
	Method MakeWindowAssociation:Int(WindowHandle:Byte Ptr,Flags:Int)
	Method GetWindowAssociation:Int(pWindowHandle:Byte Ptr Var)
	Method CreateSwapChain:Int(pDevice:IUnknown_,pDesc:Byte Ptr,ppSwapChain:IDXGISwapChain Var)
	Method CreateSoftwareAdapter:Int(Module_:Byte Ptr,ppAdapter:IDXGIAdapter Var)
EndInterface 

Interface IDXGIDevice Extends IDXGIObject
	Method GetAdapter:Int(pAdapter:IDXGIAdapter Var)
	Method CreateSurface:Int(pDesc:Byte Ptr,NumSurfaces:Int,Usage:Int,pSharedResource:Int,ppSurface:IDXGISurface Var)
	Method QueryResourceResidency:Int(ppRresource:Byte Ptr,pResidencyStatus:Int Var,NumResources:Int)
	Method SetGPUThreadPriority:Int(Priority:Int)
	Method GetGPUThreadPriority:Int(pPriority:Int Var)
EndInterface 

Interface IDXGIFactory1 Extends IDXGIFactory
	Method EnumAdapters1:Int(Adapter:Int,ppAdapter:IDXGIAdapter1)
	Method IsCurrent:Int()
EndInterface 

Interface IDXGIAdapter1 Extends IDXGIAdapter
	Method GetDesc1:Int(pDesc:Byte Ptr)
EndInterface 

Interface IDXGIDevice1 Extends IDXGIDevice
	Method SetMaximumFrameLatency:Int(MaxLatency:Int)
	Method GetMaximumFrameLatency:Int(pMaxLatency:Int Var)
EndInterface 

EndExtern

Global _DXGI:Byte Ptr = LoadLibraryW("dxgi.dll")
If Not _DXGI Return False

Global IID_IDXGIFactory:Int[]=[$7b7166ec,$44ae21c7,$aec91ab2,$69e31a32]
Global IID_IDXGIAdapter:Int[]=[$2411e7e1,$4ccf12ac,$989714bd,$c04d53e8]
Global IID_IDXGIDevice:Int[]= [$54ec77fa,$44e61377,$fd88328c,$4cc8445f]

Global CreateDXGIFactory:Byte Ptr(riid:Byte Ptr,ppFactory:IDXGIFactory Var)"win32" = GetProcAddress(_DXGI,"CreateDXGIFactory")