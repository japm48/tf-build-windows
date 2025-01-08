# SPDX-License-Identifier: 0BSD

$TOOLS_DIR = "c:\tf-build"
#$BUILD_DIR = "c:\tf-build"
#$TMP_DIR = "c:\tf-build\tmp"
$BUILD_DIR = "r:\tf-build"
$TMP_DIR = "r:\tf-build\tmp"

$TENSORFLOW_ZIP_URL = "https://github.com/tensorflow/tensorflow/archive/refs/tags/v2.18.0.zip"

$LLVM_VERSION = "18.1.8"
$PYTHON_VERSION = "3.12"


$BUILD_CWISEOP_BEFORE = $true
# https://bazel.build/reference/command-line-reference#flag--local_cpu_resources
#$BUILD_CWISEOP_BEFORE_PARAMS = "--local_cpu_resources=8"
$BUILD_CWISEOP_BEFORE_PARAMS = "--local_cpu_resources=HOST_CPUS"

$BUILD_PYTHON_WHEEL = $true
#$BUILD_LIBTENSORFLOW = $false
$BUILD_LIBTENSORFLOW = $true

$VS_DIR = "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools"
$VC_DIR = "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC"



