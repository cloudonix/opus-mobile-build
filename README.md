# Opus Build Instructions for Android and iOS

## Requirements

### Android

Linux with Android NDK (tested with NDK 14 and 18). Alternatively use Docker to build in a container.

### iOS

XCode 10.1 with iOS SDK

## Instructions

### Android

#### Native build

Create an environment variable named `ANDROID_NDK_ROOT` set to the absolute path to the NDK installation.

Change to the `android` directory and execute `make all dist`

After completing, the artifacts will be in the `release` folder.

### Container build

- Build the artifacts inside a container will all required dependencies pre-installed:

```
docker build -t opus-build .
```

- Extract artifacts from the container

```
docker create --name opus-artifacts opus-build
docker cp opus-artifacts:/app/release/android android-release
```

- Cleanup

```
docker rm opus-artifacts
docker rmi opus-build
```

After completing these stages, the artifacts will be in the `android-release` folder.

### iOS

Change to the `ios` directory and execute `make all dist`.

After completing, the artifacts will be in the `release` folder.
