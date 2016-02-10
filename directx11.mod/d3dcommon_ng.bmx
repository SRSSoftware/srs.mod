SuperStrict

Import SRS.Win32
Import "d3dcommon_common.bmx"

Extern "win32"
Interface ID3DBlob Extends IUnknown_
	Method GetBufferPointer:Byte Ptr()
	Method GetBufferSize:Int()
EndInterface
EndExtern

