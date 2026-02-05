FROM mautic/mautic:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends libxpm4 libavif15 \
 && rm -rf /var/lib/apt/lists/*

RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
 && a2enconf servername

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENV PHP_INI_DATE_TIMEZONE="UTC"

# ✅ must be root to chown Railway volume
USER root

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
