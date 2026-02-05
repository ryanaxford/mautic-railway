FROM mautic/mautic:latest
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    libxpm4 \
    libavif15 \
 && rm -rf /var/lib/apt/lists/*
RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
&& a2enconf servername
ENV PHP_INI_DATE_TIMEZONE="UTC"
