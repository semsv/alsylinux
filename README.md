# alsylinux
Файлы для ОС AlsyLinux (Alesya Linux)

## 1. Процесс запуска ОС AlsyLinux

Схематично загрузку можно представить так:

  BIOS
   ->
  SYSLINUX
  +
  /boot/syslinux.cfg
   ->
  VMLINUZ
  +
  INITRFS.IMG
   ->
  INIT 0 1 2 3 4 5 6
  /etc/rc.d

