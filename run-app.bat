@echo off
setlocal
cd /d "%~dp0"

set "NODE_DIR=C:\Program Files\nodejs"
set "PATH=%NODE_DIR%;%PATH%"

if not exist "%NODE_DIR%\node.exe" (
  echo Node.js not found. Installing via winget - you may see a UAC prompt.
  winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements --silent
  if not exist "%NODE_DIR%\node.exe" (
    echo.
    echo Node.js is still not installed. Approve the UAC prompt, or install from https://nodejs.org then run this again.
    pause
    exit /b 1
  )
  echo Node.js installed. Opening a new window to run the app...
  start "" cmd /k "cd /d %~dp0 && run-app.bat"
  exit /b 0
)

if not exist "node_modules\electron" (
  echo Installing Electron - first run may take a minute...
  call "%NODE_DIR%\npm.cmd" install
  if errorlevel 1 (
    echo npm install failed.
    pause
    exit /b 1
  )
)

echo Starting Sandboxles...
call "%NODE_DIR%\npm.cmd" start
