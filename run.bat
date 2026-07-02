@echo off
chcp 65001 >nul
title 图书馆借还系统

echo ========================================
echo    📚 图书馆借还系统
echo ========================================
echo.
echo   正在启动服务器，约10秒后自动打开浏览器...
echo   启动后访问: http://localhost:8080/library/login
echo   按 Ctrl+C 停止服务
echo ========================================
echo.

set MAVEN_HOME=C:\Users\27125\Desktop\apache-maven-3.9.16
set JAVA_HOME=C:\Program Files\Java\jdk-17
set PATH=%MAVEN_HOME%\bin;%JAVA_HOME%\bin;%PATH%

cd /d "%~dp0"

REM 10秒后自动打开浏览器（后台计时）
start "" cmd /c "timeout /t 10 /nobreak >nul && start http://localhost:8080/library/login"

REM 前台运行Jetty
call mvn jetty:run
pause
