FROM centos:latest
MAINTAINER mducfa@gmail.com
RUN yum install -y httpd \
zip\
unzip
COPY photogenic/ /var/www/html/
WORKDIR /var/www/html/
RUN cp -rvf photogenic/* . && rm -rf photogenic
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
