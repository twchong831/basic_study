echo off
set PATH=C:\MinGW\mingw64\bin;%PATH%
set PATH=C:\Program Files\gnuplot\bin;%PATH%
rem echo %PATH%
rem cd "C:\MinGW\mingw64\bin"
prompt $g

"C:\WINDOWS\system32\cmd.exe" /k "compile\compile.bat"

