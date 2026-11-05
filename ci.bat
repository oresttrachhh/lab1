@echo off
setlocal
cd /d "%~dp0"

echo Running Maven tests...
call mvn --batch-mode clean test
if errorlevel 1 (
    echo ERROR: Maven tests failed.
    exit /b 1
)

echo Building executable JAR...
call mvn --batch-mode package
if errorlevel 1 (
    echo ERROR: Maven package failed.
    exit /b 1
)

if not exist build\hello.jar (
    echo ERROR: build\hello.jar was not produced.
    exit /b 1
)

echo Verifying build\hello.jar...
java -jar build\hello.jar
if errorlevel 1 (
    echo ERROR: build\hello.jar could not be executed.
    exit /b 1
)
echo SUCCESS: tests passed and build\hello.jar was created.
exit /b 0
