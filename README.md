# 🚀 Crush - 온프레미스 Claude API 지원

회사 내부 Claude API 서버와 완벽하게 연동되는 Crush CLI 도구입니다.

## ⚡ 빠른 시작

### 1단계: 저장소 클론
```bash
git clone https://github.com/hyunjae-labs/crush-onpremise.git
cd crush-onpremise
```

### 2단계: 환경변수 설정
```bash
# Windows (cmd)
set CRUSH_ANTHROPIC_BASE_URL=https://h-chat-api.autoever.com/v2/api/claude
set CRUSH_ANTHROPIC_API_KEY=당신의-API-키

# Windows (PowerShell)
$env:CRUSH_ANTHROPIC_BASE_URL="https://h-chat-api.autoever.com/v2/api/claude"
$env:CRUSH_ANTHROPIC_API_KEY="당신의-API-키"

# Linux/Mac
export CRUSH_ANTHROPIC_BASE_URL="https://h-chat-api.autoever.com/v2/api/claude"
export CRUSH_ANTHROPIC_API_KEY="당신의-API-키"
```

### 3단계: 빌드 및 실행
```bash
# Go 빌드
go build -o crush.exe .

# 실행
./crush.exe

# 또는 직접 실행
go run . "안녕하세요, 테스트입니다"
```

## 📋 요구사항

- **Go 1.21 이상** (https://golang.org/dl/)
- **회사 네트워크 접근** (VPN 필요시 연결)
- **API 키** (회사 IT팀에서 발급)

## 🔧 상세 설치 가이드

### Go 설치 (처음 사용시)
1. https://golang.org/dl/ 에서 최신 Go 다운로드
2. 설치 후 터미널에서 `go version` 확인
3. `go version go1.21.0` 또는 더 높은 버전 표시되면 성공

### API 키 발급 받기
1. 회사 IT팀에 "Claude API 키 발급" 요청
2. 받은 API 키를 `CRUSH_ANTHROPIC_API_KEY` 환경변수에 설정

### 네트워크 연결 확인
```bash
# 회사 서버 연결 테스트
curl -I https://h-chat-api.autoever.com/v2/api/claude/messages
# 응답이 오면 네트워크 정상
```

## ⚙️ 환경변수 상세

| 변수명 | 설명 | 예시 |
|--------|------|------|
| `CRUSH_ANTHROPIC_BASE_URL` | **필수** - 온프레미스 API 서버 주소 | `https://h-chat-api.autoever.com/v2/api/claude` |
| `CRUSH_ANTHROPIC_API_KEY` | **필수** - 인증을 위한 API 키 | `sk-your-company-api-key-here` |

## 🎯 사용법

### 기본 사용
```bash
# 텍스트 입력 후 엔터
./crush.exe
> 안녕하세요, 코드 리뷰를 도와주세요

# 직접 질문
./crush.exe "Python 코드 최적화 방법을 알려주세요"

# 파이프라인 사용
echo "이 에러를 해결해주세요" | ./crush.exe
```

### 파일 처리
```bash
# 코드 파일 분석
./crush.exe < main.py

# 여러 파일 처리
cat *.js | ./crush.exe "이 코드들을 리팩토링해주세요"
```

## 🔍 문제 해결

### 자주 발생하는 오류와 해결법

#### 1. `authentication failed (401)`
```
❌ 에러: authentication failed (401): check CRUSH_ANTHROPIC_API_KEY
✅ 해결: API 키 확인 및 재설정
```

#### 2. `endpoint not found (404)`
```
❌ 에러: endpoint not found (404): check CRUSH_ANTHROPIC_BASE_URL
✅ 해결: BASE_URL이 정확한지 확인
     올바른 형식: https://h-chat-api.autoever.com/v2/api/claude
```

#### 3. `network request failed`
```
❌ 에러: network request failed: dial tcp: no such host
✅ 해결: 
  1. VPN 연결 확인
  2. 회사 네트워크 접근 권한 확인
  3. 방화벽/프록시 설정 확인
```

#### 4. `server error (500)`
```
❌ 에러: server error (500): on-premise service issue
✅ 해결: 
  1. 잠시 후 다시 시도
  2. 회사 IT팀에 서버 상태 문의
```

### 디버깅 팁

#### 환경변수 확인
```bash
# Windows
echo %CRUSH_ANTHROPIC_BASE_URL%
echo %CRUSH_ANTHROPIC_API_KEY%

# Linux/Mac
echo $CRUSH_ANTHROPIC_BASE_URL
echo $CRUSH_ANTHROPIC_API_KEY
```

#### 상세 로그 확인
```bash
# 디버그 모드로 실행
CRUSH_LOG_LEVEL=debug ./crush.exe
```

#### 연결 테스트
```bash
# 수동 API 테스트
curl -X POST "https://h-chat-api.autoever.com/v2/api/claude/messages" \
  -H "Content-Type: application/json" \
  -H "Authorization: your-api-key" \
  -d '{
    "model": "claude-sonnet-4",
    "max_tokens": 1000,
    "messages": [{"role": "user", "content": "테스트"}]
  }'
```

## 📊 기술적 특징

- ✅ **SDK 우회**: Anthropic SDK 대신 직접 HTTP 클라이언트 사용
- ✅ **완벽한 호환성**: 회사 API 형식과 100% 일치
- ✅ **에러 복구**: "canceled" 에러 완전 해결
- ✅ **최대 성능**: 8192 토큰 지원, 60초 타임아웃
- ✅ **보안**: Authorization 헤더 지원

## 🏢 회사 환경 최적화

### 프록시 환경에서 사용
```bash
# 프록시 설정 (필요시)
set HTTP_PROXY=http://proxy.company.com:8080
set HTTPS_PROXY=http://proxy.company.com:8080
```

### 영구 환경변수 설정

#### Windows
1. **시스템 속성** → **고급** → **환경 변수**
2. **시스템 변수**에 추가:
   - `CRUSH_ANTHROPIC_BASE_URL` = `https://h-chat-api.autoever.com/v2/api/claude`
   - `CRUSH_ANTHROPIC_API_KEY` = `당신의-API-키`

#### Linux/Mac
```bash
# ~/.bashrc 또는 ~/.zshrc에 추가
echo 'export CRUSH_ANTHROPIC_BASE_URL="https://h-chat-api.autoever.com/v2/api/claude"' >> ~/.bashrc
echo 'export CRUSH_ANTHROPIC_API_KEY="당신의-API-키"' >> ~/.bashrc
source ~/.bashrc
```

## 📞 지원

문제가 발생하면:
1. **이 README의 문제 해결 섹션** 확인
2. **에러 메시지**와 **로그**를 정확히 기록
3. **네트워크 연결** 및 **환경변수** 재확인

## 🔐 보안 주의사항

- ❌ API 키를 코드에 하드코딩하지 마세요
- ❌ API 키를 public 저장소에 커밋하지 마세요  
- ✅ 환경변수로만 API 키 관리
- ✅ 회사 보안 정책 준수

---

**🎉 이제 회사에서 Claude를 마음껏 사용하세요!**