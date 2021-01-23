#!/bin/bash

BUILD_PATH="$1"
BUILD_SOURCE_PATH="$2"
BUILD_SYSTEM_PATH="$3"

mkdir -p "$BUILD_PATH/sketch/pico"

echo "#include <boards/pico.h>" > "$BUILD_PATH/sketch/pico/config_autogen.h"

cp ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/src/common/pico_base/include/pico/version.h.in $BUILD_PATH/sketch/pico/version.h

PICO_SDK_VERSION_MAJOR=$(sed -n 's/.*PICO_SDK_VERSION_MAJOR \([0-9]\).*/\1/p' ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/pico_sdk_version.cmake)
PICO_SDK_VERSION_MINOR=$(sed -n 's/.*PICO_SDK_VERSION_MINOR \([0-9]\).*/\1/p' ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/pico_sdk_version.cmake)
PICO_SDK_VERSION_REVISION=$(sed -n 's/.*PICO_SDK_VERSION_REVISION \([0-9]\).*/\1/p' ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/pico_sdk_version.cmake)
PICO_SDK_VERSION_STRING="${PICO_SDK_VERSION_MAJOR}.${PICO_SDK_VERSION_MINOR}.${PICO_SDK_VERSION_REVISION}"

sed -e "s/\${PICO_SDK_VERSION_MAJOR}/${PICO_SDK_VERSION_MAJOR}/" \
    -e "s/\${PICO_SDK_VERSION_MINOR}/${PICO_SDK_VERSION_MINOR}/" \
    -e "s/\${PICO_SDK_VERSION_REVISION}/${PICO_SDK_VERSION_REVISION}/" \
    -e "s/\${PICO_SDK_VERSION_STRING}/${PICO_SDK_VERSION_STRING}/" \
    -i $BUILD_PATH/sketch/pico/version.h
