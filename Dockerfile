FROM centos:7
MAINTAINER James <setkeh> Griffis <setkeh@setkeh.com>

RUN yum install -y https://github.com/sysown/proxysql/releases/download/v1.3.5/proxysql-1.3.5-1-centos7.x86_64.rpm

RUN yum -y install mariadb

ADD proxysql.cnf /etc/proxysql.cnf

COPY proxysql-entry.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

COPY jq /usr/bin/jq
RUN chmod a+x /usr/bin/jq

COPY add_cluster_nodes.sh /usr/bin/add_cluster_nodes.sh
RUN chmod a+x /usr/bin/add_cluster_nodes.sh

VOLUME /var/lib/proxysql

EXPOSE 3306 6032
ONBUILD RUN yum update -y

CMD [""]
