#!/bin/bash
# author/maintainer lie

FSNAME=$1

vfs_fs_size_total() {
    echo $(df -P $FSNAME | awk '{print $2}' | sed '1d')
}

vfs_fs_size_used() {
    echo $(df -P $FSNAME | awk '{print $3}' | sed '1d')
}

vfs_fs_size_free() {
    echo $(df -P $FSNAME | awk '{print $4}' | sed '1d')
}

vfs_fs_size_puse() {
    echo $(df -P $FSNAME | awk '{print $5}' | sed '1d')
}

case $2 in
    total)
        vfs_fs_size_total;
        ;;
    used)
        vfs_fs_size_used;
        ;;
    free)
        vfs_fs_size_free;
        ;;
    puse)
        vfs_fs_size_puse;
        ;;
esac
