FROM centos:7
MAINTAINER opamp_sando <opampg@gmail.com>

RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm > /dev/null 2>&1
RUN yum install -y postgresql14-server postgresql14 tcsh > /dev/null 2>&1
RUN rm -fr /var/lib/pgsql && mkdir -p /var/lib/pgsql/data &&chown -R postgres:postgres /var/lib/pgsql
RUN mkdir -p /var/log/pg_log && chown postgres:postgres /var/log/pg_log
RUN ln -s /usr/pgsql-14 /usr/pgsql
RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8

ENV PG_ENC UTF8
ENV PG_LOCALE en_US.UTF-8
ENV PATH /usr/bin:/usr/sbin:/usr/pgsql/bin
ENV PGDATA /var/lib/postgresql/data
ENV POSTGRES_PASSWORD postgres
ADD launch.sh /launch.sh
ADD pgconfig /pgconfig
CMD ["tcsh", "-b", "/launch.sh"]
