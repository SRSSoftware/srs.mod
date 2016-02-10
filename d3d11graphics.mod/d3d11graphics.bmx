SuperStrict

Module SRS.D3D11Graphics

ModuleInfo "Version: V1.0"
ModuleInfo "Author: Dave Camp"
ModuleInfo "License: SRS Shared Source Code License"
ModuleInfo "Copyright: SRS Software"
ModuleInfo ""
ModuleInfo "BUGFIXES:"
ModuleInfo "Fixed up some drivers not returning all display modes on HDTVs, removed dead code"
ModuleInfo "Fixed up a work-around so as Not To use the bugged IDXGIAdapter.CheckSupportedInterfaces"
ModuleInfo "Fixed available graphic modes should not work on Dx9"
ModuleInfo "Fixed fullscreen selecting correct parameters"
ModuleInfo "Fixed image scaling bug"
ModuleInfo "Fixed render lag for window and fullscreen"
ModuleInfo "Fixed crash when exiting from fullscreen then using another DX driver"

?Not bmxng
Import "d3d11graphics_brl.bmx"
?

?bmxng
Import "d3d11graphics_ng.bmx"
?
