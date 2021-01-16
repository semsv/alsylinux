#!/bin/make
app=@alsy.app.name
installdir=/usr/src/tools/@alsy.sapp.name
all:
	cd ../build/${app} && make
install:
	cd ../build/${app} && make install
	./install.sh ${installdir} ${app}
clean:
	rm -rd ../build/${app}