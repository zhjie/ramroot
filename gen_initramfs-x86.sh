mount /dev/sda1 /boot

rm -rfv /root/boot
rsync -azL 192.168.1.15:/mnt/bridge/boot/ /root/boot/
rsync -azL /root/boot/ /boot/
sync

rm -rfv /root/initramfs
mkdir /root/initramfs
cd /root/initramfs
cp /boot/initramfs ./initramfs.xz
xz -d initramfs.xz
cpio -iF initramfs
rm initramfs
cp /root/init ./init

find . -print0 | cpio --quiet --null -o -H newc --owner root:root --force-local | xz -e --check=none -z -f -9 -T 0 > /boot/initramfs-6.7.9999-networkaudio-rt-x86_64.img
cp /boot/System.map /boot/System.map-6.7.9999-networkaudio-rt-x86_64
cp /boot/kernel /boot/vmlinuz-6.7.9999-networkaudio-rt-x86_64

rm /boot/*.old
grub-mkconfig -o /boot/grub/grub.cfg
