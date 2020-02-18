# Build Instructions for Opus on Android

## Requirements

- Linux with Docker available

## Instructions

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
