# RaptorQ in JABCode

## How to build

### Install LLVM

```bash
sudo apt install libclang-dev
```

### Generate FFI files

```bash
cd mobile
flutter pub run ffigen
```

### Build libpng

```bash
git clone https://github.com/julienr/libpng-android.git
cd libpng-android
./build.sh
```

### Build libtiff

```bash
git clone https://gitlab.com/libtiff/libtiff
cd libtiff
./autogen.sh

#arm64-v8a
./configure --host=aarch64-linux-android --prefix /absolute/path/to/store/libs/ arm64-v8a CC=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang CXX=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang++
make -j16
make install

#armeabi-v7a
./configure --host=arm-linux-androideabi --prefix /absolute/path/to/store/libs/ armeabi-v7a CC=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang CXX=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang++
make -j16
make install

#x86
./configure --host=x86-linux-android --prefix /absolute/path/to/store/libs/x86/ CC=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android21-clang CXX=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android21-clang++
make -j16
make install

#x86_64
./configure --host=x86_64-linux-android --prefix /absolute/path/to/store/libs/x86_64/ CC=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android21-clang CXX=$ANDROID_SDK_ROOT/ndk/21.4.7075529/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android21-clang++
make -j16
make install
```
