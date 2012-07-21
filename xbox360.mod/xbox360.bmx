'''''''''''''''''''''''''''''''''''''''''''''''
'																'
'				XBox360 Controller Module				'
'																'
'			Copyright (c) SRS Software 2011			'
'					All rights reserved					'
'																'
'''''''''''''''''''''''''''''''''''''''''''''''

Rem
	Xbox360 Controller Module V2.0 : 21 May 2011
	
	For Windows Use Only.
	You must make sure you have the latest version of DirectX
		before using this software.
	
	This module is for using up to 4 XBox360 wired controller(s)
		plugged into a Windows PC.
	
	If you use this module or part of the code herein
		you must give expressed credit to SRS Software.
	
	Some Notes
	- Windows only
	- This module provides support for the following features
	-		Up to 4 simultaneous controllers
	-		2 seperate analogue thumb sticks including a push action for each stick
	-		2 seperate analogue thumb triggers
	- 		2 seperate shoulder buttons
	-		8 way directional D-Pad
	-		Start Button
	-		Back Button
	-		A , B , X , Y  buttons
	-		Vibration Control - seperate control of Left and Right vibration motors
	-		NO SUPPORT FOR CENTRE X BUTTON
	
	- Value ranges :
	-		All buttons are either ON or OFF expressed as a TRUE or FALSE
	-		The Analogue sticks range from 0 to 65535 with the centres at 32768
	-		Thumb triggers range from 0 to 255
	
	Fixes/Updates:
	- 22 May 2001 :
	-	V1.1 Added :
	-			The following functions now return a value between -1.0 and 1.0
	-			LeftStickHorizontalF
	-			LeftStickVerticalF
	-			RightStickHorizontalF
	-			RightStickVerticalF
	-
	-			These following two return a value between 0.0 and 1.0
	-			LeftTriggerF
	-			RightTriggerF
	-
	- V1.2 Fixed:
	-			Float values not returning full motion from -1.0 to 1.0 - now they do.
	-
	- V2.0 Update: 12 June 2011
	-			Now multithreaded to avoid any slowdown during the 'Update' Method
	
	How to Use:-
	To use in your code you need to import the module. Use

		Import SRS.Xbox360

	Then create an instance of the 'XBox360' Type like so

		Global XB:XBox360 = new XBox360

	before reading any data from any controllers use

		XB.Update

	You MUST call this before getting any data from the controllers, once per frame is ok, then use the
	following methods to get information about the controller. If you are using Multi-threading the Update method
	doesn't need to be called. It is called from a seperate thread automatically.
	You need to pass in an ID value ranging from 0 to 3 inclusive for the corresponding controller as shown below

	To see if a controller is connected use
	This returns TRUE is a controller is connected or FALSE otherwise.
		XB.IsConnected( ID )

	These return TRUE of FALSE, TRUE if pressed, FALSE otherwise
		XB.A( ID )
		XB.B( ID )
		XB.X( ID )
		XB.Y( ID )
		XB.Start( ID )
		XB.Back( ID )
		XB.LeftShoulder( ID )
		XB.RightShoulder( ID )
		XB.LeftThumb( ID )
		XB.RightThumb( ID )

	To get the condition of the D-Pad use a combination of the following
	These also return TRUE for pressed, FALSE otherwise
		XB.DPadUp( ID )
		XB.DPadDown( ID )
		XB.DPadLeft( ID )
		XB.DPadRight( ID )

	The trigger values will return a value between 0 and 255 inclusive. 0 for no action, 255 for fully pressed.
		XB.LeftTriger( ID )
		XB.RightTrigger( ID )

	To retrieve the state of the analogue thumb stick positions, the values will return between 0 and 65535 inclusive.
	When the stick is centred the value is 32768. To access the thumb stick values use
		XB.LeftStickHorizontal( ID )
		XB.LeftStickVertical( ID )
		XB.RightStickHorizontal( ID )
		XB.RightStickVertical( ID )

	To use the rumble features you use the following methods passing in the ID of the controller to set
	and also a value between 0 and 65535 inclusive. 0 is no vibration, 65535 is full vibration.
		XB.SetSmallVibration( ID , value )
		XB.SetBigVibration( ID , value )

	You can also adjust the 'Dead Zone'. This is a zone of movement for the thumb sticks only.
	Its where you will get no controller response until you move a certain distance from the centre position.
	The value to set it to is between 0 and 1, 0 is no dead zone ( causing erratic sensitive movement data
	when the stick is at the centre position ) and 1 would be no stick movement detection. It defaults to 0.25.
	I advise you NOT to use this method but just in case you want to
		XB.SetDeadZone( ID , value )
EndRem


SuperStrict

Module SRS.XBOX360

?Win32	'Windows only

Import Pub.Win32
Import BRL.Threads

Private

'Constants for gamepad buttons
Const XINPUT_GAMEPAD_DPAD_UP          :Int = $0001
Const XINPUT_GAMEPAD_DPAD_DOWN        :Int = $0002
Const XINPUT_GAMEPAD_DPAD_LEFT        :Int = $0004
Const XINPUT_GAMEPAD_DPAD_RIGHT       :Int = $0008
Const XINPUT_GAMEPAD_START            :Int = $0010
Const XINPUT_GAMEPAD_BACK             :Int = $0020
Const XINPUT_GAMEPAD_LEFT_THUMB       :Int = $0040
Const XINPUT_GAMEPAD_RIGHT_THUMB      :Int = $0080
Const XINPUT_GAMEPAD_LEFT_SHOULDER    :Int = $0100
Const XINPUT_GAMEPAD_RIGHT_SHOULDER   :Int = $0200
Const XINPUT_GAMEPAD_A                :Int = $1000
Const XINPUT_GAMEPAD_B                :Int = $2000
Const XINPUT_GAMEPAD_X                :Int = $4000
Const XINPUT_GAMEPAD_Y                :Int = $8000

Const XUSER_MAX_COUNT                 :Int = 4

Type XBOX360_USER_STATE
	Field State:XINPUT_STATE
	Field VibrationState:XINPUT_VIBRATION
	Field Connected:Int
	
	Field INPUT_DEADZONE_MIN:Int
	Field INPUT_DEADZONE_MAX:Int
EndType

Type XINPUT_STATE
	Field dwPacketNumber:Int
	'Field GamePad:XINPUT_GAMEPAD
	Field wButtons:Short
   Field bLeftTrigger:Byte
   Field bRightTrigger:Byte
	Field sThumbLX:Short
	Field sThumbLY:Short
	Field sThumbRX:Short
	Field sThumbRY:Short
EndType

Type XINPUT_VIBRATION
	Field wLeftMotorSpeed:Short
	Field wRightMotorSpeed:Short
EndType

Global XInputLib:Int = InitX360()
Global XInputGetState:Int( dwUserIndex:Int , pState:Byte Ptr )"win32" = GetProcAddress( XInputLib , "XInputGetState" )
Global XInputSetState:Int( dwUserIndex:Int , pVibration:Byte Ptr )"win32" = GetProcAddress( XInputLib , "XInputSetState" )

Global Users:XBOX360_USER_STATE[ XUSER_MAX_COUNT ] 

?THREADED
'Multithread
Global XBOX360Mutex:TMutex
Global XBOX360Thread:TThread
Global GameThread:TThread

Function XBox360Update:Object( in:Object )
	While GameThread
		'Polled to 60FPS
		Delay 17
		LockMutex( XBOX360Mutex )
			For Local i:Int = 0 Until XUSER_MAX_COUNT
				Local hr:Int = XInputGetState( i , Users[ i ].State )
		
				If hr = 0
					Users[ i ].Connected = True
				Else
					Users[ i ].Connected = False
				EndIf
			Next
		UnlockMutex( XBOX360Mutex )
	Wend
EndFunction
?

'We should really close the library when finished
Extern"win32"
Function FreeLibrary:Int( hModule:Int )
EndExtern

Function InitX360:Int()
	Local OpenDLL:Int
	OpenDLL = LoadLibraryA("xinput1_3.dll")
	
	If OpenDLL
		DebugLog "Opened XInput1_3.dll successfully"
		OnEnd CloseXInputLib
	Else
		DebugLog "Cannot find XInput1_3.dll"
	EndIf
	
	Return OpenDLL
EndFunction

Function CloseXInputLib()
	?THREADED
	GameThread = Null
	'Slight Delay for the child thread to catch that we are closing up
	Delay 50
	?
	
	If XInputLib
		FreeLibrary( XInputLib )
		DebugLog "Closing XInput1_3.dll Library"
		XInputLib = Null
	EndIf
EndFunction

Public

Type Xbox360
	Method New()
		For Local i:Int = 0 Until XUSER_MAX_COUNT
			Users[ i ] = New XBOX360_USER_STATE
			Users[ i ].State = New XINPUT_STATE
			Users[ i ].Connected = False
			
			'Vibration
			Users[ i ].VibrationState = New XINPUT_VIBRATION
			
			'Default Dead Zone in the center
			SetDeadZone( i , 0.25 )
		Next
		?THREADED
			GameThread = MainThread()
			XBOX360Mutex = CreateMutex()
			XBox360Thread = CreateThread( XBox360Update , Null )
		?
	EndMethod
	
	Method SetDeadZone( ControllerID:Int , dz:Float )
		If dz >= 0.0 And dz <= 1.0
			'Calculate dead zone offset from the centre
			Local IDZ:Int = ( 65536 * dz ) / 2
			Users[ ControllerID ].INPUT_DEADZONE_MIN = 32768 - IDZ
			Users[ ControllerID ].INPUT_DEADZONE_MAX = 32768 + IDZ
		EndIf
	EndMethod
	
	Method IsConnected:Int( User:Int )
		 Return Users[ User ].Connected
	EndMethod
	
	Method Update()
		?Not THREADED
		For Local i:Int = 0 Until XUSER_MAX_COUNT
			Local hr:Int = XInputGetState( i , Users[ i ].State )
			
			If hr = 0
				Users[ i ].Connected = True
			Else
				Users[ i ].Connected = False
			EndIf
		Next
		?
	EndMethod
	
	Method A:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_A & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_A
	EndMethod
	
	Method B:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_B & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_B
	EndMethod
	
	Method X:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_X & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_X
	EndMethod
	
	Method Y:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_Y & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_Y
	EndMethod
	
	Method DPadUp:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_DPAD_UP & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_DPAD_UP
	EndMethod
	
	Method DPadDown:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_DPAD_DOWN & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_DPAD_DOWN
	EndMethod

	Method DPadLeft:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_DPAD_LEFT & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_DPAD_LEFT
	EndMethod

	Method DPadRight:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_DPAD_RIGHT & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_DPAD_RIGHT
	EndMethod

	Method Start:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_START & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_START
	EndMethod
	
	Method Back:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_BACK & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_BACK
	EndMethod
	
	Method LeftShoulder:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_LEFT_SHOULDER & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_LEFT_SHOULDER
	EndMethod
	
	Method RightShoulder:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_RIGHT_SHOULDER & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_RIGHT_SHOULDER
	EndMethod

	Method LeftThumb:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_LEFT_THUMB & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_LEFT_THUMB
	EndMethod
	
	Method RightThumb:Int( ControllerID:Int )
		Return ( XINPUT_GAMEPAD_RIGHT_THUMB & Users[ ControllerID ].State.wButtons ) = XINPUT_GAMEPAD_RIGHT_THUMB
	EndMethod
	
	'Integer return values
	Method LeftTrigger:Int( ControllerID:Int )
		Return Users[ ControllerID ].State.bLeftTrigger
	EndMethod
	
	Method RightTrigger:Int( ControllerID:Int )
		Return Users[ ControllerID ].State.bRightTrigger
	EndMethod
	
	Method LeftStickHorizontal:Int( ControllerID:Int )
		Return CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbLX , False )
	EndMethod
	
	Method LeftStickVertical:Int( ControllerID:Int )
		Return CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbLY , False )
	EndMethod
	
	Method RightStickHorizontal:Int( ControllerID:Int )
		Return CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbRX , False )
	EndMethod
	
	Method RightStickVertical:Int( ControllerID:Int )
		Return CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbRY , False )
	EndMethod

	Method CalcStickValue:Int( ControllerID:Int , InputValue:Int , ForFloatValue:Int )
		'Adjust for 16bit sign-ness
		InputValue :- 32768
		If InputValue < 0 InputValue :+ 65536 + ForFloatValue
		
		'Adjust for DeadZones
		If ( InputValue > Users[ ControllerID ].INPUT_DEADZONE_MIN ) And ( InputValue < Users[ ControllerID ].INPUT_DEADZONE_MAX )
			InputValue = 32768
		EndIf
		
		Return InputValue
	EndMethod
	
	'Float return values
	Method LeftTriggerF:Float( ControllerID:Int )
		Return Float( Users[ ControllerID ].State.bLeftTrigger ) / 255.0
	EndMethod
	
	Method RightTriggerF:Float( ControllerID:Int )
		Return Float( Users[ ControllerID ].State.bRightTrigger ) / 255.0
	EndMethod
	
	Method LeftStickHorizontalF:Float( ControllerID:Int )
		Return Float( CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbLX ,True ) ) / 32768.0 - 1.0
	EndMethod
 
	Method LeftStickVerticalF:Float( ControllerID:Int )
		Return Float( CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbLY , True ) ) / 32768.0 - 1.0
	EndMethod	
	
	Method RightStickHorizontalF:Float( ControllerID:Int )
		Return Float( CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbRX , True ) ) / 32768.0 - 1.0
	EndMethod

	Method RightStickVerticalF:Float( ControllerID:Int )
		Return Float( CalcStickValue( ControllerID , Users[ ControllerID ].State.sThumbRY , True ) ) / 32768.0 - 1.0
	EndMethod

	Method GetMaxControllers:Int()
		Return XUSER_MAX_COUNT
	EndMethod
	
	Method SetBigVibration( ControllerID:Int , val:Short )
		Users[ ControllerID ].VibrationState.wLeftMotorSpeed = val
		XInputSetState( ControllerID , Users[ ControllerID ].VibrationState )
	EndMethod
	
	Method SetSmallVibration( ControllerID:Int , val :Short )
		Users[ ControllerID ].VibrationState.wRightMotorSpeed = val
		XInputSetState( ControllerID , Users[ ControllerID ].VibrationState )
	EndMethod
EndType

? 'End ?Win32