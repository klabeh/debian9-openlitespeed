FROM debian:stretch
MAINTAINER Marko Hoffmann <klabehgge@gmail.com>

# update apt repo
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    less vim wget unzip autossh

# Fetch OpenLiteSpeed Repo
RUN wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash

# Install OpenLiteSpeed
RUN apt-get install -y openlitespeed

# Install PHP 7.3 for OpenLiteSpeed
RUN apt-get install -y lsphp73

RUN ln -sf /usr/local/lsws/lsphp73/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp5

VOLUME /usr/local/lsws

# expose admin
EXPOSE 7080 8088

#ENTRYPOINT ["/usr/bin/lswsctrl"]
CMD ["/usr/local/lsws/bin/openlitespeed","-d"]
