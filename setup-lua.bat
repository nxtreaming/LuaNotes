@echo off
echo ===============================================
echo    Smart Lua Environment Setup Script
echo ===============================================

REM Base directory where Lua might be installed
set LUA_BASE_DIR=D:\lua-5.4.7

echo Searching for lua.exe in %LUA_BASE_DIR%...
echo.

REM Check common locations for lua.exe
set LUA_FOUND=0

REM Check root directory
if exist "%LUA_BASE_DIR%\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%
    set LUA_FOUND=1
    echo Found lua.exe in: %LUA_BASE_DIR%
    goto :found
)

REM Check bin subdirectory
if exist "%LUA_BASE_DIR%\bin\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\bin
    set LUA_FOUND=1
    echo Found lua.exe in: %LUA_BASE_DIR%\bin
    goto :found
)

REM Check Release subdirectory (Visual Studio build)
if exist "%LUA_BASE_DIR%\Release\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\Release
    set LUA_FOUND=1
    echo Found lua.exe in: %LUA_BASE_DIR%\Release
    goto :found
)

REM Check x64\Release subdirectory (Visual Studio x64 build)
if exist "%LUA_BASE_DIR%\x64\Release\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\x64\Release
    set LUA_FOUND=1
    echo Found lua.exe in: %LUA_BASE_DIR%\x64\Release
    goto :found
)

REM Check build\Release subdirectory (CMake build)
if exist "%LUA_BASE_DIR%\build\Release\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\build\Release
    set LUA_FOUND=1
    echo Found lua.exe in: %LUA_BASE_DIR%\build\Release
    goto :found
)

REM Check src subdirectory
if exist "%LUA_BASE_DIR%\src\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\src
    set LUA_FOUND=1
    echo Found lua.exe in: %LUA_BASE_DIR%\src
    goto :found
)

:notfound
echo Error: lua.exe not found in any common locations under %LUA_BASE_DIR%
echo.
echo Searched in:
echo   %LUA_BASE_DIR%\lua.exe
echo   %LUA_BASE_DIR%\bin\lua.exe
echo   %LUA_BASE_DIR%\Release\lua.exe
echo   %LUA_BASE_DIR%\x64\Release\lua.exe
echo   %LUA_BASE_DIR%\build\Release\lua.exe
echo   %LUA_BASE_DIR%\src\lua.exe
echo.
echo Please check your Lua installation and modify LUA_BASE_DIR in this script.
echo Current LUA_BASE_DIR: %LUA_BASE_DIR%
pause
exit /b 1

:found
echo.
echo ===============================================
echo Lua Installation Found!
echo ===============================================
echo Lua executable: %LUA_INSTALL_PATH%\lua.exe
echo.

REM Set environment variables for current session
set PATH=%LUA_INSTALL_PATH%;%PATH%
set LUA_DIR=%LUA_INSTALL_PATH%
set LUA_INCLUDE=%LUA_BASE_DIR%\include
set LUA_LIB=%LUA_BASE_DIR%\lib

echo Environment configured for current session!
echo.

REM Test Lua installation
echo Testing Lua installation:
"%LUA_INSTALL_PATH%\lua.exe" -v
if errorlevel 1 (
    echo Warning: lua.exe found but failed to run
) else (
    echo Lua is working correctly!
)
echo.

REM Navigate to project directory
cd /d "d:\workspace\LuaNotes"
echo Current working directory: %CD%
echo.

echo ===============================================
echo Available commands:
echo   lua LuaHello.lua           Run Lua script
echo   lua -i                     Interactive Lua
echo   luac -o script.out file.lua Compile Lua script (if luac.exe exists)
echo ===============================================
echo.

echo To test your Lua script, try:
echo   lua LuaHello.lua
echo.

REM Keep command prompt open with Lua environment
cmd /k
