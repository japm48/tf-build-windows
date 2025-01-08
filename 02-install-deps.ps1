# SPDX-License-Identifier: 0BSD

# Execute as admin:
#   powershell -ExecutionPolicy Bypass .\02-install-deps.ps1


. $PSScriptRoot\_config.ps1

mkdir -Force $TOOLS_DIR

## Install VS 2022 Build tools with C++ compiler (use default install path)
# References:
#  https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2022
#  https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2022
winget install Microsoft.VisualStudio.2022.BuildTools --override "--wait --passive --addProductLang en-US --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"

## Install bazelisk
winget install --id=Bazel.Bazelisk -e --location $TOOLS_DIR\bazelisk

## Install LLVM
winget install --id=LLVM.LLVM -v $LLVM_VERSION -e --location $TOOLS_DIR\llvm

## Install MSYS2
winget install --id=MSYS2.MSYS2 -e --location $TOOLS_DIR\msys2

function msys2_bash_exec {
    & $TOOLS_DIR\msys2\msys2_shell.cmd -defterm -no-start -here -msys -shell bash -c $args[0]
}

# update msys2 (essential packages first)
msys2_bash_exec "pacman --noconfirm -Syu"
# install msys2 deps
msys2_bash_exec "pacman --noconfirm -S git patch unzip rsync"

## Python 3.12
winget install --id=Python.Python.$PYTHON_VERSION -e --location c:\tf-build\python
& $TOOLS_DIR\python\python.exe -m pip install -U pip
& $TOOLS_DIR\python\python.exe -m pip install -U six numpy wheel packaging
& $TOOLS_DIR\python\python.exe -m pip install -U keras_preprocessing --no-deps

# Reload PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
