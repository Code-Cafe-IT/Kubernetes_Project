# Sử dụng Ubuntu làm image nền
FROM ubuntu:latest

# Cập nhật hệ thống và cài đặt Apache HTTP Server
RUN apt-get update && \
    apt-get install -y apache2

# Copy thư mục photogenic vào /var/www/html/
COPY photogenic/ /var/www/html/

# Thiết lập thư mục làm việc
WORKDIR /var/www/html/

# Mở cổng 80
EXPOSE 80

# Khởi động Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
