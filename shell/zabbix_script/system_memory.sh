#!/bin/bash

total_mem() {
    echo $(free | grep -w Mem | awk '{ print $2}')
}

used_mem() {
    echo $(free | grep -w Mem | awk '{ print $3}')
}

free_mem() {
    echo $(free | grep -w Mem | awk '{ print $4}')
}

shared_mem() {
    echo $(free | grep -w Mem | awk '{ print $5}')
}

buffers_mem() {
    echo $(free | grep -w Mem | awk '{ print $6}')
}

cached_mem() {
    echo $(free | grep -w Mem | awk '{ print $7}')
}

total_swap() {
    echo $(free | grep -w Swap | awk '{ print $2}')
}

used_swap() {
    echo $(free | grep -w Swap | awk '{ print $3}')
}

free_swap() {
    echo $(free | grep -w Swap | awk '{ print $4}')
}

used_buffers() {
    echo $(free | grep -w "buffers/cache" | awk '{ print $3}')
}

free_buffers() {
    echo $(free | grep -w "buffers/cache" | awk '{ print $4 }')
}

case $1 in
    total)
        total_mem;
        ;;
    used)
        used_mem;
        ;;
    free)
        free_mem;
        ;;
    shared)
        shared_mem;
        ;;
    buffers)
        buffers_mem;
        ;;
    cached)
        cached_mem;
        ;;
    stotal)
        total_swap;
        ;;
    sused)
        used_swap;
        ;;
    sfree)
        free_swap;
        ;;
    bused)
        used_buffers;
        ;;
    bfree)
        free_buffers;
        ;;
    *)
        echo -1;
        ;;
esac
