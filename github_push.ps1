param(
  $token = 'wjdwns!4701#',
  $owner = 'jenius13',
  $repo = 'todo-app',
  $private = $true
)

try {
  Write-Host "Creating repository $owner/$repo ..."
  $headers = @{ Authorization = "token $token"; 'User-Agent' = 'PowerShell' }
  $body = @{ name = $repo; private = $private } | ConvertTo-Json
  $resp = Invoke-RestMethod -Method Post -Uri 'https://api.github.com/user/repos' -Headers $headers -Body $body -ContentType 'application/json'
  Write-Host "Repository created: $($resp.html_url)"
} catch {
  Write-Host "Create repo failed:`n$($_ | Out-String)"
  exit 1
}

try {
  Write-Host "Collecting files..."
  $base = Get-Location
  $files = Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notmatch '\\.git\\' -and $_.FullName -notmatch '\\node_modules\\' -and $_.Name -ne 'desktop.ini' }
  $treeItems = @()

  foreach ($f in $files) {
    $rel = $f.FullName.Substring($base.Path.Length+1).Replace('\\','/')
    Write-Host "Processing: $rel"
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $b64 = [System.Convert]::ToBase64String($bytes)
    $blobBody = @{ content = $b64; encoding = 'base64' } | ConvertTo-Json
    $r = Invoke-RestMethod -Method Post -Uri "https://api.github.com/repos/$owner/$repo/git/blobs" -Headers $headers -Body $blobBody -ContentType 'application/json'
    $treeItems += @{ path = $rel; mode = '100644'; type = 'blob'; sha = $r.sha }
  }

  Write-Host "Creating tree..."
  $treeBody = @{ tree = $treeItems } | ConvertTo-Json -Depth 10
  $treeResp = Invoke-RestMethod -Method Post -Uri "https://api.github.com/repos/$owner/$repo/git/trees" -Headers $headers -Body $treeBody -ContentType 'application/json'

  Write-Host "Creating commit..."
  $commitBody = @{ message = 'Initial commit: Todo app'; tree = $treeResp.sha } | ConvertTo-Json
  $commitResp = Invoke-RestMethod -Method Post -Uri "https://api.github.com/repos/$owner/$repo/git/commits" -Headers $headers -Body $commitBody -ContentType 'application/json'

  Write-Host "Creating branch ref..."
  $refBody = @{ ref = 'refs/heads/main'; sha = $commitResp.sha } | ConvertTo-Json
  $refResp = Invoke-RestMethod -Method Post -Uri "https://api.github.com/repos/$owner/$repo/git/refs" -Headers $headers -Body $refBody -ContentType 'application/json'

  Write-Host "Push completed. Repository URL: $($resp.html_url)"
} catch {
  Write-Host "Push failed:`n$($_ | Out-String)"
  exit 1
}
