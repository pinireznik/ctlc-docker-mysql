FROM ubuntu:quantal
MAINTAINER Lucas Carlson <lucas@rufy.com>

# Install packages
RUN apt-get update
RUN apt-get -y upgrade
RUN ! DEBIAN_FRONTEND=noninteractive apt-get -qy install supervisor wget unzip mysql-server pwgen; ls

RUN wget --no-check-certificate https://dl.bintray.com/mitchellh/serf/0.3.0_linux_amd64.zip
RUN unzip 0.3.0_linux_amd64.zip
RUN mv serf /usr/bin/

# Add image configuration and scripts
ADD /start.sh /start.sh
ADD /start-serf.sh /start-serf.sh
ADD /serf-join.sh /serf-join.sh
ADD /run.sh /run.sh
ADD /supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD /supervisord-serf.conf /etc/supervisor/conf.d/supervisord-serf.conf
ADD /supervisord-restart.conf /etc/supervisor/conf.d/supervisord-restart.conf
ADD /my.cnf /etc/mysql/conf.d/my.cnf
ADD /create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD /import_sql.sh /import_sql.sh
ADD /restart-proc.sh /restart-proc.sh
RUN chmod 755 /*.sh

EXPOSE 3306
CMD ["/run.sh"]
