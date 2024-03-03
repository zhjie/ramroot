# ramroot for gentoo via initramfs

1. READ and CHANGE ramdisk and gen_initramfs-ARCH.sh before deploying. This is just a script I made for myself, not a fully developed software.
2. /etc/genkernel.conf is with SYMLINK="yes".
3. Kernel is compiled by genkernel with "Support initial ramdisk/ramfs compressed using XZ".
4. MUST configure exclusions in _mount_dir@ramdisk, and make sure /mnt/.ramdisk is less than half your memory size.
5. The init file is modified from genkernel-linuxrc. It simply creates a tmpfs-based /ram_chroot synced from /mnt/.ramdisk/, and umount real_root before booting the real init via switch_root.
6. gen_initramfs-ARCH.sh syncs kernel files from the server, packages the initramfs.img with new init, and deploys to /boot.
7. config.txt is for raspberry pi.
8. The script is for Gentoo. But it should work for Archlinux.
