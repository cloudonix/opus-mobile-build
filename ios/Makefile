VERSION := 1.3.1
ARTIFACTSDIR := release/opus
BUILDDIR := opus-$(VERSION)
TMPINSTALLDIR := tmp-install

ARCHS := x86_64 armv7 arm64

CPP = clang -E
CFLAGS := -O3 -Wno-unused-label -g

all: download compile-arm compile-x86_64

opus-$(VERSION)/configure: # download target
	curl https://archive.mozilla.org/pub/opus/opus-$(VERSION).tar.gz | tar -zx

download: opus-$(VERSION)/configure
	# empty target just to dep on the existence of the configure script (which is resolved by downloading)

compile-arm:
	cd $(BUILDDIR) && ./configure CC="xcrun -sdk iphoneos clang -arch armv7 -arch arm64" CPP="$(CPP)" CFLAGS="$(CFLAGS)" \
		--host=arm-apple-darwin --prefix=$(CURDIR)/$(TMPINSTALLDIR)/arm \
		--disable-shared --enable-static --with-pic --disable-extra-programs --disable-doc --enable-assertions --disable-asm
	$(MAKE) -C $(BUILDDIR) clean
	$(MAKE) -C $(BUILDDIR)
	$(MAKE) -C $(BUILDDIR) install

compile-x86_64:
	$(eval export DEVPATH = $(shell xcrun -sdk iphonesimulator --show-sdk-platform-path)/Developer)
	cd $(BUILDDIR) && ./configure CC="xcrun -sdk iphonesimulator clang -arch x86_64" CPP="$(CPP)" CFLAGS="$(CFLAGS)" \
		--host=x86_64-apple-darwin16.5.0 --prefix=$(CURDIR)/$(TMPINSTALLDIR)/x86_64 \
		--disable-shared --enable-static --with-pic --disable-extra-programs --disable-doc --enable-assertions --disable-asm
	$(MAKE) -C $(BUILDDIR) clean
	$(MAKE) -C $(BUILDDIR)
	$(MAKE) -C $(BUILDDIR) install

dist:
	mkdir -p $(ARTIFACTSDIR)/lib
	lipo -create $(TMPINSTALLDIR)/*/lib/libopus.a -output $(ARTIFACTSDIR)/lib/libopus.a
	cp -Rf $(TMPINSTALLDIR)/arm/include $(ARTIFACTSDIR)/include

clean:
	rm -rf $(BUILDDIR) $(TMPINSTALLDIR) release
