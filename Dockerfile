FROM debian:stretch
MAINTAINER Marko Hoffmann <klabehgge@gmail.com>

# update apt repo
RUN apt-get update

# Fetch OpenLiteSpeed Repo
RUN wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash

# Install OpenLiteSpeed
RUN apt-get install openlitespeed

# Install PHP 7.3 for OpenLiteSpeed
RUN apt-get install \
    lsphp73 lsphp73-common lsphp73-mysql lsphp73-gd lsphp73-process \
    lsphp73-mbstring lsphp73-xml lsphp73-mcrypt lsphp73-pdo lsphp73-imap \
    lsphp73-soap lsphp73-bcmath

RUN ln -sf /usr/local/lsws/lsphp73/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp5

VOLUME /usr/local/lsws

# expose admin
EXPOSE 7080 8088

#ENTRYPOINT ["/usr/bin/lswsctrl"]
CMD ["/usr/local/lsws/bin/openlitespeed","-d"]
