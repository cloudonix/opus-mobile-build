FROM cloudonix/android-ndk-cmakego:ndk14

WORKDIR /app
ADD Makefile Android.mk Application.mk /app/
RUN make all dist
RUN cd /app/release && tar -zcf opus-android.tar.gz android
