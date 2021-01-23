#!/bin/sh

BUILD_PATH="$1"
BUILD_SOURCE_PATH="$2"
BUILD_SYSTEM_PATH="$3"

for argument in "$@"; do
  if [ "$argument" = "${BUILD_PATH}" ] || [ "$argument" = "${BUILD_SOURCE_PATH}" ] || [ "$argument" = "${BUILD_SYSTEM_PATH}" ]; then
    continue
  fi

  COMPILER_COMMAND="${COMPILER_COMMAND} $argument"
done

mkdir -p "${BUILD_PATH}/core/pico/"

# copy required c files
find ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/src/rp2_common -type f -iname "*.c" -exec cp {} ${BUILD_PATH}/core/pico/ \;
find ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/src/common -type f -iname "*.c" -exec cp {} ${BUILD_PATH}/core/pico/ \;

# copy required asm files
cp ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/src/rp2_common/hardware_irq/irq_handler_chain.S ${BUILD_PATH}/core/pico/
cp ${BUILD_SYSTEM_PATH}/drivers/pico-sdk/src/rp2_common/pico_standard_link/crt0.S ${BUILD_PATH}/core/pico/

# remove stale objects
rm -rf ${BUILD_PATH}/core/pico/*.o

# compile *.c and *.S files into objects
for file in ${BUILD_PATH}/core/pico/*.c ${BUILD_PATH}/core/pico/*.S; do
  echo "${COMPILER_COMMAND} ${file} -o ${file}.o"
  ${COMPILER_COMMAND} ${file} -o ${file}.o
done
