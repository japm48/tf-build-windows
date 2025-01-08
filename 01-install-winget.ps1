# SPDX-License-Identifier: 0BSD

# Execute as admin:
#   powershell -ExecutionPolicy Bypass .\01-install-winget.ps1


Install-PackageProvider -Name NuGet -Force
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery
Repair-WinGetPackageManager

# Reload PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

