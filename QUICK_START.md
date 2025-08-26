# ⚡ 빠른 시작 가이드

## 🚀 3단계 설치

### Windows
```bash
# 1. 저장소 클론
git clone https://github.com/hyunjae-labs/crush-onpremise.git
cd crush-onpremise

# 2. 자동 설치 실행
install.bat

# 3. 바로 사용
.\crush.exe
```

### Linux/Mac
```bash
# 1. 저장소 클론  
git clone https://github.com/hyunjae-labs/crush-onpremise.git
cd crush-onpremise

# 2. 자동 설치 실행
chmod +x install.sh
./install.sh

# 3. 바로 사용
./crush
```

## ⚙️ 수동 설정 (필요시)

### 환경변수
```bash
# Windows
set CRUSH_ANTHROPIC_BASE_URL=https://h-chat-api.autoever.com/v2/api/claude
set CRUSH_ANTHROPIC_API_KEY=your-api-key

# Linux/Mac
export CRUSH_ANTHROPIC_BASE_URL="https://h-chat-api.autoever.com/v2/api/claude"  
export CRUSH_ANTHROPIC_API_KEY="your-api-key"
```

### 빌드
```bash
go build -o crush.exe .  # Windows
go build -o crush .      # Linux/Mac
```

## 🎯 사용 예시

```bash
# 대화형 모드
./crush.exe

# 직접 질문
./crush.exe "Python 코드를 최적화해줘"

# 파일 분석
./crush.exe < main.py

# 파이프라인
echo "이 에러를 해결해줘" | ./crush.exe
```

## 🔍 문제 해결

### API 키 오류 (401)
```bash
# 환경변수 확인
echo %CRUSH_ANTHROPIC_API_KEY%  # Windows
echo $CRUSH_ANTHROPIC_API_KEY   # Linux/Mac

# 다시 설정
set CRUSH_ANTHROPIC_API_KEY=correct-key
```

### 네트워크 오류
```bash
# 연결 테스트
curl -I https://h-chat-api.autoever.com/v2/api/claude/messages

# VPN 확인
ping h-chat-api.autoever.com
```

### 엔드포인트 오류 (404)
```bash
# URL 확인 - 정확한 형식:
https://h-chat-api.autoever.com/v2/api/claude
# ❌ 끝에 /messages 붙이면 안됨!
```

---

**더 자세한 내용은 [README.md](README.md)를 참고하세요!**