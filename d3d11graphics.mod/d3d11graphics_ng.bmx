SuperStrict

Import BRL.SystemDefault
Import BRL.Graphics
Import BRL.LinkedList
Import BRL.Retro
Import SRS.Win32
Import PUB.Win32
Import SRS.DirectX11

?Win32
Import "DeviceModeSettings.c"

Private

Extern
Function Dx11Max2D_EnumDisplaySettings:Int(iModeNum:Int,pMode:Byte Ptr)
EndExtern

Global _graphics:TD3D11Graphics
Global _driver:TD3D11GraphicsDriver
Global _wndclass$ = "BBDX11Device Window Class"

Global _modes:TGraphicsMode[]
Global _d3d11dev:ID3D11Device
Global _d3d11devcon:ID3D11DeviceContext
Global _query:ID3D11Query
Global _release:TList
Global _windowed:Int
Global _fps:Int
Global _d3d11Refs:Int
Global _featurelevel:Int[1]

Type TD3D11Release
	Field unk:IUnknown_
EndType

Function D3D11WndProc:Byte Ptr( hwnd:Byte Ptr,MSG:Int,wp:Byte Ptr,lp:Byte Ptr )"win32"
	bbSystemEmitOSEvent hwnd,MSG,wp,lp,Null

	Select MSG
	Case WM_CLOSE
		Return 0
	Case WM_SYSKEYDOWN
		If wp<>KEY_F4 Return 0
		
	Case WM_ACTIVATE
		If _graphics _graphics.Reactivate(wp)
		Return 0
	EndSelect

	Return DefWindowProcW( hwnd,MSG,wp,lp )
End Function

Function CreateD3D11Device:Int()
	If _d3d11Refs
		_d3d11Refs:+1
		Return True
	EndIf
		
	Local CreationFlag:Int = D3D11_CREATE_DEVICE_SINGLETHREADED
	'?DEBUG
	'	CreationFlag :| D3D11_CREATE_DEVICE_DEBUG
	'?
	If D3D11CreateDevice(Null,D3D_DRIVER_TYPE_HARDWARE,Null,CreationFlag,Null,0,D3D11_SDK_VERSION,_d3d11dev,_featurelevel,_d3d11devcon)<0
		Throw "Critical Error!~nCannot create D3D11Device"
	EndIf
	
	If _FeatureLevel[0] < D3D_FEATURE_LEVEL_10_0
		Throw	"Critical Error!~n"+..
				"Make sure your GPU is Dx10/Dx11 compatible or~n"+..
				"Make sure you have the latest drivers for your GPU."
	EndIf
	
	'QUERY
	Local _querydesc:D3D11_QUERY_DESC = New D3D11_QUERY_DESC
	_querydesc.Query = D3D11_QUERY_EVENT
	
	If _d3d11dev.CreateQuery(_querydesc,_query)<0
		Throw "Critical Error!~nCannot create device query!"
	EndIf
	_d3d11devcon.Begin _query
	
	If Not _release _release = New TList
	
	_d3d11Refs:+1
	Return True
EndFunction

Function CloseD3D11Device()
	_d3d11Refs:-1
	
	If _d3d11Refs Return
	
	For Local ar:TD3D11Release = EachIn _release
		If ar.unk ar.unk.Release_
	Next
	_release.Clear
	_release = Null

	If _query _query.Release_
	
	If _d3d11devcon _d3d11devcon.ClearState
	
	If _d3d11devcon _d3d11devcon.Release_
	If _d3d11dev _d3d11dev.Release_
	
	_query = Null
	_d3d11devcon = Null
	_d3d11dev = Null
EndFunction

Public

Function D3D11GetFeatureLevel:Int()
	Return _featurelevel[0]
EndFunction

Type TD3D11Graphics Extends TGraphics
	Field _width:Int
	Field _height:Int
	Field _depth:Int
	Field _hertz:Int
	Field _flags:Int
	Field _hwnd:Byte Ptr
	Field _attached:Int
	Field _swapchain:IDXGISwapChain
	Field _sd:DXGI_SWAP_CHAIN_DESC
	Field _rendertargetview:ID3D11RenderTargetView

	Method GetDirect3DDevice:ID3D11Device()
		Return _d3d11dev
	EndMethod
	
	Method GetDirect3DDeviceContext:ID3D11DeviceContext()
		Return _d3d11devcon
	EndMethod
	
	'TGraphics
	Method Driver:TD3D11GraphicsDriver()
		Return _driver
	EndMethod
	
	'TGraphics
	Method GetSettings:Int( width:Int Var,height:Int Var,depth:Int Var,hertz:Int Var,flags:Int Var)
		width = _width
		height = _height
		depth = _depth
		hertz = _hertz
		flags = _flags
	EndMethod
	
	'TGraphics
	Method Close:Int()
		If Not _hwnd Return 0
	
		If _swapchain _swapchain.SetFullScreenState False,Null
		
		If _rendertargetview _rendertargetview.Release_
		If _swapchain _swapchain.Release_

		CloseD3D11Device
		
		If Not _attached DestroyWindow(_hwnd)
		_hwnd = Null
		
		_windowed = False
	EndMethod
	
	Method Attach:TD3D11Graphics( hwnd:Byte Ptr ,flags:Int )
		Local rect:Int[4]
		GetClientRect hwnd,rect
		Local width:Int = rect[2]-rect[0]
		Local height:Int = rect[3]-rect[1]
		
		CreateD3D11Device()
		CreateSwapChain(hwnd,width,height,0,0,flags)

		_hwnd=hwnd
		_width=width
		_height=height
		_flags=flags
		_attached=True
		
		Return Self
	EndMethod
	
	Method Create:TD3D11Graphics(width:Int,height:Int,depth:Int,hertz:Int,flags:Int)
		If _depth Return Null 'Already have a window thats full screen

		'register wndclass
		Local wc:WNDCLASSW=New WNDCLASSW
		wc.SethInstance(GetModuleHandleW( Null ))
		wc.SetlpfnWndProc(D3D11WndProc)
		wc.SethCursor(LoadCursorW( Null,Short Ptr IDC_ARROW ))
		
		Local classname:Short Ptr = _wndclass.ToWString()
		wc.SetlpszClassName(classname)
		RegisterClassW wc.classptr
		MemFree classname

		'Create the window
		Local wstyle:Int = WS_VISIBLE|WS_POPUP

		'centre window on screen
		Local rect:Int[4]
		If Not depth
			wstyle = WS_VISIBLE|WS_CAPTION|WS_SYSMENU|WS_MINIMIZEBOX

			Local desktoprect:Int[4]

			GetWindowRect( GetDesktopWindow() , desktoprect )

			rect[0]=desktopRect[2]/2-width/2		
			rect[1]=desktopRect[3]/2-height/2
			rect[2]=rect[0]+width
			rect[3]=rect[1]+height

			AdjustWindowRect rect,wstyle,0

			_windowed = True
		Else
			rect[2] = width
			rect[3] = height

			_windowed = False
		EndIf

		Local hwnd:Byte Ptr =CreateWindowExW( 0,_wndClass,AppTitle,wstyle,rect[0],rect[1],rect[2]-rect[0],rect[3]-rect[1],0,0,GetModuleHandleW(Null),Null )
		If Not hwnd Return Null

		If Not CreateD3D11Device()
			DestroyWindow hwnd
			Return Null
		EndIf

		If Not depth
			GetClientRect hwnd,rect
			width=rect[2]-rect[0]
			height=rect[3]-rect[1]
		EndIf

		If Not _depth
			CreateSwapChain(hwnd,width,height,depth,hertz,flags)
		EndIf

		_hwnd=hwnd
		_width=width
		_height=height
		_depth=depth
		_hertz=hertz
		_flags=flags

		Return Self
	EndMethod
	
	Method CreateSwapChain(hwnd:Byte Ptr,width:Int,height:Int,depth:Int,hertz:Int,flags:Int)
		Local FullScreenTarget:TGraphicsMode
		Local numerator:Int = 0

		If depth
			Local index:Int
			For Local i:TGraphicsMode = EachIn GraphicsModes()
				If width = i.Width
					If height = i.height
						If depth = i.depth
							If hertz = i.hertz
								FullScreenTarget = _modes[index]
								Exit
							EndIf
						EndIf
					EndIf
				EndIf
				
				index:+1
			Next
		EndIf

		_sd = New DXGI_SWAP_CHAIN_DESC
		_sd.BufferCount = 1 'MSDN conflicting information on this parameter
		_sd.BufferDesc_Width = width
		_sd.BufferDesc_Height = height
	
		If depth And FullScreenTarget
			_sd.BufferDesc_Format = DXGI_FORMAT_R8G8B8A8_UNORM
			_sd.BufferDesc_RefreshRate_Numerator = FullscreenTarget.Hertz
			_sd.BufferDesc_RefreshRate_Denominator = 1
			_sd.BufferDesc_Scaling = 0
			_sd.BufferDesc_ScanlineOrdering = 0
		Else
			_sd.BufferDesc_Format = DXGI_FORMAT_R8G8B8A8_UNORM 'Standard 32bit display
			_sd.BufferDesc_RefreshRate_Numerator = 0
			_sd.BufferDesc_RefreshRate_Denominator = 1
			_sd.BufferDesc_Scaling = 0
			_sd.BufferDesc_ScanlineOrdering = 0
		EndIf

		_sd.Windowed = _windowed

		_sd.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT
		_sd.OutputWindow = hwnd
		_sd.SwapEffect = DXGI_SWAP_EFFECT_DISCARD
		_sd.Flags = DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH
		_sd.SampleDesc_Count = 1
		_sd.SampleDesc_Quality = 0

		Local Factory:IDXGIFactory
		Local Adapter:IDXGIAdapter
		Local Device:IDXGIDevice
	
		_d3d11dev.QueryInterface(IID_IDXGIDevice,Device)
		Device.GetParent(IID_IDXGIAdapter,Adapter)
		Adapter.GetParent(IID_IDXGIFactory,Factory)

		If Factory.CreateSwapChain(_d3d11dev,_sd,_swapchain)<0
			Throw "Critical Error!~nCannot create swap chain"
		EndIf
		
		If depth
			_swapchain.SetFullscreenState(True,Null)
		EndIf
		
		Factory.MakeWindowAssociation(hwnd,DXGI_MWA_NO_WINDOW_CHANGES)
		Device.Release_
		Adapter.Release_
		Factory.Release_

		'Create a rendertarget
		Local pBackBuffer:ID3D11Texture2D
		If _swapchain.GetBuffer(0,IID_ID3D11Texture2D,pBackBuffer)<0
			Throw "Critical Error!~nCannot create backbuffer"
		EndIf
		
		If _d3d11dev.CreateRenderTargetView(pBackBuffer,Null,_rendertargetview)<0
			Throw "Critical Error!~nCannot create RenderTargetView for rendering"
		EndIf

		If pBackBuffer pBackBuffer.Release_()
		pBackBuffer = Null

		_d3d11devcon.OMSetRenderTargets(1,Varptr _rendertargetview,Null)

		'Create a viewport
		Local vp:D3D11_VIEWPORT = New D3D11_VIEWPORT
		vp.Width = width
		vp.Height = height
		vp.MinDepth = 0.0
		vp.MaxDepth = 1.0
		vp.TopLeftX = 0.0
		vp.TopLeftY = 0.0
		_d3d11devcon.RSSetViewports(1,vp)
	EndMethod
	
	Method Flip( sync:Int )
		If sync
			_swapchain.Present(1,0)
		Else
			_swapchain.Present(0,0)
		EndIf
	EndMethod
	
	Method GetRenderTarget:ID3D11RenderTargetView()
		Return _renderTargetView
	EndMethod
	
	Method GetFeatureLevel:Int()
		Return _FeatureLevel[0]
	EndMethod

	Method Reactivate(wp:Byte Ptr)
		If Not _windowed
			If _swapchain _swapchain.SetFullscreenState(Int wp,Null)
			If Not wp ShowWindow _hwnd,SW_MINIMIZE				
		EndIf
	EndMethod

	Method AddRelease(unk:IUnknown_)
		Local ar:TD3D11Release = New TD3D11Release
		ar.unk = unk
		_release.AddLast ar
	EndMethod
EndType

Type TD3D11GraphicsDriver Extends TGraphicsDriver
	Method Create:TD3D11GraphicsDriver()
		Local _Factory:IDXGIFactory
		Local _Adapter:IDXGIAdapter
		Local _Output:IDXGIOutput
		Local _Device:IDXGIDevice
		Local _SupportLevels:Int[]
		
		If Not _d3d11 Return Null
		If Not _DXGI Return Null
		If Not _d3dcompiler Return Null

		'BUG FIX -	There's a bug in IDXGIAdapter.CheckInterfaceSupport incorrectly returning
		'			that some valid DX11 cards don't support DX11.
		_SupportLevels = [D3D_FEATURE_LEVEL_11_0,D3D_FEATURE_LEVEL_10_1,D3D_FEATURE_LEVEL_10_0]
		If D3D11CreateDevice(Null,D3D_DRIVER_TYPE_HARDWARE,Null,D3D11_CREATE_DEVICE_SINGLETHREADED,..
							_SupportLevels,3,D3D11_SDK_VERSION,_d3d11dev,Varptr _featureLevel[0],_d3d11devcon)<0
			Return Null
		EndIf
		
		'Use the native Windows API to get the correct number of display modes available
		'Dx11 API is inconsistent with HDTVs
		Local Mode:Int[4]
		Local ModeNum:Int,Result:Int = -1
		
		While Result <> 0
			Local ModeFound:Int = False	
			Result = Dx11Max2D_EnumDisplaySettings(ModeNum,Mode)
			
			'Don't include duplicates
			For Local GMode:TGraphicsMode = EachIn _modes
				If (Mode[0] = GMode.Width) And (Mode[1] = GMode.Height) ..
					And (Mode[2] = GMode.Depth) And (Mode[3] = GMode.Hertz)
			
					ModeFound = True
					ModeNum :+ 1
					Exit
				EndIf
			Next

			If Not ModeFound	
				_modes = _modes[.._modes.Length + 1]
				_modes[_modes.Length-1] = New TGraphicsMode

				Local AllModes:TGraphicsMode[] = _modes
				
				_modes[_modes.Length-1].Width = Mode[0]
				_modes[_modes.Length-1].Height = Mode[1]
				_modes[_modes.Length-1].Depth = Mode[2]
				_modes[_modes.Length-1].Hertz = Mode[3]
		
				ModeNum :+ 1
			EndIf
		Wend

		'BUGFIX:
		'Part of IDXGIAdapter.CheckInterfaceSupport work-around
		If _Device _Device.Release_
		If _d3d11devcon 
			_d3d11devcon.Release_
			_d3d11devcon = Null
		EndIf
		If _d3d11dev
			_d3d11dev.Release_
			_d3d11dev = Null
		EndIf
		
		Return Self
	EndMethod
	
	'TGraphicsDriver
	Method GraphicsModes:TGraphicsMode[]()
		Return _modes
	EndMethod
	
	Method AttachGraphics:TD3D11Graphics( hwnd:Byte Ptr , flags:Int )
		Return New TD3D11Graphics.Attach( hwnd , flags )
	EndMethod
	
	Method CreateGraphics:TD3D11Graphics( width:Int,height:Int,depth:Int,hertz:Int,flags:Int )
		Return New TD3D11Graphics.Create(width,height,depth,hertz,flags)
	EndMethod
	
	Method SetGraphics:Int( g:TGraphics )
		_graphics = TD3D11Graphics( g )
	
		If _graphics
			Local vp:D3D11_VIEWPORT = New D3D11_VIEWPORT
			vp.Width = _graphics._width
			vp.Height = _graphics._height
			vp.MinDepth = 0.0
			vp.MaxDepth = 1.0
			vp.TopLeftX = 0.0
			vp.TopLeftY = 0.0
			_d3d11devcon.RSSetViewports(1,vp)

			_d3d11devcon.OMSetRenderTargets(1,Varptr _graphics._rendertargetview,Null)
		EndIf
	EndMethod
	
	Method Flip:Int( sync:Int )
		_graphics.Flip( sync )
		
		'Render lag fix
		If Not _windowed
			_d3d11devcon.End_(_query)
			Local queryData:Int
			While _d3d11devcon.GetData(_query,Varptr queryData,4,0) = 1
			Wend
		EndIf
	EndMethod
EndType

Function D3D11GraphicsDriver:TD3D11GraphicsDriver()
	Global _doneD3D11:Int
	If Not _doneD3D11
		_driver = New TD3D11GraphicsDriver.Create()
		If _driver _doneD3D11 = True
	EndIf

	Return _driver
EndFunction


'EXPERIMENTAL...............
Function D3D11ShowAllSupportedFeatures(InFormat:Int=0)
	Function YesNo$(value:Int)
		If value Return "Yes"
		Return "No"
	EndFunction
	
	Function CheckThreading()
		Local pThreading:D3D11_FEATURE_DATA_THREADING = New D3D11_FEATURE_DATA_THREADING
		
		If _d3d11dev.CheckFeatureSupport(D3D11_FEATURE_THREADING,pThreading,8)<0
			WriteStdout "WARNING:-~n_d3d11dev.CheckFeatureSupport - D3D11_FEATURE_THREADING : FAILED~n"
			Return
		EndIf
		
		WriteStdout "~nMultiThreading:-~n"
		WriteStdout "   DriverConcurrentCreates - "+YesNo(pThreading.DriverConcurrentCreates)+"~n"
		WriteStdout "   DriverCommandLists - "+YesNo(pThreading.DriverCommandLists)+"~n~n"
	EndFunction

	Function CheckDataDoubles()
		Local pDoubles:D3D11_FEATURE_DATA_DOUBLES = New D3D11_FEATURE_DATA_DOUBLES
		
		If _d3d11dev.CheckFeatureSupport(D3D11_FEATURE_DOUBLES,pDoubles,4)<0
			WriteStdout "WARNING:-~n_d3d11dev.CheckFeatureSupport - D3D11_FEATURE_DOUBLES : FAILED~n"
			Return
		EndIf

		WriteStdout "DataDoubles:-~n"
		WriteStdout "   DoublePrecisionFloatShaderOps - "+YesNo(pDoubles.DoublePrecisionFloatShaderOps)+"~n~n"
	EndFunction
	
	Function CheckD3D10XHardwareOptions()
		Local pD3D10XOptions:D3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS = New D3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS
		
		If _d3d11dev.CheckFeatureSupport(D3D11_FEATURE_D3D10_X_HARDWARE_OPTIONS,pD3D10XOptions,4)<0
			WriteStdout "WARNING:-~n_d3d11dev.CheckFeatureSupport - D3D10_HARDWARE_OPTIONS : FAILED~n"
			Return
		EndIf
		
		WriteStdout "D3D10XHardwareOptions:-~n"
		WriteStdout "   ComputeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x - "+YesNo(pD3D10XOptions.ComputeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x)+"~n~n"
	EndFunction
	
	Function CheckDataFormat(InFormat:Int)
		Local pFormatSupport:D3D11_FEATURE_DATA_FORMAT_SUPPORT = New D3D11_FEATURE_DATA_FORMAT_SUPPORT

		pFormatSupport.InFormat = InFormat
		_d3d11dev.CheckFeatureSupport(D3D11_FEATURE_FORMAT_SUPPORT,pFormatSupport,8)
		
		WriteStdout "DataFormat:-~n"
		WriteStdout EnumSupportFormat(pFormatSupport.OutFormatSupport)

		_d3d11dev.CheckFeatureSupport(D3D11_FEATURE_FORMAT_SUPPORT2,pFormatSupport,8)
		
		WriteStdout "DataFormat2:-~n"
		WriteStdout EnumSupportFormat(pFormatSupport.OutFormatSupport)
	EndFunction
	
	Function EnumSupportFormat$(Value:Int)
		Local Result$
		
		If Value & $1 Result =  "   D3D11_FORMAT_SUPPORT_BUFFER~n"
		If Value & $2 Result :+ "   D3D11_FORMAT_SUPPORT_IA_VERTEX_BUFFER~n"
		If Value & $4 Result :+ "   D3D11_FORMAT_SUPPORT_IA_INDEX_BUFFER~n"
		If Value & $8 Result :+ "   D3D11_FORMAT_SUPPORT_SO_BUFFER~n"
		If Value & $10 Result :+ "   D3D11_FORMAT_SUPPORT_TEXTURE1D~n"
		If Value & $20 Result :+ "   D3D11_FORMAT_SUPPORT_TEXTURE2D~n"
		If Value & $40 Result :+ "   D3D11_FORMAT_SUPPORT_TEXTURE3D~n"
		If Value & $80 Result :+ "   D3D11_FORMAT_SUPPORT_TEXTURECUBE~n"
		If Value & $100 Result :+ "   D3D11_FORMAT_SUPPORT_SHADER_LOAD~n"
		If Value & $200 Result :+ "   D3D11_FORMAT_SUPPORT_SHADER_SAMPLE~n"
		If Value & $400 Result :+ "   D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON~n"
		If Value & $800 Result :+ "   D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_EXIT~n"
		If Value & $1000 Result :+ "   D3D11_FORMAT_SUPPORT_MIP~n"
		If Value & $2000 Result :+ "   D3D11_FORMAT_SUPPORT_MIP_AUTOGEN~n"
		If Value & $4000 Result :+ "   D3D11_FORMAT_SUPPORT_RENDER_TARGET~n"
		If Value & $8000 Result :+ "   D3D11_FORMAT_SUPPORT_BLENDABLE~n"
		If Value & $10000 Result :+ "   D3D11_FORMAT_SUPPORT_DEPTH_STENCIL~n"
		If Value & $20000 Result :+ "   D3D11_FORMAT_SUPPORT_CPU_LOCKABLE~n"
		If Value & $40000 Result :+ "   D3D11_FORMAT_SUPPORT_MULITSAMPLE_RESOLVE~n"
		If Value & $80000 Result :+ "   D3D11_FORMAT_SUPPORT_DISPLAY~n"
		If Value & $100000 Result :+ "   D3D11_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT~n"
		If Value & $200000 Result :+ "   D3D11_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET~n"
		If Value & $400000 Result :+ "   D3D11_FORMAT_SUPPORT_MULTISAMPLE_LOAD~n"
		If Value & $800000 Result :+ "   D3D11_FORMAT_SUPPORT_SHADER_GATHER~n"
		If Value & $1000000 Result :+ "   D3D11_FORMAT_SUPPORT_BACK_BUFFER_CAST~n"
		If Value & $2000000 Result :+ "   D3D11_FORMAT_SUPPORT_TYPED_UNORDERED_ACCESS_VIEW~n"
		If Value & $4000000 Result :+ "   D3D11_FORMAT_SUPPORT_SHADER_GATHER_COMPARISON~n"
		
		If Result = "" Result = "   None"
		
		Return Result
	EndFunction
	
	If Not _d3d11dev
		Throw "D3D11Device isnt ready!"
	EndIf

	CheckThreading
	CheckDataDoubles
	CheckD3D10XHardwareOptions
	If InFormat CheckDataFormat(InFormat)
EndFunction
?


