#!/bin/bash

export CMAKE_BUILD_PARALLEL_LEVEL=${CPU_COUNT}

if [[ ${HOST} =~ .*darwin.* ]]; then
  CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
else
  CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi

if [[ ${DEBUG_C} == yes ]]; then
  CMAKE_BUILD_TYPE=Debug
else
  CMAKE_BUILD_TYPE=Release
fi

mkdir build
cmake -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}"       \
      -DBUILD_SHARED_LIBS=ON                   \
      -DBOOST_ROOT=${CONDA_PREFIX}             \
      ${CMAKE_PLATFORM_FLAGS[@]}               \
      -B build/                                \
      -S .

cmake --build build
cmake --install build
