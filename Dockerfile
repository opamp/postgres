FROM centos:8
MAINTAINER opamp_sando <opampg@gmail.com>

RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm > /dev/null 2>&1
RUN dnf install -y tcsh python2-libs libicu > /dev/null 2>&1
RUN dnf --repo pgdg12 install -y postgresql12 postgresql12-server > /dev/null 2>&1
RUN rm -fr /var/lib/pgsql && mkdir -p /var/lib/pgsql/data &&chown -R postgres:postgres /var/lib/pgsql
RUN mkdir -p /var/log/pg_log && chown postgres:postgres /var/log/pg_log
RUN ln -s /usr/pgsql-12 /usr/pgsql

ENV PATH /usr/bin:/usr/sbin:/usr/pgsql/bin
ENV PGDATA /var/lib/postgresql/data
ENV POSTGRES_PASSWORD postgres
ADD launch.sh /launch.sh
ADD pgconfig /pgconfig
CMD ["tcsh", "-b", "/launch.sh"]
