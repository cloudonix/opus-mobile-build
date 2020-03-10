VERSION := 1.3.1
ARTIFACTSDIR := release/android
BUILDDIR := jni
TMPINSTALLDIR := obj

include Application.mk
ARCHS := $(APP_ABI)

CPP = clang -E
CFLAGS := -O3 -Wno-unused-label -g

all: download compile

jni/configure: # download target
	curl https://archive.mozilla.org/pub/opus/opus-$(VERSION).tar.gz | tar -zx
	mv opus-$(VERSION) jni

download: jni/configure
	# we dep on the existence of the configure script (which is resolved by downloading)
	cp *.mk $(BUILDDIR)

compile:
	${ANDROID_NDK_ROOT}/ndk-build -C $(BUILDDIR) clean
	${ANDROID_NDK_ROOT}/ndk-build -C $(BUILDDIR)

install-%:
	$(eval ARCH := $(patsubst install-%,%,$@))
	install -D $(TMPINSTALLDIR)/local/$(ARCH)/libopus.a -m644 -D $(ARTIFACTSDIR)/$(ARCH)/lib/libopus.a
	install -D -t $(ARTIFACTSDIR)/$(ARCH)/include/opus jni/include/*

dist: $(patsubst %,install-%, $(ARCHS))
	mv $(ARTIFACTSDIR)/arm64-v8a $(ARTIFACTSDIR)/arm64
	mv $(ARTIFACTSDIR)/armeabi-v7a $(ARTIFACTSDIR)/armv7
#	mkdir -p $(ARTIFACTSDIR)/lib
#	lipo -create $(TMPINSTALLDIR)/*/lib/libopus.a -output $(ARTIFACTSDIR)/lib/libopus.a
#	cp -Rf $(TMPINSTALLDIR)/arm/include $(ARTIFACTSDIR)/include

clean:
	rm -rf $(BUILDDIR) $(TMPINSTALLDIR) release
