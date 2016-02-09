Strict

Import Pub.Win32
Import BRL.System

Import "dxgi_common.bmx"

Extern"win32"

Type IDXGIObject Extends IUnknown
	Method SetPrivateData(Name:Byte Ptr,DataSize,pData:Byte Ptr)
	Method SetPrivateDataInterface(Name:Byte Ptr,pUnknown:Byte Ptr)
	Method GetPrivateData(Name:Byte Ptr,pDataSize:Int Var,pData:Byte Ptr)
	Method GetParent(riid:Byte Ptr,ppParent:IUnknown Var)
EndType

Type IDXGIDeviceSubObject Extends IDXGIObject
	Method GetDevice()
EndType

Type IDXGIResource Extends IDXGIDeviceSubObject
	Method GetSharedHandle()
	Method GetUsage()
	Method SetEvictionPriority()
	Method GetEvictionPriority()
EndType

Type IDXGIKeyedMutex Extends IDXGIDeviceSubObject
	Method AcquireSync()
	Method ReleaseSync()
EndType

Type IDXGISurface Extends IDXGIDeviceSubObject
	Method GetDesc()
	Method Map()
	Method UnMap()
EndType

Type IDXGISurface1 Extends IDXGISurface
	Method GetDC()
	Method ReleaseDC()
EndType

Type IDXGIAdapter Extends IDXGIObject
	Method EnumOutputs(Output,ppOutput:IDXGIOutput Var)
	Method GetDesc(pDesc:Byte Ptr)
	Method CheckInterfaceSupport(InterfaceName:Byte Ptr,pUMDVersion:Byte Ptr)
EndType

Type IDXGIOutput Extends IDXGIObject
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
EndType

Type IDXGISwapChain Extends IDXGIDeviceSubObject
	Method Present(SyncInterval,Flags)
	Method GetBuffer(Buffer,riid:Byte Ptr,ppSurface:IUnknown Var)
	Method SetFullscreenState(FullScreen,pTarget:Byte Ptr)
	Method GetFullscreenState(pFullScreen Var,ppTarget:IDXGIOutput Var)
	Method GetDesc(pDesc:Byte Ptr)
	Method ResizeBuffers(BufferCount,Width,Hieght,NewFormat,SwapChainFlags)
	Method ResizeTarget(pNewTargetParameters:Byte Ptr)
	Method GetContainingOutput(ppOutput:IDXGIOutput Var)
	Method GetFrameStatistics(pStats:Byte Ptr)
	Method GetLastPresentCount(pLastPresentCount:Int Var)
EndType

Type IDXGIFactory Extends IDXGIObject
	Method EnumAdapters(Adapter,ppAdapter:IDXGIAdapter Var)
	Method MakeWindowAssociation(WindowHandle,Flags)
	Method GetWindowAssociation(pWindowHandle:Int Var)
	Method CreateSwapChain(pDevice:Byte Ptr,pDesc:Byte Ptr,ppSwapChain:IDXGISwapChain Var)
	Method CreateSoftwareAdapter(Module_,ppAdapter:IDXGIAdapter Var)
EndType

Type IDXGIDevice Extends IDXGIObject
	Method GetAdapter()
	Method CreateSurface()
	Method QueryResourceResidency()
	Method SetGPUThreadPriority()
	Method GetGPUThreadPriority()
EndType

Type IDXGIFactory1 Extends IDXGIFactory
	Method EnumAdapters1()
	Method IsCurrent()
EndType

Type IDXGIAdapter1 Extends IDXGIAdapter
	Method GetDesc1()
EndType

Type IDXGIDevice1 Extends IDXGIDevice
	Method SetMaximumFrameLatency()
	Method GetMaximumFrameLatency()
EndType

EndExtern

Global _DXGI = LoadLibraryA("dxgi.dll")
If Not _DXGI Return

Global IID_IDXGIFactory[]=[$7b7166ec,$44ae21c7,$aec91ab2,$69e31a32]
Global IID_IDXGIAdapter[]=[$2411e7e1,$4ccf12ac,$989714bd,$c04d53e8]
Global IID_IDXGIDevice[]= [$54ec77fa,$44e61377,$fd88328c,$4cc8445f]

Global CreateDXGIFactory(riid:Byte Ptr,ppFactory:IDXGIFactory Var)"win32" = GetProcAddress(_DXGI,"CreateDXGIFactory")