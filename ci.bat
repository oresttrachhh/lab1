@echo off
setlocal
cd /d "%~dp0"

echo Running Maven tests...
call mvn --batch-mode clean test
if errorlevel 1 exit /b %errorlevel%

echo Building executable JAR...
call mvn --batch-mode package
if errorlevel 1 exit /b %errorlevel%

if not exist build\hello.jar (
    echo ERROR: build\hello.jar was not produced.
    exit /b 1
)

echo Verifying build\hello.jar...
java -jar build\hello.jar
if errorlevel 1 exit /b %errorlevel%
exit /b 0
