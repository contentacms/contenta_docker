FROM amazeeio/centos:7

ENV MARIADB_VERSION=10.1

RUN { \
      echo '[mariadb]'; \
      echo 'name = MariaDB'; \
      echo "baseurl = http://yum.mariadb.org/$MARIADB_VERSION/centos7-amd64"; \
      echo 'gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'; \
      echo 'gpgcheck=1'; \
    } > /etc/yum.repos.d/mariadb.repo

COPY conf/server.cnf /etc/my.cnf.d/server.cnf
COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN yum install -y epel-release && \
    yum install -y pwgen MariaDB-server MariaDB-client && \
    yum clean all && \
    rm -rf /var/lib/mysql && \
    mkdir -p /var/lib/mysql /var/run/mysqld && \
    fix-permissions /var/lib/mysql && \
    fix-permissions /var/run/mysqld && \
    fix-permissions /var/log/ && \
    fix-permissions /etc/my.cnf.d/ && \
    chmod +x /usr/local/bin/docker-entrypoint

### we cannot start mysql as root, we add the user mysql to the group root and change the user of the Docker Image to this user
RUN usermod -G 0 --append mysql
USER mysql

VOLUME /var/lib/mysql
ENTRYPOINT ["docker-entrypoint"]
CMD ["mysqld"]
