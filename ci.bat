@echo off
setlocal
cd /d "%~dp0"

echo Running Maven tests...
call mvn --batch-mode clean test
if errorlevel 1 exit /b %errorlevel%

echo Building executable JAR...
call mvn --batch-mode package
if errorlevel 1 exit /b %errorlevel%

for %%f in (target\HelloProject-*.jar) do (
    echo Verifying %%f...
    java -jar "%%f"
    if errorlevel 1 exit /b %errorlevel%
    exit /b 0
)

echo ERROR: No HelloProject JAR was produced.
exit /b 1
