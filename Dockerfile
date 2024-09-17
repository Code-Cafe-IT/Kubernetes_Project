FROM centos:latest
RUN yum install -y httpd \
zip\
unzip
COPY photogenic/ /var/www/html/
WORKDIR /var/www/html/
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
