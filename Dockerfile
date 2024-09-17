FROM centos:latest
MAINTAINER mducfa@gmail.com
RUN yum install -y httpd \
zip\
unzip
COPY /photogenic/* /var/www/html/
WORKDIR /var/www/html/
RUN unzip photogenic.zip
RUN cp -rvf photogenic/*.
RUN rm -rf photogenic photogenic.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
