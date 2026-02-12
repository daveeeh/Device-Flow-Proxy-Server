FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && docker-php-ext-install opcache

# Enable Apache rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set document root to public/
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Update Apache config to use public folder
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www/html

# Copy app
COPY . .

# Install composer dependencies
RUN composer install --no-dev --optimize-autoloader

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Disable deprecated warnings
RUN echo "display_errors=Off" >> /usr/local/etc/php/conf.d/render.ini \
 && echo "display_startup_errors=Off" >> /usr/local/etc/php/conf.d/render.ini \
 && echo "error_reporting=E_ALL & ~E_DEPRECATED & ~E_NOTICE" >> /usr/local/etc/php/conf.d/render.ini

EXPOSE 80

CMD ["apache2-foreground"]

