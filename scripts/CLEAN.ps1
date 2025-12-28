# Flutter Clean Script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$scriptPath\.."

# Mengatasi error Android build

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Flutter Clean & Rebuild Helper" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check if Flutter is available
Write-Host "Checking Flutter..." -ForegroundColor Yellow
$flutterAvailable = $null -ne (Get-Command flutter -ErrorAction SilentlyContinue)

if ($flutterAvailable) {
    Write-Host "✓ Flutter CLI detected!" -ForegroundColor Green
    Write-Host ""
    
    # Flutter clean
    Write-Host "Running: flutter clean..." -ForegroundColor Yellow
    flutter clean
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Flutter clean completed!" -ForegroundColor Green
    } else {
        Write-Host "✗ Flutter clean failed!" -ForegroundColor Red
    }
    
    Write-Host ""
    
    # Flutter pub get
    Write-Host "Running: flutter pub get..." -ForegroundColor Yellow
    flutter pub get
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Dependencies installed!" -ForegroundColor Green
    } else {
        Write-Host "✗ Pub get failed!" -ForegroundColor Red
    }
    
} else {
    Write-Host "⚠ Flutter CLI not found in PATH" -ForegroundColor Yellow
    Write-Host "Using manual clean method..." -ForegroundColor Yellow
    Write-Host ""
    
    # Manual clean
    Write-Host "Removing build folder..." -ForegroundColor Yellow
    if (Test-Path "build") {
        Remove-Item -Path "build" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "✓ build/ removed" -ForegroundColor Green
    } else {
        Write-Host "- build/ not found (already clean)" -ForegroundColor Gray
    }
    
    Write-Host "Removing .dart_tool folder..." -ForegroundColor Yellow
    if (Test-Path ".dart_tool") {
        Remove-Item -Path ".dart_tool" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "✓ .dart_tool/ removed" -ForegroundColor Green
    } else {
        Write-Host "- .dart_tool/ not found (already clean)" -ForegroundColor Gray
    }
    
    Write-Host "Removing android/.gradle folder..." -ForegroundColor Yellow
    if (Test-Path "android/.gradle") {
        Remove-Item -Path "android/.gradle" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "✓ android/.gradle/ removed" -ForegroundColor Green
    } else {
        Write-Host "- android/.gradle/ not found (already clean)" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "Manual clean completed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Open your IDE (VS Code / Android Studio)" -ForegroundColor White
    Write-Host "2. Run 'Flutter: Pub Get' from command palette" -ForegroundColor White
    Write-Host "3. Press F5 or click Run button" -ForegroundColor White
}

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Done!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Keep window open
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
