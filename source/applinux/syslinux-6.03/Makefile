#!/bin/make
app="syslinux-6.03"
compile:
	cd ../build/${app} && make efi32 efi64
	cd ../build/${app} && make efi32 efi64 installer
install:
	mkdir -p boot && cd ../build/${app} && make DESTDIR=../../syslinux/boot install
clean:
	rm -rd ../build