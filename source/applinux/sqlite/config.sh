#!/bin/bash
sapp="sqlite"
app="sqlite-autoconf-3320200"
arch="tar.gz"

sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"

if [ -d $app ]; then
 rm -rd $app
 if [ $? -eq 0 ]; then
   echo "delete..[ ok ]"
 else
   exit 1
 fi
fi

mkdir -p ../build &&
tar -xf "$app"."$arch" -C ../build
if [ $? -eq 0 ]; then
  cd ../build/$app
  if [ $? -eq 0 ]; then
    ./configure --prefix=/usr/src/tools/$sapp     \
                --disable-static  \
                --enable-fts5     \
                CFLAGS="-g -O2                    \
                -DSQLITE_ENABLE_FTS3=1            \
                -DSQLITE_ENABLE_FTS4=1            \
                -DSQLITE_ENABLE_COLUMN_METADATA=1 \
                -DSQLITE_ENABLE_UNLOCK_NOTIFY=1   \
                -DSQLITE_ENABLE_DBSTAT_VTAB=1     \
                -DSQLITE_SECURE_DELETE=1          \
                -DSQLITE_ENABLE_FTS3_TOKENIZER=1" 
  fi
fi
