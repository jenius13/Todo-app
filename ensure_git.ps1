$paths = @(
  'C:\Program Files\Git\cmd\git.exe',
  'C:\Program Files\Git\bin\git.exe',
  'C:\Program Files (x86)\Git\cmd\git.exe',
  'C:\Program Files (x86)\Git\bin\git.exe',
  "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe",
  "$env:ProgramFiles\Git\cmd\git.exe",
  "$env:ProgramFiles(x86)\Git\cmd\git.exe"
)

foreach ($p in $paths) {
  if (Test-Path $p) {
    $dir = Split-Path $p -Parent
    Write-Host "Found git at: $p"
    Write-Host "Adding $dir to PATH for this session"
    $env:Path = $env:Path + ';' + $dir
    Write-Host "New PATH: $env:Path"
    Write-Host "git version:"
    git --version
    exit 0
  }
}

Write-Host 'GIT_NOT_FOUND'
