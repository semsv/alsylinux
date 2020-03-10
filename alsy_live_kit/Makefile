#!/bin/make
# Makefile Script to create RAMFSDISK for loading Alsy Linux OS using SYSLINUX
# Author: Sevastyanov S.V.

file="images-${shell uname -r}.tar"
.PHONY: all ramfs images clean
all:
	find | cpio -ov -H newc | xz -f --extreme --check=crc32 > ../initrfs.img
ramfs:
	find | cpio -ov -H newc | xz -f --extreme --check=crc32 > ../initrfs.img
images:
	tar -zcvf ${file} lib/modules
	gzip ${file}
	mv ${file}".gz" ../
clean:
	rm -r ../${file}".gz"
	rm -r ../initrfs.img
