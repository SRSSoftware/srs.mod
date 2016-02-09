Strict

Import Pub.Win32
Import "d3dcommon_common.bmx"

Extern "win32"
Type ID3DBlob Extends IUnknown
	Method GetBufferPointer:Byte Ptr()
	Method GetBufferSize()
EndType
EndExtern

