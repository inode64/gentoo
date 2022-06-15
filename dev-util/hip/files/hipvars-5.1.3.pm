#!/usr/bin/perl -w
package hipvars;

$HIP_BASE_VERSION_MAJOR = "@HIP_BASE_VERSION_MAJOR@";
$HIP_BASE_VERSION_MINOR = "@HIP_BASE_VERSION_MINOR@";

$isWindows = 0;
$HIP_PATH='/usr';
$ROCM_PATH='/usr';
$CUDA_PATH='/opt/cuda';
$HSA_PATH='/usr';
$HIP_CLANG_PATH='@CLANG_PATH@';
$HIP_CLANG_INCLUDE_PATH='@CLANG_INCLUDE_PATH@';
$HIP_ROCCLR_HOME=$HIP_PATH;
$HIP_PLATFORM='amd';
$HIP_COMPILER = "clang";
$HIP_RUNTIME = "rocclr";
$HIP_VERSION_MAJOR = $HIP_BASE_VERSION_MAJOR;
$HIP_VERSION_MINOR = $HIP_BASE_VERSION_MINOR;
$HIP_VERSION_PATCH = "@HIP_VERSION_PATCH@";
$HIP_VERSION="$HIP_VERSION_MAJOR.$HIP_VERSION_MINOR.$HIP_VERSION_PATCH";
