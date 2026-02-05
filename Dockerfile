FROM mautic/mautic:latest

USER root

# Install required OS libs + PHP GD dependencies (Debian-based image)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libavif15 \
    libpng16-16 \
    libjpeg62-turbo \
    libfreetype6 \
    && rm -rf /var/lib/apt/lists/*

# If GD is already installed but failing due to missing libs, the above is usually enough.
# If your image still doesn't have GD enabled, you can install/enable it like below.
# (This part may or may not work depending on how the base image ships PHP)
RUN php -m | grep -i gd || true
