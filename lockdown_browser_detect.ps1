$path = "C:\Program Files (x86)\Respondus LockDown Browser\LockDown.exe"
if (Test-Path -Path $path) {
    $exe = Get-Item -Path $path
    if ($exe.LastWriteTimeUtc.Date -eq (Get-Date "2014-06-09")) {
        Write-Host "Detected"
    }
}
