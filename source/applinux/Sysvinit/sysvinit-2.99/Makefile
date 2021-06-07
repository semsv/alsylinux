.PHONY: all install
export LIBRARY_PATH="/usr/libexec/gcc/x86_64-alesya-linux/"
export CPLUS_INCLUDE_PATH="/include/c++/9.2.0/"
export C_INCLUDE_PATH="/lib/gcc/x86_64-alesya-linux/9.2.0/include/"
.IGNORE: clean
all:
	export CC="/usr/bin/gcc -fstack-protector-all -mstack-protector-guard=global" && make -f sysinit-Makefile.am
install:
	make -f sysinit-Makefile.am ROOT=/usr/src/tools/sysvinit-2.99 install
clean:
	rm -r src/*.o