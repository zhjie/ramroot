_mount_dir() {
    if [ $# == 1 ]; then
        rsync -a /$1/ /mnt/.ramdisk/$1 --exclude src --exclude cache --exclude db --exclude portage --exclude python --exclude llvm --exclude repos --exclude binpkgs --exclude distfiles
    fi
}

start() {
        rm -r /mnt/.ramdisk         2>/dev/null
        rm -r /var/log/*            2>/dev/null
        rm -r /var/tmp/*            2>/dev/null

        sync && echo 3 > /proc/sys/vm/drop_caches

        mkdir -p /mnt/.ramdisk/{boot,dev,etc,mnt,proc,root,run,sys,tmp,usr,var,bin,lib,lib64,sbin}
        cd /mnt/.ramdisk

        echo
        echo -e "Prepare ramdisk..."
        echo -e "etc,root,usr,var,bin,lib,lib64,sbin"

        for dir in etc root usr var bin lib lib64 sbin
        do
            echo -e "/$dir ..."
            _mount_dir $dir
        done

        echo -e "done"
}

start
