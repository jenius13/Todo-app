param(
  [string]$repoPath = 'C:\Users\USER\Documents\Code\test',
  [string]$remoteUrl = 'https://github.com/jenius13/Todo-app.git'
)

Set-Location $repoPath

# Find git
$gitCmd = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitCmd) {
  $candidates = @(
    'C:\Program Files\Git\cmd\git.exe',
    'C:\Program Files\Git\bin\git.exe',
    'C:\Program Files (x86)\Git\cmd\git.exe',
    'C:\Program Files (x86)\Git\bin\git.exe',
    "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe",
    "$env:ProgramFiles\Git\cmd\git.exe",
    "$env:ProgramFiles(x86)\Git\cmd\git.exe"
  )
  foreach ($p in $candidates) {
    if (Test-Path $p) { $gitCmd = $p; break }
  }
}

if (-not $gitCmd) {
  Write-Host 'GIT_NOT_FOUND'
  exit 1
}

if ($gitCmd -is [System.Management.Automation.CommandInfo]) {
  $gitPath = Split-Path $gitCmd.Source -Parent
} else {
  $gitPath = Split-Path $gitCmd -Parent
}

$env:Path = $env:Path + ';' + $gitPath
Write-Host "Using git at: $gitPath"

# Show version
try {
  & git --version
} catch {
  Write-Host "Failed to run git --version: $_"
}

# Configure user
& git config user.name "todo-user"
& git config user.email "you@example.com"

# Add and commit
& git add .
try {
  & git commit -m "Add start.sh for Railpack"
} catch {
  Write-Host "No changes to commit or commit failed: $_"
}

# Ensure main branch
& git branch -M main

# Ensure remote
$hasRemote = $false
try { $u = & git remote get-url origin; $hasRemote = $true } catch { $hasRemote = $false }
if (-not $hasRemote) {
  & git remote add origin $remoteUrl
}

# Push
try {
  & git push -u origin main
} catch {
  Write-Host "Git push failed: $_"
  exit 1
}

Write-Host "Push completed."
