#!/bin/make
# Makefile Script to create RAMFSDISK for loading Alsy Linux OS using SYSLINUX
# Author: Sevastyanov S.V.

.PHONY: all ramfs images clean
all:
	file="images-'$(uname -r)'.tar"
	tar -zcvf $file lib/modules
	gzip $file
	mv $file".gz" ../
	rm -rd lib/modules/*
	find | cpio -ov -H newc | xz -f --extreme --check=crc32 > ../initrfs.img
ramfs:
	find | cpio -ov -H newc | xz -f --extreme --check=crc32 > ../initrfs.img
images:
	file="images-'$(uname -r)'.tar"
	tar -zcvf $file lib/modules
	gzip $file
	mv $file".gz" ../
clean:
	rm -r "../images-'$(uname -r)'.tar.gz"
	rm -r ../initrfs.img
