#!/bin/make
.PHONY: all create images clean
all:
	file="images-'$(uname -r)'.tar"
	tar -zcvf $file lib/modules
	gzip $file
	mv $file".gz" ../
	rm -rd lib/modules/*
	find | cpio -ov -H newc | xz -f --extreme --check=crc32 > ../initrfs.img
create:
	find | cpio -ov -H newc | xz -f --extreme --check=crc32 > ../initrfs.img
images:
	file="images-'$(uname -r)'.tar"
	tar -zcvf $file lib/modules
	gzip $file
clean:
	rm -r "../images-'$(uname -r)'.tar.gz"
	rm -r ../initrfs.img
