#WELCOME TO ALSYLINUX BOOT INSTALLER V1.0
#!/bin/sh
#echo "$DISPLAY"
# make sure I am root
if [ "$UID" != "0" -a "$UID" != "" ]; then
   echo ""
   echo "You are not root. You must run bootinst script as root."
   echo "The bootinst script needs direct access to your boot device."
   echo "Use sudo or kdesudo or similar wrapper to execute this."
   read junk
   exit 1
fi
# change working directory to dir from which we are started
CWD="$(pwd)"
BOOT="$(dirname "$1")"
if [ "$BOOT" == "" ]; then
  echo "for sample: ./bootinst.sh /mnt/live/memory/data/boot/syslinux.exe"
  echo "Press Enter..."
  read junk
  exit 2
fi
cd "$BOOT"
echo "$BOOT"
# check if disk is already bootable. Mostly for Windows discovery
#if [ "$(fdisk -l "$DEV" | fgrep "$DEV" | fgrep "*")" != "" ]; then
#   echo "Press [Enter] to continue, or [Ctrl+C] to abort..."
#   read junk
#fi
#echo "$(fdisk -l "$DEV" | fgrep "$DEV" | fgrep "*")"
if [ ! -x ./extlinux.exe ]; then
   # extlinux is not executable. There are two possible reasons:
   # either the fs is mounted with noexec, or file perms are wrong.
   # Try to fix both, no fail on error yet
   chmod a+x ./extlinux.exe
   mount -o remount,exec $DEV
fi
# install syslinux bootloader
echo "* attempting to install bootloader to $BOOT..."
EXTLINUX="./extlinux.exe"
echo "$EXTLINUX"
INSTALL="$("$EXTLINUX" --install "$BOOT")"
if [ $? -ne 0 ]; then
   echo "Error installing boot loader."
   echo "Read the errors above and press enter to exit..."
   read junk
   exit 3
fi
echo "$INSTALL"
echo "Boot installation finished."
echo "Press Enter..."
read junk
cd "$CWD"
