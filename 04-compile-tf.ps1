# SPDX-License-Identifier: 0BSD

# Execute as admin:
#   powershell -ExecutionPolicy Bypass .\04-compile-tf.ps1

. $PSScriptRoot\_config.ps1

mkdir -Force $TMP_DIR
cd $BUILD_DIR\tensorflow

# Reload default PATH env value
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

$env:Path = "$TOOLS_DIR\bazelisk;" + $env:Path
$env:Path = "$TOOLS_DIR\python;$TOOLS_DIR\python\Scripts;" + $env:Path

$TOOLS_DIR_NIX = $TOOLS_DIR -replace '\\','/'

$env:BAZEL_SH = "$TOOLS_DIR_NIX/msys2/usr/bin/bash.exe"
$env:BAZEL_VS = $VS_DIR -replace '\\','/'
$env:BAZEL_VC = $VC_DIR -replace '\\','/'

$env:TMP = "$TMP_DIR"
$env:TEMP = "$TMP_DIR"


if ( $BUILD_CWISEOP_BEFORE )
{
    bazelisk --output_user_root=$BUILD_DIR/bazel build $BUILD_CWISEOP_BEFORE_PARAMS.split() --config=win_clang --repo_env=TF_PYTHON_VERSION=3.12 //tensorflow/core/kernels:cwise_op
}

if ( $BUILD_PYTHON_WHEEL )
{
    bazelisk --output_user_root=$BUILD_DIR/bazel build --config=win_clang --repo_env=TF_PYTHON_VERSION=3.12 //tensorflow/tools/pip_package:wheel --repo_env=WHEEL_NAME=tensorflow_cpu
}

if ( $BUILD_LIBTENSORFLOW )
{
    bazelisk --output_user_root=$BUILD_DIR/bazel build --config=win_clang --repo_env=TF_PYTHON_VERSION=3.12 //tensorflow/tools/lib_package:libtensorflow
}

