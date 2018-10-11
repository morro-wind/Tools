#!/bin/bash
PRIMARY_IP="192.168.10.2"
STANDBY_IP="192.168.10.3"
PGDATA="/DATA/postgresql/data"
SYS_USER="root"
PG_USER="postgresql"
PGPREFIX="/opt/pgsql"

pg_status()
{
    ssh ${SYS_USER}@$1 "su - ${PG_USER} -c '${PGPREFIX}/bin/pg_controldata -D ${PGDATA} | grep cluster' | awk -F : '{print \$2}' | sed 's/^[ \t]*\|[ \t]*$//'"
}

#if [ "`primary_status`" == "in production" ]; then
#    echo 1111111
#    echo primary_status
#fi

# recover to primary
recovery_primary()
{
    ssh ${SYS_USER}@$1 /
    "su - ${PG_USER} -c '${PGPREFIX}/bin/pg_ctl promote -D ${PGDATA}'"
}

# primary to recovery
primary_recovery()
{
    ssh ${SYS_USER}@$1 /
    "su - ${PG_USER} -c 'cd ${PGDATA} && mv recovery.done recovery.conf'"
}

send_mail()
{
    echo "send SNS"
}

case "`pg_status ${PRIMARY_IP}`" in
    "shut down")
        case "`pg_status ${STANDBY_IP}`" in
            "in archive recovery")
                primary_recovery ${PRIMARY_IP}
                recovery_primary ${STANDBY_IP}
                ;;
            "shut down in recovery"|"in production")
                send_mail
                ;;
        esac
        ;;
    "in production")
        case "`pg_status ${STANDBY_IP}`" in
            "shut down in recovery"|"shut down"|"in production")
                send_mail
                ;;
        esac
        echo "primary"
        ;;
    "in archive recovery")
        case "`pg_status ${STANDBY_IP}`" in
            "shut down")
                primary_recovery ${STANDBY_IP}
                recovery_primary ${PRIMARY_IP}
                ;;
            "shut down in recovery"|"in archive recovery")
                send_mail
                ;;
        esac
        echo "recovery"
        ;;
    "shut down in recovery")
        case "`pg_status ${STANDBY_IP}`" in
            "shut down in recovery"|"shut down"|"in archive recovery")
                send_mail
                ;;
        esac
        echo "recovery down"
        ;;
esac
