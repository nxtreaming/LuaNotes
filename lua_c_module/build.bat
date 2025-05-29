@echo off
echo Building Lua C Module...

REM Create a clean build directory
if exist "build" rmdir /s /q build
mkdir build
cd build

REM Run CMake with the current directory as the source
cmake -G "Visual Studio 17 2022" -A x64 ..
cmake --build . --config Debug

echo.
echo Build completed!
echo.

REM Change to the Debug directory where the DLL is located
cd Debug

echo Current directory: %CD%
echo.
echo Files in current directory:
dir
echo.

echo Testing module exports...
echo.

REM Add the current directory to PATH temporarily to find the DLL
set PATH=%CD%;%PATH%

REM Check if the module exports the required function
lua check_exports.lua

echo.
echo Testing module...
echo.

lua test_module.lua

echo.
echo Press any key to exit...
pause > nul




