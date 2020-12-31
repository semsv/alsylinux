#!/bin/sh
# $1 = installdir
# $2 = app

mkdir -p $1/etc
if [ $? -eq 0 ]; then
  cd ../build/$2 && install -v -m755 -d $1/etc/pam.d
else 
  exit 1
fi

if [ $? -eq 0 ]; then
cat > $1/etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF
else 
  exit 1
fi
if [ $? -eq 0 ]; then
  make install
else 
  exit 1
fi
if [ $? -eq 0 ]; then
chmod -v 4755 $1/sbin/unix_chkpwd
else 
  exit 1
fi
if [ $? -eq 0 ]; then
  echo "install success"
  exit 0
else
  echo "install fail"
  exit 1
fi