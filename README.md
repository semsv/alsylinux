# alsylinux
Файлы для ОС AlsyLinux (Alesya Linux)

## 1. Процесс запуска ОС AlsyLinux

Схематично загрузку ОС можно представить так:

  BIOS
   
   ->
   
  SYSLINUX
  +
  /boot/syslinux.cfg
  
   ->
   
  /core/VMLINUZ
  +
  /core/INITRFS.IMG
  
   ->
  
  ./INIT
  +
  livekitlib
  
   ->
   
  ./INIT 3
  +
  /etc/inittab

