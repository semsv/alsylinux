extract:
	mv initrfs.img initrfs.img.xz
	unxz initrfs.img.xz
	mkdir initrfs
	mv initrfs.img initrfs/initrfs.img
	chmod a+rwx extract.sh
	sh extract.sh
	rm -r initrfs/initrfs.img
run:
	chmod a+rwx extract.sh
	sh extract.sh
	rm -r initrfs/initrfs.img
modules:
	mkdir lib
	mkdir lib/modules
	cp -rLd /lib/modules/$(shell uname -r) lib/modules
	mksquashfs lib 00-alsylib.sb -comp xz -b 512k -keep-as-directory
fluxbox:
	cp -rLd /usr/local/bin usr/local
	cp -rLd /usr/local/share/fluxbox usr/local/share
	mksquashfs usr 00-alsyusr.sb -comp xz -b 512k -keep-as-directory
clean:
	rm -rd initrfs
cleanlib:
	rm -rd lib