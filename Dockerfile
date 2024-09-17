FROM centos:7

# Cập nhật hệ thống và cài đặt httpd
RUN yum clean all && yum -y update && yum -y install httpd

# Copy thư mục photogenic vào /var/www/html/
COPY photogenic/ /var/www/html/

# Thiết lập thư mục làm việc
WORKDIR /var/www/html/

# Mở cổng 80
EXPOSE 80

# Khởi động Apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
