#!/bin/make
app="@alsy.app.name"
compile:
	cd ../build/${app} && make efi32 efi64
	cd ../build/${app} && make efi32 efi64 installer
install:
	mkdir -p boot && cd ../build/${app} && make DESTDIR=../../syslinux/boot install
clean:
	rm -rd ../build