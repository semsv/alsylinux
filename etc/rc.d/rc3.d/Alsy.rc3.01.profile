#!/bin/bash

logdir="/tmp/alsy-start-log"
mkdir -p "$logdir"

export_start()
{
SPACE=" "
#CONCSTR=`
#ls -1 /usr/lib64 | (while read VALUE; do
# if [ "$(echo $VALUE | grep '.so' | grep 'lib')" != "" ]; then 
#   CONCSTR=$CONCSTR$SPACE$VALUE
# fi
#done >/dev/null; echo $CONCSTR )`
  LIBCONC="/lib64/libgbm.so"
  if [ -f $LIBCONC ]; then
    CONCSTR=$CONCSTR$SPACE$LIBCONC
    LIBCONC="/lib64/libxshmfence.so.1"
    if [ -f $LIBCONC ]; then
      CONCSTR=$CONCSTR$SPACE$LIBCONC
    fi
    LIBCONC="/lib64/libwayland-client.so"
    if [ -f $LIBCONC ]; then
      CONCSTR=$CONCSTR$SPACE$LIBCONC
    fi
    LIBCONC="/lib64/libwayland-server.so"
    if [ -f $LIBCONC ]; then
      CONCSTR=$CONCSTR$SPACE$LIBCONC
    fi
    LIBCONC="/lib64/libwayland-egl.so"
    if [ -f $LIBCONC ]; then
      CONCSTR=$CONCSTR$SPACE$LIBCONC
    fi
    LIBCONC="/lib64/libwayland-cursor.so"
    if [ -f $LIBCONC ]; then
      CONCSTR=$CONCSTR$SPACE$LIBCONC
    fi
    LIBCONC="/lib64/libLLVM-9.so"
    if [ -f $LIBCONC ]; then
      CONCSTR=$CONCSTR$SPACE$LIBCONC
    fi
  fi
#  LIBCONC="/lib64/libEGL.so"
#  if [ -f $LIBCONC ]; then
#    CONCSTR=$CONCSTR$SPACE$LIBCONC
#  fi
#  LIBCONC="/lib64/libGL.so"
#  if [ -f $LIBCONC ]; then
#    CONCSTR=$CONCSTR$SPACE$LIBCONC
#  fi
#  LIBCONC="/lib64/libglapi.so"
#  if [ -f $LIBCONC ]; then
#    CONCSTR=$CONCSTR$SPACE$LIBCONC
#  fi
#  LIBCONC="/lib64/libxatracker.so"
#  if [ -f $LIBCONC ]; then
#    CONCSTR=$CONCSTR$SPACE$LIBCONC
#  fi
  if [ -f /etc/profile.d/alsy.sh ]; then
    echo "" > /etc/profile.d/alsy.sh
  fi
  echo "$(cat /mnt/live/lib/init.cfg | grep -E '^LIVEKITNAME')" >> /etc/profile.d/alsy.sh
  echo "LD_PRELOAD='$CONCSTR'" >> /etc/profile.d/alsy.sh
  echo "export LD_PRELOAD;"  >> /etc/profile.d/alsy.sh
  echo "export LIVEKITNAME;" >> /etc/profile.d/alsy.sh
  chmod a+rwx /etc/profile.d/alsy.sh
}

if [ "$1" == "start" ]; then
  filelogname="$(basename $0)"
  export_start >$logdir/$filelogname".log" 2>$logdir/$filelogname"_err.log"
  echo -e "EXPORT PROFILE ..........................................\e[32m[OK]\e[0m"
else
  echo "usage: $0 start"
fi