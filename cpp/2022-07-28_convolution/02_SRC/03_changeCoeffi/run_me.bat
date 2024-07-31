echo off
set PATH=C:\GNU\MinGW-x64\MinGW\mingw64\bin;%PATH%

rem echo %PATH%
rem cd "C:\GNU\MinGW-x64\MinGW\mingw64\bin"
prompt $g

"C:\WINDOWS\system32\cmd.exe" /k "make -f Makefile.win32 all"
