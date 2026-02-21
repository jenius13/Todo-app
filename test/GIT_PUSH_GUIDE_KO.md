# GitHub 푸시 가이드 (VS Code 사용)

## 방법 1: VS Code의 Source Control 사용 (가장 간단)

1. VS Code 왼쪽 사이드바에서 **Source Control** 아이콘 클릭 (분기 모양)
2. **Initialize Repository** 클릭
3. 모든 파일이 표시될 것입니다
4. Message 입력창에 "Initial commit: Todo app" 입력
5. **Commit** 버튼 클릭
6. "Publish Branch" 또는 "Set remote" 옵션이 나타날 것입니다
7. GitHub에 로그인하고 새 저장소 만들기 진행

## 방법 2: GitHub 데스크톱 앱 사용 (추천)

### 1. GitHub Desktop 설치

```
winget install GitHub.GitHubDesktop
```

또는 https://desktop.github.com 에서 직접 다운로드

### 2. 저장소 추가

- GitHub Desktop 열기
- **Add > Add Existing Repository**
- 프로젝트 폴더 선택: `c:\Users\USER\Documents\Code\test`

### 3. 초기 커밋

- Summary: "Initial commit: Todo app"
- Description: "Full-stack Todo app with Next.js"
- **Commit to main** 클릭

### 4. GitHub에 발행

- **Publish repository** 클릭
- GitHub 계정으로 로그인
- Repository name: `todo-app`
- Description: "A full-stack Todo application with Next.js and SQLite"
- **Publish Repository** 클릭

## 방법 3: PowerShell에서 수동으로 설치 후 진행

VS Code 내의 터미널을 **닫고** VS Code를 **완전히 재시작**하면 Git이 PATH에 추가됩니다.

이후 다음 명령어 실행:

```bash
cd "c:\Users\USER\Documents\Code\test"
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git init
git add .
git commit -m "Initial commit: Todo app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/todo-app.git
git push -u origin main
```

## GitHub 저장소 생성

위의 모든 방법 전에 GitHub에서 저장소를 먼저 생성해야 합니다:

1. https://github.com/new 방문
2. Repository name: `todo-app`
3. Description: "A full-stack Todo application"
4. **Create repository** 클릭

그 후 위의 방법 중 하나를 선택하여 진행하세요!
