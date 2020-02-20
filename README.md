# AlsyLinux
Файлы для ОС AlsyLinux (Alesya Linux)

## 1. Процесс запуска ОС AlsyLinux

Схематично загрузку ОС можно представить так:

#  BIOS
  +
#  SYSLINUX
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
