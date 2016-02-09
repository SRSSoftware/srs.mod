Strict

Module SRS.DirectX11

' Included compatability for BlitzMaxNG. To do this for the already existing module 
'	it was easier and cleaner to create a compiler switch and just import the correct
'	files needed.

?Not bmxng
Import "directx11_brl.bmx"
?

?bmxng
Import "directx11_ng.bmx"
?

Import "d3d11shader.bmx"