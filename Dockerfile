FROM php:8.2-cli

# Estensioni necessarie: SOAP + ZIP + certificati
RUN apt-get update && apt-get install -y \
    zip unzip ca-certificates \
    libxml2-dev pkg-config \
    libzip-dev \
    && docker-php-ext-install zip soap

WORKDIR /app
COPY . /app

# Composer (per eventuali dipendenze/autoload)
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN composer install --no-dev --optimize-autoloader || true

# Render si aspetta un servizio HTTP: esponiamo 8080
EXPOSE 8080

# Server PHP built-in che serve la cartella public/
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
