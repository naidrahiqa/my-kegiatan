# Script Manual Install Android Command-line Tools
# Bypass Android Studio yang error

$sdkPath = "$env:LOCALAPPDATA\Android\Sdk"
$cmdlinePath = "$sdkPath\cmdline-tools"
$zipPath = "$env:TEMP\commandlinetools.zip"
$extractTemp = "$env:TEMP\cmdline-temp"
$url = "https://dl.google.com/android/repository/commandlinetools-win-10406996_latest.zip"

Write-Host "🚀 INSTALLING ANDROID COMMAND-LINE TOOLS XML MANUAL" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Target: $cmdlinePath" -ForegroundColor Yellow

# 1. Download
Write-Host "⬇️  Downloading Tools (ok. 130MB)..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $url -OutFile $zipPath
    Write-Host "✅ Download selesai!" -ForegroundColor Green
} catch {
    Write-Host "❌ Download gagal: $_" -ForegroundColor Red
    exit 1
}

# 2. Extract
Write-Host "📦 Extracting..." -ForegroundColor Yellow
if (Test-Path $extractTemp) { Remove-Item $extractTemp -Recurse -Force }
Expand-Archive -Path $zipPath -DestinationPath $extractTemp -Force

# 3. Setup Folder Structure (Harus: cmdline-tools/latest/bin)
# Hasil extract biasanya folder 'cmdline-tools' isinya 'bin', 'lib' dll.
# Kita perlu pindahin 'bin' dkk ke dalam folder 'latest'.

Write-Host "📂 Set up folder structure..." -ForegroundColor Yellow

# Hapus folder lama kalau ada
if (Test-Path $cmdlinePath) { Remove-Item $cmdlinePath -Recurse -Force }
New-Item -Path "$cmdlinePath\latest" -ItemType Directory -Force | Out-Null

# Pindahkan isi dari temp ke latest
$sourceContent = "$extractTemp\cmdline-tools\*" 
Move-Item -Path $sourceContent -Destination "$cmdlinePath\latest" -Force

# 4. Clean up
Remove-Item $zipPath -Force
Remove-Item $extractTemp -Recurse -Force

Write-Host "✅ Installation Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Sekarang coba jalankan ACCEPT_LICENSES.ps1 lagi!" -ForegroundColor Cyan
