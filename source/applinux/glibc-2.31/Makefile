#!/bin/make
app=glibc-2.31-x86-64
pref=/usr/src/tools/${app}
sourcedir=${app}_src
makefiledir=${sourcedir}/build_
.PHONY: all install clean
all:
	cd ${makefiledir} && make -f Makefile
install:
	mkdir -p ${pref}/etc/
	cp /etc/ld.so.conf ${pref}/etc/ld.so.conf
	touch ${pref}/etc/ld.so.conf
	cd ${makefiledir} && make -f Makefile install
	cp -rLd ${pref}/lib64 ${pref}/lib
	./install_locale ${pref} ${makefiledir}
	rm -rd ${sourcedir}
clean:
	rm -rd ${sourcedir}
