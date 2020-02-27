# AlsyLinux
Файлы для ОС AlsyLinux (Alesya Linux)

## 1. Процесс запуска ОС AlsyLinux

Схематично загрузку ОС можно представить так:

#  BIOS
  + select boot loader...
#  SYSLINUX
  +  /boot/syslinux.com (для загрузки с FAT, FAT32, NTFS)
  +  /boot/extlinux.exe (для загрузки с ext2/ext3/ext4 или btrfs)
  +  /boot/syslinux.cfg    
# LINUX KERNEL   
  +  /core/VMLINUZ
  +  /core/INITRFS.IMG   
# ALSY-LIVE-KIT
  + ./INIT
  + livekitlib  
# ALSY-INIT-CORE
  + ./INIT 3
  + /etc/inittab 
  + /etc/rc.d/rc.alsy.init
  + /etc/rc.d/rc3.d/A*
-------------------------------------------------------------------------------------------
* These are the default runlevels in AlsyLinux:
*   0 = halt
*   1 = single user mode
*   2 = unused (but configured the same as runlevel 3)
*   3 = multiuser mode (default AlsyLinux runlevel)
*   4 = unused (but configured the same as runlevel 3)
*   5 = X11 with KDM/GDM/XDM (session managers)
*   6 = reboot
-------------------------------------------------------------------------------------------

# Установка на флешку ОС AlsyLinux из Linux
1. Скопировать на USB Flash Drive папку alsylinux
2. Зайти в эту папку и набрать команду: "cd boot && ./extlinux -i $PWD"
