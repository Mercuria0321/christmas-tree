@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

rem 若本地服务已在运行，直接打开浏览器
powershell -NoProfile -Command "try { $null = Invoke-WebRequest -UseBasicParsing 'http://127.0.0.1:8777/' -TimeoutSec 2; exit 0 } catch { exit 1 }"
if not errorlevel 1 (
    start "" "http://127.0.0.1:8777/"
    exit /b 0
)

where python >nul 2>nul
if errorlevel 1 (
    echo.
    echo [错误] 未找到 Python 3。请先安装 Python 并勾选 "Add python.exe to PATH"。
    echo 下载地址: https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

echo 正在启动星尘圣诞树...
start "Christmas Tree Server" /min python -m http.server 8777 --bind 127.0.0.1
timeout /t 2 /nobreak >nul
start "" "http://127.0.0.1:8777/"

echo.
echo 已启动: http://127.0.0.1:8777/
echo 关闭最小化的 "Christmas Tree Server" 窗口即可停止服务。
echo.
pause