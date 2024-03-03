# ramroot for gentoo via initramfs

1. READ and CHANGE ramdisk.sh and gen_initramfs-ARCH.sh before deploying. This is just a script I made for myself, not a fully developed software.
2. /etc/genkernel.conf is with SYMLINK="yes".
3. Kernel is compiled by genkernel with "Support initial ramdisk/ramfs compressed using XZ".
4. MUST configure exclusions in _mount_dir@ramdisk, and make sure /mnt/.ramdisk is less than half your memory size.
5. The init file is modified from genkernel-linuxrc. It simply creates a tmpfs-based /ram_chroot synced from /mnt/.ramdisk/, and umount real_root before booting the real init via switch_root.
```Bash
mkdir /ram_chroot
mount -t tmpfs -o rw,noatime none /ram_chroot
cp -a "${CHROOT}"/mnt/.ramdisk/* /ram_chroot/

mount --move /proc /ram_chroot/proc
mount --move /sys /ram_chroot/sys
mount --move /dev /ram_chroot/dev

umount ${CHROOT}

good_msg "Switching to real root: switch_root /ram_chroot ${init} ${init_opts}"
exec switch_root /ram_chroot "${init}"
```
7. gen_initramfs-ARCH.sh syncs kernel files from the server, packages the initramfs.img with new init, and deploys to /boot.
8. config.txt is for raspberry pi.
9. The script is for Gentoo. But it should work for Archlinux.
