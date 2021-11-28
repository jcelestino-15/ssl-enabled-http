# Place instructions here

FROM ubuntu:latest
ENV DEBIAN_FRONTEND=nonintercative 

#update and install packages
RUN apt update
RUN apt install -y vim
RUN apt install -y apache2
RUN apt install -y sudo
RUN apt install -y apache2-utils

#enable the UserDir module
RUN a2enmod userdir
#enable DirectoryIndex module
RUN a2enmod autoindex

#enabling other Apache modules
RUN a2enmod ssl

#creating self signed certificates and placing in appropriate location
COPY self-signed.crt /etc/apache2/ssl/ssl.crt
COPY selfsigned.key /etc/apache2/ssl/ssl.key
RUN mkdir -p /var/run/apache2/

#creating 3 directories to host the 3 websites
WORKDIR /var/www/html
RUN sudo mkdir -p /site1.internal/public_html

#modifying permission to web dir
RUN sudo chmod -R 775 /var/www/html

WORKDIR /var/www/html/site1.internal/public_html
COPY site1index.html .

#vHost files of the 3 websites
COPY site1.conf /etc/apache2/sites-available

#enable the 3 websites
RUN sudo a2ensite site1.conf

#disabling defeault site
RUN sudo a2dissite 000-default.conf

WORKDIR /etc/
COPY hosts .

# Add in other directives as needed
LABEL Maintainer: "jazmin.celestino.694@my.csun.edu"

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]

