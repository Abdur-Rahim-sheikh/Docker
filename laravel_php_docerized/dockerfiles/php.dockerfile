FROM php:7.4-fpm-alpine

WORKDIR /val/www/html

RUN docker-php-ext-install pdo pdo_mysql