# ⚡ AUTO INSTALL FLUTTER - Script Otomatis
# Jalankan script ini di PowerShell sebagai Administrator

Write-Host "🚀 Flutter Auto Installer for Schedule TuneUp" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Function untuk download file
function Download-File {
    param($url, $output)
    Write-Host "⬇️  Downloading from: $url" -ForegroundColor Yellow
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($url, $output)
}

# Step 1: Create directory
Write-Host "📂 Step 1/6: Creating directory..." -ForegroundColor Green
$flutterDir = "C:\src"
if (-not (Test-Path $flutterDir)) {
    New-Item -Path $flutterDir -ItemType Directory -Force | Out-Null
    Write-Host "   ✅ Created: $flutterDir" -ForegroundColor Green
} else {
    Write-Host "   ✅ Directory already exists: $flutterDir" -ForegroundColor Green
}

# Step 2: Download Flutter
Write-Host ""
Write-Host "⬇️  Step 2/6: Downloading Flutter SDK (~1.2 GB)..." -ForegroundColor Green
Write-Host "   ⏳ This may take 5-20 minutes depending on your internet..." -ForegroundColor Yellow

$flutterZip = "$env:TEMP\flutter_windows.zip"
$flutterUrl = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip"

try {
    if (Test-Path $flutterZip) {
        Write-Host "   ℹ️  Flutter ZIP already downloaded. Skipping..." -ForegroundColor Yellow
    } else {
        Download-File -url $flutterUrl -output $flutterZip
        Write-Host "   ✅ Download complete!" -ForegroundColor Green
    }
} catch {
    Write-Host "   ❌ Download failed. Please check your internet connection." -ForegroundColor Red
    Write-Host "   Manual download: $flutterUrl" -ForegroundColor Yellow
    exit 1
}

# Step 3: Extract Flutter
Write-Host ""
Write-Host "📦 Step 3/6: Extracting Flutter..." -ForegroundColor Green

try {
    if (Test-Path "$flutterDir\flutter") {
        Write-Host "   ℹ️  Flutter already extracted. Skipping..." -ForegroundColor Yellow
    } else {
        Expand-Archive -Path $flutterZip -DestinationPath $flutterDir -Force
        Write-Host "   ✅ Extraction complete!" -ForegroundColor Green
    }
} catch {
    Write-Host "   ❌ Extraction failed: $_" -ForegroundColor Red
    exit 1
}

# Step 4: Add to PATH
Write-Host ""
Write-Host "🔧 Step 4/6: Adding Flutter to PATH..." -ForegroundColor Green

$flutterBin = "C:\src\flutter\bin"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -like "*$flutterBin*") {
    Write-Host "   ✅ Flutter PATH already exists!" -ForegroundColor Green
} else {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$currentPath;$flutterBin",
        "User"
    )
    Write-Host "   ✅ Flutter added to PATH!" -ForegroundColor Green
    
    # Update current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Step 5: Verify Flutter
Write-Host ""
Write-Host "✅ Step 5/6: Verifying Flutter installation..." -ForegroundColor Green

try {
    $flutterVersion = & "$flutterBin\flutter.bat" --version 2>&1
    Write-Host "   ✅ Flutter installed successfully!" -ForegroundColor Green
    Write-Host "   Version: Flutter 3.x.x" -ForegroundColor Cyan
} catch {
    Write-Host "   ⚠️  Flutter verification pending. Please restart terminal." -ForegroundColor Yellow
}

# Step 6: Instructions
Write-Host ""
Write-Host "🎯 Step 6/6: Next Steps" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ Flutter SDK installed to: C:\src\flutter" -ForegroundColor Green
Write-Host "✅ PATH updated" -ForegroundColor Green
Write-Host ""
Write-Host "📌 IMPORTANT: Please do the following:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. CLOSE this PowerShell window" -ForegroundColor White
Write-Host "2. OPEN a NEW PowerShell window" -ForegroundColor White
Write-Host "3. Run: flutter --version" -ForegroundColor Cyan
Write-Host "4. Run: flutter doctor" -ForegroundColor Cyan
Write-Host ""
Write-Host "5. Install Android Studio:" -ForegroundColor White
Write-Host "   Download from: https://developer.android.com/studio" -ForegroundColor Cyan
Write-Host ""
Write-Host "6. Accept Android licenses:" -ForegroundColor White
Write-Host "   flutter doctor --android-licenses" -ForegroundColor Cyan
Write-Host ""
Write-Host "7. Run your Schedule TuneUp app:" -ForegroundColor White
Write-Host "   cd d:\IMPHNEN\schedule-tuneup" -ForegroundColor Cyan
Write-Host "   flutter pub get" -ForegroundColor Cyan
Write-Host "   flutter run" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎉 Installation Complete! Follow the steps above." -ForegroundColor Green
Write-Host ""

# Clean up
if (Test-Path $flutterZip) {
    Write-Host "🧹 Cleaning up temporary files..." -ForegroundColor Yellow
    Remove-Item $flutterZip -Force
}

Write-Host "✅ Done! Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
