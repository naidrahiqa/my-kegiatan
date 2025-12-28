# Fix Gradle Cache Issues
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$scriptPath\.."

# Solusi untuk error: "this and base files have different roots"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Gradle Cache Fix Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Current directory: $projectPath" -ForegroundColor Yellow
Write-Host ""

# Step 1: Clean project build folders
Write-Host "Step 1: Cleaning project build folders..." -ForegroundColor Yellow
Write-Host ""

$folders = @("build", ".dart_tool", "android\.gradle", "android\.idea", "android\app\build")

foreach ($folder in $folders) {
    $fullPath = Join-Path $projectPath $folder
    if (Test-Path $fullPath) {
        Write-Host "  Removing: $folder" -ForegroundColor Gray
        Remove-Item -Path $fullPath -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  ✓ Removed: $folder" -ForegroundColor Green
    } else {
        Write-Host "  - Not found: $folder (already clean)" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "Step 2: Cleaning Gradle user cache..." -ForegroundColor Yellow
Write-Host ""

# Clean Gradle cache in user home
$gradleHome = Join-Path $env:USERPROFILE ".gradle\caches"
if (Test-Path $gradleHome) {
    Write-Host "  Found Gradle cache at: $gradleHome" -ForegroundColor Gray
    Write-Host "  Removing modules-2..." -ForegroundColor Gray
    
    $modules2 = Join-Path $gradleHome "modules-2"
    if (Test-Path $modules2) {
        Remove-Item -Path $modules2 -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  ✓ Gradle modules-2 cache cleared" -ForegroundColor Green
    }
} else {
    Write-Host "  - Gradle cache not found" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "Step 3: Cleaning Pub cache for path_provider..." -ForegroundColor Yellow
Write-Host ""

$pubCache = Join-Path $env:LOCALAPPDATA "Pub\Cache\hosted\pub.dev"
if (Test-Path $pubCache) {
    $pathProviders = Get-ChildItem -Path $pubCache -Filter "path_provider*" -Directory -ErrorAction SilentlyContinue
    
    if ($pathProviders) {
        foreach ($provider in $pathProviders) {
            Write-Host "  Removing: $($provider.Name)" -ForegroundColor Gray
            Remove-Item -Path $provider.FullName -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "  ✓ Removed: $($provider.Name)" -ForegroundColor Green
        }
    } else {
        Write-Host "  - No path_provider packages found" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Clean Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Open your IDE (Android Studio or IntelliJ IDEA)" -ForegroundColor White
Write-Host "2. File -> Invalidate Caches -> Invalidate and Restart" -ForegroundColor White
Write-Host "3. After restart, run: flutter pub get" -ForegroundColor White
Write-Host "4. Then rebuild project" -ForegroundColor White
Write-Host ""

Write-Host "Or if you're using VS Code:" -ForegroundColor Yellow
Write-Host "1. Close VS Code completely" -ForegroundColor White
Write-Host "2. Run: flutter pub get (from terminal)" -ForegroundColor White
Write-Host "3. Reopen VS Code and run the app" -ForegroundColor White
Write-Host ""

Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
