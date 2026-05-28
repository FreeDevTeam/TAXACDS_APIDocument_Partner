FROM php:7.0-apache

COPY ./* /var/www/html/
RUN rm -rf /var/www/html/.git
RUN rm -rf /var/www/html/.github
RUN rm -rf /var/www/html/.vscode

ENV PORT 80
EXPOSE 80