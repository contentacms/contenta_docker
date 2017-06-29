FROM amazeeio/centos:7

# Install required repos, update, and then install PHP-FPM
RUN yum install -y epel-release \
        http://rpms.remirepo.net/enterprise/remi-release-7.rpm  \
        yum-utils && \
    yum-config-manager --enable remi-php70 && \
    yum install -y \
        php-bcmath \
        php-cli \
        php-fpm \
        php-mysqlnd \
        php-xml \
        php-gd \
        php-mcrypt \
        php-ldap \
        php-imap \
        php-soap \
        php-tidy \
        php-mbstring \
        php-opcache \
        php-pdo \
        php-pecl-apcu \
        php-pecl-apcu-bc \
        php-pecl-geoip \
        php-pecl-igbinary \
        php-pecl-imagick \
        php-pecl-redis \
        mariadb \
        git \
        unzip \
        wget && \
    yum --enablerepo=epel install -y fcgi && \
    yum clean all

COPY docker-entrypoint /usr/local/bin/
COPY conf/php-fpm.conf conf/php.ini /etc/
COPY conf/www.conf /etc/php-fpm.d/www.conf

RUN mkdir -p /var/www && \
    fix-permissions /etc/php.ini && \
    fix-permissions /etc/php-fpm.conf && \
    fix-permissions /etc/php-fpm.d/ && \
    fix-permissions /run/php-fpm && \
    fix-permissions /var/www && \
    fix-permissions /var/lib/php/session/ && \
    chmod +x /usr/local/bin/docker-entrypoint

# Install Composer
ENV COMPOSER_VERSION 1.4.2
RUN	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && \
  chmod +x /usr/local/bin/composer && \
  composer global require "hirak/prestissimo:^0.3"

# Install Drush using Composer.
ENV DRUSH_VERSION 8.1.11
RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    wget https://github.com/drush-ops/drush/archive/${DRUSH_VERSION}.tar.gz && \
    tar -xzf ${DRUSH_VERSION}.tar.gz && \
    mv drush-${DRUSH_VERSION} drush && \
    ln -s /usr/local/src/drush/drush /usr/bin/drush && \
    cd drush && \
    composer install

RUN cd /usr/local/src && \
    wget https://github.com/contentacms/contenta_jsonapi/archive/8.x-1.x.zip && \
    unzip 8.x-1.x.zip -d contenta_jsonapi && \
    cd /usr/local/src/contenta_jsonapi && \
    composer create-project contentacms/contenta-jsonapi-project /var/www --stability dev --no-interaction && \
    cd /var/www && \
    composer config repositories.contenta_jsonapi path .

WORKDIR /var/www/web

EXPOSE 9000

ENTRYPOINT ["docker-entrypoint"]

# Run PHP-FPM on container start.
CMD ["/usr/sbin/php-fpm", "-F", "-R"]
