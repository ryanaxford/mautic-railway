#!/bin/sh
set -e

# Ensure directories exist (volume mount may be empty)
mkdir -p /var/www/html/var/cache /var/www/html/var/logs /var/www/html/var/tmp

# Fix ownership/permissions for the mounted volume
chown -R www-data:www-data /var/www/html/var || true
chmod -R 775 /var/www/html/var || true

# Hand off to the original entrypoint if it exists, otherwise start apache
if [ -x /entrypoint.sh ]; then
  exec /entrypoint.sh "$@"
elif command -v docker-php-entrypoint >/dev/null 2>&1; then
  exec docker-php-entrypoint "$@"
else
  exec apache2-foreground
fi
