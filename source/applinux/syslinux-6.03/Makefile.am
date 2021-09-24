#!/bin/make
app="@alsy.app.name"
DESTDIR=syslinux/boot
installdir=/usr/src/tools
compile:
	cd ../build/${app} && make efi32 efi64
	cd ../build/${app} && make efi32 efi64 installer
install:
	mkdir -p boot && cd ../build/${app} && make install
	cp -a /sbin/extlinux -t ../${DESTDIR}
	cp -rLd /usr/share/syslinux -t ../${DESTDIR}
	mv -f ../${DESTDIR}/extlinux -t ../${DESTDIR}/syslinux
	cp -rLd boot/syslinux -t ${installdir}
clean:
	rm -rd ../build