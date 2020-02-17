FROM cloudonix/android-ndk-cmakego

ADD https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz /app/opus.tar.gz
WORKDIR /app/opus
RUN tar -xf /app/opus.tar.gz --strip=1
ADD Android.mk /app/opus/jni/Android.mk
ADD Application.mk /app/opus/jni/Application.mk
WORKDIR /app/opus/jni
RUN mv ../src ../include ../silk ../celt ../*.mk ./
RUN /opt/android/ndk/ndk-build clean
RUN /opt/android/ndk/ndk-build
RUN for arch in $(awk -F' := ' '$1=="APP_ABI"{print$2}' < Application.mk); do \
	install ../obj/local/${arch}/libopus.a -m644 -D /app/release/android/${arch}/lib/libopus.a; \
	install -D -t /app/release/android/${arch}/include/opus include/*; \
	done
