#!/bin/make
app="@app.alsy.name"
compile:
	cd ../build/${app} && make
install:
	cd ../build/${app} && make install
	chmod -v 755 /usr/src/tools/${app}/lib/libcdda_*.so.0.10.2
clean:
	rm -rd ../build
