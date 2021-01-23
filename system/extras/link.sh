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

# make a list of all object files
for file in ${BUILD_PATH}/core/pico/*.o; do
  OBJECT_FILES="${OBJECT_FILES} ${file}"
done

# remove stale static library
rm -rf ${BUILD_PATH}/core/pico/libpico.a

# link static library from all object files
echo "${COMPILER_COMMAND} ${BUILD_PATH}/core/pico/libpico.a ${OBJECT_FILES}"
${COMPILER_COMMAND} ${BUILD_PATH}/core/pico/libpico.a ${OBJECT_FILES}
