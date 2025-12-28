# Ultimate Android Build Fix
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$scriptPath\.."

# Stops Gradle daemon and cleans all caches completely

Write-Host "========================================"
Write-Host " ULTIMATE GRADLE CLEAN"
Write-Host "========================================"
Write-Host ""

# Step 1: Stop Gradle Daemon
Write-Host "Step 1: Stopping Gradle daemon..." -ForegroundColor Yellow
Set-Location "android"
if (Test-Path "gradlew.bat") {
    .\gradlew.bat --stop
    Write-Host "Gradle daemon stopped" -ForegroundColor Green
} else {
    Write-Host "gradlew.bat not found, skipping" -ForegroundColor Gray
}
Set-Location ".."
Write-Host ""

# Step 2: Clean ALL project build folders
Write-Host "Step 2: Cleaning ALL build folders..." -ForegroundColor Yellow

$folders = @(
    "build",
    ".dart_tool",
    ".idea",
    "android\.gradle",
    "android\.idea",
    "android\app\build",
    "android\build",
    "android\local.properties"
)

foreach ($folder in $folders) {
    if (Test-Path $folder) {
        Write-Host "  Removing: $folder" -ForegroundColor Gray
        Remove-Item -Path $folder -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  Done: $folder" -ForegroundColor Green
    }
}
Write-Host ""

# Step 3: Clean Gradle cache
Write-Host "Step 3: Cleaning Gradle user cache..." -ForegroundColor Yellow
$gradleCache = "$env:USERPROFILE\.gradle\caches"
if (Test-Path $gradleCache) {
    Remove-Item -Path $gradleCache -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Gradle cache cleared" -ForegroundColor Green
} else {
    Write-Host "Gradle cache not found" -ForegroundColor Gray
}
Write-Host ""

# Step 4: Clean Kotlin daemon
Write-Host "Step 4: Cleaning Kotlin daemon..." -ForegroundColor Yellow
$kotlinDaemon = "$env:USERPROFILE\.kotlin"
if (Test-Path $kotlinDaemon) {
    Remove-Item -Path $kotlinDaemon -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Kotlin daemon cache cleared" -ForegroundColor Green
} else {
    Write-Host "Kotlin cache not found" -ForegroundColor Gray
}
Write-Host ""

Write-Host "========================================"
Write-Host " COMPLETE!"
Write-Host "========================================"
Write-Host ""
Write-Host "CRITICAL NEXT STEPS:" -ForegroundColor Red
Write-Host "1. CLOSE IDE COMPLETELY (IntelliJ/Android Studio)" -ForegroundColor Yellow
Write-Host "2. Open IDE again" -ForegroundColor Yellow
Write-Host "3. File > Invalidate Caches > Invalidate and Restart" -ForegroundColor Yellow
Write-Host "4. After restart: Build > Rebuild Project" -ForegroundColor Yellow
Write-Host "5. Run the app" -ForegroundColor Yellow
Write-Host ""
