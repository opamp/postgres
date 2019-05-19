FROM centos:7
MAINTAINER opamp_sando <opampg@gmail.com>

#RUN curl -O https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rpm 
#RUN rpm -ivh *.rpm > /dev/null 2>&1 && rm -f *.rpm 
RUN yum install -y https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm > /dev/null 2>&1
RUN yum install -y tcsh postgresql11 postgresql11-server > /dev/null 2>&1
RUN rm -fr /var/lib/pgsql && mkdir -p /var/lib/pgsql/data &&chown -R postgres:postgres /var/lib/pgsql
RUN mkdir -p /var/log/pg_log && chown postgres:postgres /var/log/pg_log
RUN ln -s /usr/pgsql-11 /usr/pgsql

ENV PATH /usr/bin:/usr/sbin:/usr/pgsql/bin
ENV PGDATA /var/lib/postgresql/data
ENV POSTGRES_PASSWORD postgres
ADD launch.sh /launch.sh
ADD pgconfig /pgconfig
CMD ["tcsh", "-b", "/launch.sh"]
