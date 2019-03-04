FROM composer as vendor
COPY composer.json composer.json
COPY composer.lock composer.lock
RUN composer install



FROM php:7
RUN apt-get update && apt-get install -y imagemagick gnupg2 gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget 
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash \
      && apt-get install -y nodejs \
      && npm install --global --unsafe-perm puppeteer \
      && chmod -R o+rx /usr/lib/node_modules/puppeteer/.local-chromium

WORKDIR /app
COPY . .
COPY --from=vendor /app/vendor /app/vendor

ENTRYPOINT [ "php", "/app/screenshot.php" ]