FROM php:8.1-fpm-alpine

WORKDIR /val/www/html

RUN docker-php-ext-install pdo pdo_mysql