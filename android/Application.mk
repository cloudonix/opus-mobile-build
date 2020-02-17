##APP_ABI := $(filter arm%, $(NDK_ALL_ABIS))
APP_OPTIM:= release
APP_ABI := arm64-v8a armeabi-v7a x86 x86_64
LOCAL_CPP_FEATURES := rtti features
APP_STL := c++_static
NDK_TOOLCHAIN_VERSION := 5.4
