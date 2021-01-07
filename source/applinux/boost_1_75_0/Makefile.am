#!/bin/make
app="@alsy.app.name"
installdir=/usr/src/tools/${app}
all:
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/include/python3.6m" && cd ../build/${app} && ./b2 stage -j2 threading=multi link=shared
install:
	cd ../build/${app} && ./b2 install threading=multi link=shared 
	mv -t /usr/src ../build/${app}/${app}