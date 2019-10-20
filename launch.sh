#!/bin/tcsh

set INIT=0

# MKDIR IF $PGDATA DIR DOES NOT EXIST.
if (!(-e $PGDATA)) then
    mkdir -p $PGDATA
    chmod 700 $PGDATA
endif

chown -R postgres:postgres $PGDATA

# INITDB IF $PGDATA DIR IS EMPTY.
if ( `ls -a $PGDATA | wc | awk '{print $1}'` == 2 ) then
    su -c "/usr/pgsql/bin/initdb -E $PG_ENC --locale $PG_LOCALE -D $PGDATA" - postgres
    if (-e /pgconfig/postgresql.conf) then
        rm -f $PGDATA/postgresql.conf && mv /pgconfig/postgresql.conf $PGDATA/postgresql.conf
        chown postgres:postgres $PGDATA/postgresql.conf && chmod 600 $PGDATA/postgresql.conf
    endif
    if (-e /pgconfig/pg_hba.conf) then
        rm -f $PGDATA/pg_hba.conf && mv /pgconfig/pg_hba.conf $PGDATA/pg_hba.conf
        chown postgres:postgres $PGDATA/pg_hba.conf && chmod 600 $PGDATA/pg_hba.conf
    endif
    if (-e /pgconfig/pg_ident.conf) then
        rm -f $PGDATA/pg_ident.conf && mv /pgconfig/pg_ident.conf $PGDATA/pg_ident.conf
        chown postgres:postgres $PGDATA/pg_ident.conf && chmod 600 $PGDATA/pg_ident.conf
    endif
    rm -fr /pgconfig
    set INIT=1
endif

if ($INIT == 1) then
    #su -c "/usr/pgsql/bin/postmaster -D $PGDATA" - postgres &
    su -c "/usr/pgsql/bin/pg_ctl start -D $PGDATA -w" - postgres && psql -U postgres -w -c "ALTER USER postgres WITH PASSWORD '$POSTGRES_PASSWORD';"
    tail -f /dev/null
else
    su -c "/usr/pgsql/bin/postmaster -D $PGDATA" - postgres 
endif
