@echo off
echo ========================================
echo  Crush 온프레미스 설치 스크립트
echo ========================================

echo.
echo [1/3] Go 설치 확인 중...
go version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Go가 설치되지 않았습니다
    echo    https://golang.org/dl/ 에서 Go를 설치하세요
    pause
    exit /b 1
)

for /f "tokens=3" %%i in ('go version') do set goversion=%%i
echo ✅ Go 설치 확인: %goversion%

echo.
echo [2/3] 환경변수 설정...
set /p base_url="온프레미스 서버 URL [https://h-chat-api.autoever.com/v2/api/claude]: "
if "%base_url%"=="" set base_url=https://h-chat-api.autoever.com/v2/api/claude

set /p api_key="API 키를 입력하세요: "
if "%api_key%"=="" (
    echo ❌ API 키는 필수입니다
    pause
    exit /b 1
)

setx CRUSH_ANTHROPIC_BASE_URL "%base_url%" >nul
setx CRUSH_ANTHROPIC_API_KEY "%api_key%" >nul

echo ✅ 환경변수 설정 완료

echo.
echo [3/3] Crush 빌드 중...
go build -ldflags="-s -w" -o crush.exe .
if %errorlevel% neq 0 (
    echo ❌ 빌드 실패
    pause
    exit /b 1
)

echo ✅ 빌드 완료: crush.exe

echo.
echo ========================================
echo  설치 완료! 
echo ========================================
echo.
echo 사용법:
echo   .\crush.exe
echo   .\crush.exe "질문 내용"
echo.
echo 테스트해보시겠습니까? (y/n)
set /p test="입력: "
if /i "%test%"=="y" (
    echo.
    echo 테스트 실행 중...
    echo 안녕하세요, 온프레미스 API 테스트입니다 | .\crush.exe
)

echo.
echo 🎉 모든 설정이 완료되었습니다!
pause