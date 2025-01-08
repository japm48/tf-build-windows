# SPDX-License-Identifier: 0BSD

# Execute as admin:
#   powershell -ExecutionPolicy Bypass .\03-download-tf-src.ps1

. $PSScriptRoot\_config.ps1

mkdir -Force $BUILD_DIR

cd $BUILD_DIR

curl.exe -L -o tf-src.zip $TENSORFLOW_ZIP_URL

function msys2_bash_exec {
    & $TOOLS_DIR\msys2\msys2_shell.cmd -defterm -no-start -here -msys -shell bash -c $args[0]
}

# Unzip sources
echo "Extracting sources zip file..."
msys2_bash_exec "unzip -q tf-src.zip -d ./tf-src/"
# folder must be named tensorflow
msys2_bash_exec "mv tf-src/tensorflow-* ./tensorflow"
msys2_bash_exec "rmdir tf-src"
#.\msys2\msys2.exe bash -c "mv tensorflow-*/ tensorflow"

