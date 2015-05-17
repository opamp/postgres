FROM centos:7
MAINTAINER opamp_sando <opampg@gmail.com>

RUN curl -O http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm > /dev/null 2>&1
RUN rpm -ivh *.rpm > /dev/null 2>&1 && rm -f *.rpm 
RUN yum install -y tcsh postgresql94-server > /dev/null 2>&1
RUN rm -fr /var/lib/pgsql && mkdir -p /var/lib/pgsql/data &&chown -R postgres:postgres /var/lib/pgsql
RUN mkdir -p /var/log/pg_log && chown postgres:postgres /var/log/pg_log
RUN ln -s /usr/pgsql-9.4 /usr/pgsql

ENV PATH /usr/bin:/usr/sbin:/usr/pgsql/bin
ENV PGDATA /var/lib/postgresql/data
ENV POSTGRES_PASSWORD postgres
ADD launch.sh /launch.sh
ADD pgconfig /pgconfig
CMD ["tcsh", "-b", "/launch.sh"]
