create:
	find | cpio -ov -H newc | xz -f --extreme --check=crc32 > ../initrfs.img
images:
	file="images-'$(uname -r)'.tar"
	tar -cf lib/modules -C $file
	gzip $file
