@echo off
echo Building C Lua Demo...

if not exist "build" mkdir build
cd build

cmake -G "MinGW Makefiles" ..
cmake --build .

echo.
echo Build completed!
echo.
echo Running demo...
echo.

clua_demo.exe

echo.
echo Press any key to exit...
pause > nul