@echo off
echo ===============================================
echo    Lua UTF-8 Runner Script
echo ===============================================

REM Change console code page to UTF-8
chcp 65001 >nul

REM Set console font to support UTF-8 (optional)
echo Setting console to UTF-8 mode...
echo.

REM Base directory where Lua might be installed
set LUA_BASE_DIR=D:\lua-5.4.7

REM Find lua.exe (same logic as find-and-setup-lua.bat)
set LUA_FOUND=0

if exist "%LUA_BASE_DIR%\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%
    set LUA_FOUND=1
    goto :found
)

if exist "%LUA_BASE_DIR%\bin\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\bin
    set LUA_FOUND=1
    goto :found
)

if exist "%LUA_BASE_DIR%\Release\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\Release
    set LUA_FOUND=1
    goto :found
)

if exist "%LUA_BASE_DIR%\x64\Release\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\x64\Release
    set LUA_FOUND=1
    goto :found
)

if exist "%LUA_BASE_DIR%\build\Release\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\build\Release
    set LUA_FOUND=1
    goto :found
)

if exist "%LUA_BASE_DIR%\src\lua.exe" (
    set LUA_INSTALL_PATH=%LUA_BASE_DIR%\src
    set LUA_FOUND=1
    goto :found
)

:notfound
echo Error: lua.exe not found
echo Please run find-and-setup-lua.bat first to locate Lua installation
pause
exit /b 1

:found
REM Set environment variables
set PATH=%LUA_INSTALL_PATH%;%PATH%

REM Navigate to project directory
cd /d "d:\workspace\LuaNotes"

echo Console configured for UTF-8 display
echo Running: lua LuaHello.lua
echo.
echo ===============================================

REM Run Lua script
"%LUA_INSTALL_PATH%\lua.exe" LuaHello.lua

echo.
echo ===============================================
echo Script execution completed
echo.

pause
