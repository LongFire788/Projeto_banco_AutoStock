FROM dunglas/frankenphp:1-php8.3-bookworm

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && install-php-extensions pdo_pgsql intl zip

WORKDIR /app

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY . .

RUN rm -f bootstrap/cache/*.php \
    && mkdir -p \
        storage/framework/cache \
        storage/framework/sessions \
        storage/framework/views \
        bootstrap/cache \
    && composer install \
        --no-dev \
        --no-interaction \
        --no-progress \
        --prefer-dist \
        --optimize-autoloader

COPY --chown=www-data:www-data Caddyfile /etc/frankenphp/Caddyfile
RUN chown -R www-data:www-data /app

ENV PORT=80 \
    APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr

USER www-data
CMD ["frankenphp", "run", "--config", "/etc/frankenphp/Caddyfile"]
