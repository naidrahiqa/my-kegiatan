# Fix Gradle Cache Issues
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$scriptPath\.."

Write-Host "========================================"
Write-Host " Gradle Cache Fix"
Write-Host "========================================"
Write-Host ""

# Clean project folders
Write-Host "Cleaning project folders..."
Remove-Item -Path "build" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path ".dart_tool" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "android\.gradle" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "android\.idea" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "android\app\build" -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Done cleaning project folders"
Write-Host ""

# Clean Gradle cache
Write-Host "Cleaning Gradle cache..."
$gradleCache = "$env:USERPROFILE\.gradle\caches\modules-2"
if (Test-Path $gradleCache) {
    Remove-Item -Path $gradleCache -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Gradle cache cleaned"
} else {
    Write-Host "Gradle cache not found"
}
Write-Host ""

Write-Host "========================================"
Write-Host " Complete!"
Write-Host "========================================"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. IntelliJ/Android Studio: File > Invalidate Caches > Restart"
Write-Host "2. VS Code: Close and reopen"
Write-Host "3. Run: flutter pub get"
Write-Host "4. Run the app"
Write-Host ""
