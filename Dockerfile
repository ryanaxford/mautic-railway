FROM mautic/mautic:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends libxpm4 libavif15 \
 && rm -rf /var/lib/apt/lists/*

RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
 && a2enconf servername

#  ensure cache/log folders exist and are writable
RUN mkdir -p /var/www/html/var/cache /var/www/html/var/logs /var/www/html/docroot/media \
 && chmod -R 775 /var/www/html/var /var/www/html/docroot/media

ENV PHP_INI_DATE_TIMEZONE="UTC"
