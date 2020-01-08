#!/bin/env bash
# chkconfig: - 85 15
export LD_LIBRARY_PATH=/usr/local/inotify-tools/lib:$LD_LIBRARY_PATH

# configure the monitor path
MONPATH=
BIN=/usr/local/inotify-tools/bin/inotifywait
PIDFILE=/var/run/inotifywait.pid

HOST_DEST=
USER=
DESTDIR=


do_start() {
    [[ -s $PIDFILE ]] && echo "$PIDFILE exist" && exit
    nohup $BIN -mrq --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -e \
        modify,delete,create,attrib ${MONPATH} & echo $! > ${PIDFILE} | \
        while read date time dir file
        do
            FILECHANGE=${dir}${file}
            rsync --progress --relative -vraez 'ssh -p 22' ${FILECHANGE} \
                ${USER}@${HOST_DEST}:${DESTDIR} && \
            echo "At ${time} on ${date}, file ${FILECHANGE} was transmission up
                via rsync" >> /tmp/rsync.log 2>&1
        done
}

do_stop() {
    [[ -s $PIDFILE ]] && kill `cat $PIDFILE` && rm $PIDFILE
}


case "$1" in
    start)
        do_start
        ;;
    stop)
        do_stop
        ;;
esac
