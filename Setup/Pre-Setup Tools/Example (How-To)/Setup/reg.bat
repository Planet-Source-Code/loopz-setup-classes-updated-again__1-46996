@echo off
@cd res
regsvr32 -s msvbvm60.dll
rsv >nul
cd..
cls
Setup.exe
exit