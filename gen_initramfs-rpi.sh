mount /dev/mmcblk0p1 /boot

rm -rfv /boot/overlays.bkp
mv -v /boot/overlays            /boot/overlays.bkp
mv -v /boot/bcm2711-rpi-4-b.dtb /boot/bcm2711-rpi-4-b.dtb.bkp
mv -v /boot/bcm2711-rpi-cm4.dtb /boot/bcm2711-rpi-cm4.dtb.bkp

rm -rfv /root/boot
rsync -azL 192.168.1.20:/mnt/gentoo/boot/ /root/boot/
cp -r /root/boot/* /boot/
sync

rm -rfv /root/initramfs
mkdir /root/initramfs
cd /root/initramfs
cp /boot/initramfs ./initramfs.xz
xz -d initramfs.xz
cpio -iF initramfs
rm initramfs
cp /root/init ./init

find . -print0 | cpio --quiet --null -o -H newc --owner root:root --force-local | xz -e --check=none -z -f -9 -T 0 > /boot/initramfs
