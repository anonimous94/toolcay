@echo off

@echo off
:: Check for Administrator privileges
openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Phai run bang quyen admin, nhan chuot phai va chon 'Run as Administrator'.
    pause
    exit /b
)

:: Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js chua duoc cai dat, bat dau cai dat...
    :: Download Node.js installer
    set DOWNLOAD_PATH=%TEMP%\nodejs-installer.msi

    :: Use PowerShell's Invoke-WebRequest for better error handling and diagnostics
    powershell -Command ^
        try { ^
            $url='https://nodejs.org/dist/v22.11.0/node-v22.11.0-x64.msi'; ^
            $path='%TEMP%\\nodejs-installer.msi'; ^
            Write-Host "Downloading from $url to $path..."; ^
            Invoke-WebRequest -Uri $url -OutFile $path -ErrorAction Stop; ^
            Write-Host "Download completed successfully."; ^
        } catch { ^
            Write-Host "An error occurred: $_"; ^
            exit 1; ^
        }

    :: Install Node.js
    msiexec /i "%TEMP%\nodejs-installer.msi" /qn /norestart /L*v %TEMP%\nodejs-installer.log
    echo Cai dat thanh cong.
) else (
    echo Node.js da duoc cai roi.
)
