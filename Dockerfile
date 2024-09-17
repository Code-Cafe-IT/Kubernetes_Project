FROM centos:latest
RUN yum install -y httpd \
COPY photogenic/ /var/www/html/
WORKDIR /var/www/html/
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
