# 🚀 RUN SCHEDULE TUNEUP APP - Helper Script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$scriptPath\.."

# Otomatis detect device dan run app

Write-Host "🚀 Schedule TuneUp - Quick Run Script" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Set Flutter PATH (Check common locations)
$possiblePaths = @("C:\src\flutter\bin", "D:\flutter\bin", "D:\src\flutter\bin")
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $env:Path += ";$path"
        break
    }
}

# Check devices
Write-Host "📱 Checking connected devices..." -ForegroundColor Yellow
$devices = flutter devices 2>&1
Write-Host $devices
Write-Host ""

# Ask user if want to clean build
$clean = Read-Host "Do you want to clean build first? (y/n) [Default: n]"
if ($clean -eq "y" -or $clean -eq "Y") {
    Write-Host "🧹 Cleaning build..." -ForegroundColor Yellow
    flutter clean
    flutter pub get
    Write-Host "✅ Clean complete!" -ForegroundColor Green
    Write-Host ""
}

# Run app
Write-Host "🚀 Launching app..." -ForegroundColor Green
Write-Host ""
Write-Host "💡 Tip: Setelah app running, tekan:" -ForegroundColor Cyan
Write-Host "   - 'r' untuk hot reload" -ForegroundColor White
Write-Host "   - 'R' untuk hot restart" -ForegroundColor White
Write-Host "   - 'q' untuk quit" -ForegroundColor White
Write-Host ""

# Run app - Flutter will auto-select device if only one
flutter run

Write-Host ""
Write-Host "✅ App closed" -ForegroundColor Green
