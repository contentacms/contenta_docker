FROM amazeeio/centos:7

# Install required repos, update, and then install PHP-FPM
RUN yum install -y epel-release \
        http://rpms.remirepo.net/enterprise/remi-release-7.rpm  \
        yum-utils && \
    yum-config-manager --enable remi-php71 && \
    yum update -y && \
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
        php-pcntl \
        php-pdo \
        php-pecl-apcu \
        php-pecl-apcu-bc \
        php-pecl-geoip \
        php-pecl-igbinary \
        php-pecl-imagick \
        php-pecl-redis \
        php-pecl-xdebug \
        mariadb \
        git \
        patch \
        openssl \
        unzip \
        wget && \
    yum --enablerepo=epel install -y fcgi && \
    yum clean all

# Install Composer
ENV COMPOSER_VERSION 1.9.0
RUN	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && \
  chmod +x /usr/local/bin/composer && \
  composer global require "hirak/prestissimo:^0.3" && \
  composer global require consolidation/cgr && \
  composer --global config process-timeout 2000 && \
  export PATH="$HOME/.composer/vendor/bin:$PATH" && \
  cgr drush/drush

COPY docker-entrypoint /usr/local/bin/
COPY conf/php-fpm.conf conf/php.ini /etc/
COPY conf/www.conf /etc/php-fpm.d/www.conf

RUN mkdir -p /var/www  && \
    mkdir -p /run/php-fpm  && \
    fix-permissions /etc/php.ini && \
    fix-permissions /etc/php-fpm.conf && \
    fix-permissions /etc/php-fpm.d/ && \
    fix-permissions /run/php-fpm && \
    fix-permissions /var/lib/php/session/ && \
    chmod +x /usr/local/bin/docker-entrypoint

WORKDIR /var/www

EXPOSE 9000

ENTRYPOINT ["docker-entrypoint"]

# Run PHP-FPM on container start.
CMD ["/usr/sbin/php-fpm", "-F", "-R"]
