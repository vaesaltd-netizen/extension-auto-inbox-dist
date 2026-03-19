@echo off
cd /d "%~dp0"

echo ========================================
echo   Update - Vaesa Inbox Tools
echo ========================================
echo.

set "REPO=vaesaltd-netizen/extension-auto-inbox-dist"
set "BRANCH=main"
set "ZIP_URL=https://github.com/%REPO%/archive/refs/heads/%BRANCH%.zip"
set "TEMP_ZIP=%TEMP%\vaesa-update.zip"
set "TEMP_DIR=%TEMP%\vaesa-update"

echo Dang tai ban cap nhat moi nhat...
echo.

:: Download zip
powershell -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile '%TEMP_ZIP%' -UseBasicParsing"
if not exist "%TEMP_ZIP%" (
    echo LOI: Khong the tai duoc. Kiem tra ket noi mang.
    pause
    exit /b
)
echo Download thanh cong!
echo.

:: Remove old temp dir
if exist "%TEMP_DIR%" rd /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

:: Extract zip
echo Dang giai nen...
powershell -ExecutionPolicy Bypass -Command "Expand-Archive -Path '%TEMP_ZIP%' -DestinationPath '%TEMP_DIR%' -Force"

:: Find extracted folder
for /d %%d in ("%TEMP_DIR%\*") do set "EXTRACTED=%%d"

:: Copy files to current directory
echo Dang cap nhat file...
xcopy "%EXTRACTED%\*" "%~dp0" /s /e /y /q >nul 2>&1

:: Cleanup
del "%TEMP_ZIP%" >nul 2>&1
rd /s /q "%TEMP_DIR%" >nul 2>&1

echo.
echo ========================================
echo   Cap nhat thanh cong!
echo   Vui long vao Chrome reload extension.
echo ========================================
echo.
pause
