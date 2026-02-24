@echo off

REM default ABI
set Target=arm64-v8a

REM kalau user kirim argumen
IF "%1"=="arm64-v8a" (
  set Target=arm64-v8a
) ELSE IF "%1"=="armeabi-v7a" (
  set Target=armeabi-v7a
)

echo Building for ABI: %Target%

cmake ^
  -DANDROID_ABI=%Target% ^
  -DANDROID_PLATFORM=android-24 ^
  -DCMAKE_TOOLCHAIN_FILE=%NDK_PATH%\build\cmake\android.toolchain.cmake ^
  -DANDROID_NDK=%NDK_PATH% ^
  -B build-%Target%

cmake --build build-%Target%