## build TA-Lib
## 
BUILD="$(pwd)/build/ta-lib"
TARGET="$(pwd)/lib"

cmake -S "ta-lib" -B "$BUILD" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$TARGET" \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DCMAKE_C_FLAGS="-O3 -w" \
    -DCMAKE_CXX_FLAGS="-O3 -w" \
    -DCMAKE_C_FLAGS_RELEASE="-O3 -march=native -fPIC" \
    -DBUILD_DEV_TOOLS=OFF

 cmake --build "$BUILD" --target install -- -j"$(nproc --ignore 2)"