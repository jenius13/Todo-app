# Railway를 위한 배포 가이드

## 배포 단계

### 1. GitHub에 저장소 생성

```bash
git init
git add .
git commit -m "Initial commit: Todo app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/todo-app.git
git push -u origin main
```

### 2. Railway 회원가입 및 로그인

[railway.app](https://railway.app)에 방문하여 가입하세요.

### 3. Railway CLI 설치 (선택사항)

```bash
npm install -g @railway/cli
```

### 4. Railway 대시보드에서 배포

#### 방법 1: GitHub 연동 (추천)

1. Railway 대시보드에서 **"New Project"** 클릭
2. **"Deploy from GitHub"** 선택
3. 저장소 권한 승인
4. 방금 생성한 `todo-app` 저장소 선택
5. Railway가 자동으로 감지하고 배포 시작

#### 방법 2: Railway CLI 사용

```bash
railway login
railway init
railway up
```

### 5. 환경 설정 (필요시)

Railway 대시보드에서:
- **Variables** 탭에서 필요한 환경 변수 추가
- 현재 프로젝트는 특별한 환경 변수가 필요 없습니다

### 6. 배포 완료

배포가 완료되면 Railway가 제공하는 URL에서 앱을 확인할 수 있습니다.

예: `https://your-todo-app.up.railway.app`

## 데이터베이스 (선택사항)

### SQLite (현재 설정)

현재는 SQLite를 사용하고 있습니다. Railway의 ephemeral 파일 시스템에서는 앱 재시작 시 데이터가 초기화될 수 있습니다.

### PostgreSQL 사용 (권장)

1. Railway 대시보드에서 PostgreSQL 데이터베이스 추가
2. 다음 패키지 설치:

```bash
npm install pg
```

3. API 라우트 수정하여 PostgreSQL 연동

## 트러블슈팅

### 배포 실패

1. Railway 대시보드에서 빌드 로그 확인
2. `npm run build`가 로컬에서 정상 작동하는지 확인
3. Node.js 버전이 호환되는지 확인

### 데이터가 초기화됨

- SQLite를 사용할 경우, Railway의 ephemeral 파일 시스템으로 인해 발생
- PostgreSQL 데이터베이스 사용 권장

### 환경 변수 문제

Railway 대시보드의 Variables 탭에서 변수 확인 및 추가

## 앱 모니터링

Railway 대시보드에서:
- Logs: 실시간 로그 확인
- Metrics: CPU, 메모리 사용량 모니터링
- Deployments: 배포 이력 확인
- Settings: 도메인, 환경 변수 설정

## 도움말

- [Railway 문서](https://docs.railway.app)
- [Next.js 배포 가이드](https://nextjs.org/docs/deployment/railway)
