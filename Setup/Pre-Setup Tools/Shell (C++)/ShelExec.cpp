#include <windows.h>
#include <tchar.h>
#include <stdio.h>

int WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR lpCmdLine, int nCmdShow) 
{
ShellExecute(NULL, _T("open"),"reg.bat", NULL, NULL, SW_HIDE);  
return 0;
}