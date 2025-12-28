# Script untuk otomatis accept Android Licenses
# Auto-detect Flutter Path
$flutterPath = "C:\src\flutter\bin"
if (Test-Path "D:\flutter\bin") { $flutterPath = "D:\flutter\bin" }
if (Test-Path "D:\src\flutter\bin") { $flutterPath = "D:\src\flutter\bin" }
$env:Path += ";$flutterPath"

Write-Host "Accepting Android Licenses..." -ForegroundColor Cyan

# Pipe 'y' to the command multiple times to accept all licenses
$y = "y`n" * 10
$y | & "$flutterPath\flutter.bat" doctor --android-licenses

Write-Host ""
Write-Host "Done! Please run: .\scripts\RUN_APP.ps1" -ForegroundColor Green
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
