FROM rockylinux:9
MAINTAINER opamp_sando <opampg@gmail.com>

RUN dnf update -y > /dev/null 2>&1
RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm > /dev/null 2>&1
RUN dnf -qy module disable postgresql > /dev/null 2>&1
#RUN dnf install -y postgresql12-server postgresql12 tcsh > /dev/null 2>&1
RUN dnf install -y postgresql15-server postgresql15 tcsh > /dev/null 2>&1

RUN rm -fr /var/lib/pgsql && mkdir -p /var/lib/pgsql/data &&chown -R postgres:postgres /var/lib/pgsql
RUN mkdir -p /var/log/pg_log && chown postgres:postgres /var/log/pg_log
#RUN ln -s /usr/pgsql-12 /usr/pgsql
RUN ln -s /usr/pgsql-15 /usr/pgsql

RUN dnf install -y langpacks-en glibc-locale-source glibc-langpack-en > /dev/null 2>&1
RUN localedef -f UTF-8 -i en_US en_US.UTF-8

ENV PG_ENC UTF8
ENV PG_LOCALE C.UTF-8
ENV PATH /usr/bin:/usr/sbin:/usr/pgsql/bin
ENV PGDATA /var/lib/postgresql/data
ENV POSTGRES_PASSWORD postgres
ADD launch.sh /launch.sh
ADD pgconfig /pgconfig
CMD ["tcsh", "-b", "/launch.sh"]
