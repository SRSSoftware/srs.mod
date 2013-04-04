#include <windows.h>

typedef struct {
  int Width;
	int Height;
	int Depth;
	int Hertz;
}  TGraphicsMode;

static DEVMODE dm;

BOOL Dx11Max2D_EnumDisplaySettings(DWORD ModeNum, TGraphicsMode* pMode) {
	memset(&dm,0,sizeof(dm));

	dm.dmSize = sizeof(dm);
	dm.dmDriverExtra = 0;
	
	if ( EnumDisplaySettings(0,ModeNum,&dm) != 0 )
	{
		pMode->Width = dm.dmPelsWidth;
		pMode->Height = dm.dmPelsHeight;
		pMode->Depth = dm.dmBitsPerPel;
		pMode->Hertz = dm.dmDisplayFrequency;
	
		return 1;
	}
	
	return 0;
}

