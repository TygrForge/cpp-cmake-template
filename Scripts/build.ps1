param(
    [ValidateSet("Debug", "Release")]
    [string]$Config = "Debug",

    [ValidateSet("MSVC", "Clang", "GCC", "Default")]
    [string]$Compiler = "MSVC",

    [switch]$Clean
)

$ErrorActionPreference = "Stop"

# Locate the project root relative to this script.
$ProjectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $ProjectRoot

try {
    $Preset = "$($Compiler.ToLowerInvariant())-$($Config.ToLowerInvariant())"
    $BuildDir = Join-Path $ProjectRoot "build/$Preset"

    Write-Host "Project:    $ProjectRoot"
    Write-Host "Compiler:   $Compiler"
    Write-Host "Build type: $Config"
    Write-Host "Preset:     $Preset"

    # Clean the selected preset's build directory.
    if ($Clean) {
        Write-Host "Cleaning:   $BuildDir"

        if (Test-Path -LiteralPath $BuildDir) {
            Remove-Item -LiteralPath $BuildDir -Recurse -Force
        }
    }

    Write-Host ""

    # Configure
    & cmake --preset $Preset
    if ($LASTEXITCODE -ne 0) {
        throw "CMake configuration failed."
    }

    # Build
    & cmake --build --preset $Preset
    if ($LASTEXITCODE -ne 0) {
        throw "Build failed."
    }

    Write-Host ""
    Write-Host "Build completed successfully." -ForegroundColor Green
}
catch {
    Write-Error $_
    exit 1
}
finally {
    Pop-Location
}

# --- Usage
# In the PowerShell terminal, run the command: " Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass "
#    This lets you run the development scripts without changing the machine-wide policy.
#       - Applies only to the current PowerShell process.
#       - Doesn't permanently change your execution policy.
#       - Closing that terminal ends the change.
