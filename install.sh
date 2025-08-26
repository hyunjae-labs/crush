#!/bin/bash

echo "========================================"
echo " Crush 온프레미스 설치 스크립트"
echo "========================================"

echo
echo "[1/3] Go 설치 확인 중..."
if ! command -v go &> /dev/null; then
    echo "❌ Go가 설치되지 않았습니다"
    echo "   https://golang.org/dl/ 에서 Go를 설치하세요"
    exit 1
fi

goversion=$(go version | awk '{print $3}')
echo "✅ Go 설치 확인: $goversion"

echo
echo "[2/3] 환경변수 설정..."
read -p "온프레미스 서버 URL [https://h-chat-api.autoever.com/v2/api/claude]: " base_url
base_url=${base_url:-https://h-chat-api.autoever.com/v2/api/claude}

read -s -p "API 키를 입력하세요: " api_key
echo
if [ -z "$api_key" ]; then
    echo "❌ API 키는 필수입니다"
    exit 1
fi

# 환경변수를 ~/.bashrc에 추가
{
    echo "export CRUSH_ANTHROPIC_BASE_URL=\"$base_url\""
    echo "export CRUSH_ANTHROPIC_API_KEY=\"$api_key\""
} >> ~/.bashrc

# 현재 세션에도 적용
export CRUSH_ANTHROPIC_BASE_URL="$base_url"
export CRUSH_ANTHROPIC_API_KEY="$api_key"

echo "✅ 환경변수 설정 완료 (~/.bashrc에 추가됨)"

echo
echo "[3/3] Crush 빌드 중..."
if ! go build -ldflags="-s -w" -o crush .; then
    echo "❌ 빌드 실패"
    exit 1
fi

# 실행 권한 추가
chmod +x crush

echo "✅ 빌드 완료: ./crush"

echo
echo "========================================"
echo " 설치 완료!"
echo "========================================"
echo
echo "사용법:"
echo "  ./crush"
echo "  ./crush \"질문 내용\""
echo
echo "환경변수를 적용하려면 다음 명령어를 실행하거나 새 터미널을 여세요:"
echo "  source ~/.bashrc"
echo

read -p "테스트해보시겠습니까? (y/n): " test
if [[ $test =~ ^[Yy]$ ]]; then
    echo
    echo "테스트 실행 중..."
    echo "안녕하세요, 온프레미스 API 테스트입니다" | ./crush
fi

echo
echo "🎉 모든 설정이 완료되었습니다!"