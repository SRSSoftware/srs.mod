Strict

Module SRS.D3D11Max2D

ModuleInfo "Version: V1.0"
ModuleInfo "Author: Dave Camp"
ModuleInfo "License: SRS Shared Source Code License"
ModuleInfo "Copyright: SRS Software"
ModuleInfo ""
ModuleInfo "Add support for BlitzMax-NG"
ModuleInfo ""
ModuleInfo "BUGFIXES:"
ModuleInfo "Fixed helper function VerifyD3D11Max2DDriver() not returning a result"
ModuleInfo "Fixed pixmaps being affected by other drawing commands - SetColor/SetAlpha etc"

?Not bmxng
Import "d3d11max2d_brl.bmx"
?

?bmxng
Import "d3d11max2d_ng.bmx"
?

