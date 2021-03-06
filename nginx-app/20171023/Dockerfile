FROM alpine

MAINTAINER WHITEPLUS System "sysadmin@wh-plus.com"

# Ref: https://hub.docker.com/_/nginx/
# Ref: https://hub.docker.com/_/php/
# Ref: https://hub.docker.com/_/node/

ARG NGINX_VER=1.13.6
ARG NGINX_CONF="--prefix=/nginx \
                --sbin-path=/usr/local/sbin/nginx \
                --http-log-path=/nginx/logs/nginx_access.log \
                --error-log-path=/nginx/logs/nginx_error.log \
                --pid-path=/nginx/run/nginx.pid \
                --lock-path=/nginx/run/nginx.lock \
                --user=web --group=web \
                --with-http_ssl_module \
                --with-http_realip_module \
                --with-http_addition_module \
                --with-http_sub_module \
                --with-http_dav_module \
                --with-http_flv_module \
                --with-http_mp4_module \
                --with-http_gunzip_module \
                --with-http_gzip_static_module \
                --with-http_random_index_module \
                --with-http_secure_link_module \
                --with-http_stub_status_module \
                --with-threads \
                --with-stream \
                --with-stream_ssl_module \
                --with-http_slice_module \
                --with-mail \
                --with-mail_ssl_module \
                --with-http_v2_module \
                --with-ipv6"
ARG NGINX_GPG="573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
               A09CD539B8BB8CBE96E82BDFABD4D3B3F5806B4D \
               4C2C85E705DC730833990C38A9376139A524C53E \
               65506C02EFC250F1B7A3D694ECF0E90B2C172083 \
               B0F4253373F8F6F510D42178520A9993A1C052F8 \
               7338973069ED3F443F4D37DFA64FD5B17ADB39A8"

ARG PHP_VER=7.1.11
ARG PHP_MIRROR=http://fr2.php.net
ARG PHP_CONF="--enable-fpm \
                --with-fpm-user=web \
                --with-fpm-group=web \
                --with-config-file-path="/php" \
                --with-config-file-scan-dir="/php/conf.d" \
                --disable-cgi \
                --enable-mysqlnd \
                --enable-mbstring \
                --with-curl \
                --with-libedit \
                --with-openssl \
                --with-zlib"
ARG PHP_GPG="A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 \
             528995BFEDFBA7191D46839EF9BA0ADA31CBD89E"

ARG PHP_EXT_LIST="gd \
                mysqli \
                ctype \
                dom \
                iconv \
                json \
                xml \
                mbstring \
                posix \
                xmlwriter \
                zip \
                sqlite3 \
                pdo_sqlite \
                pdo_pgsql \
                pdo_mysql \
                curl \
                fileinfo \
                bz2 \
                intl \
                mcrypt \
                openssl \
                ldap \
                simplexml \
                pgsql \
                ftp \
                exif \
                gmp \
                mbstring"
ARG CUSTOM_BUILD_PKGS="freetype-dev \
                        openldap-dev \
                        gmp-dev \
                        sqlite-dev \
                        postgresql-dev \
                        libmcrypt-dev \
                        bzip2-dev \
                        icu-dev \
                        libzip-dev \
                        libc-dev"
ARG CUSTOM_PKGS="freetype \
                openldap \
                gmp \
                libmcrypt \
                libpng \
                libjpeg-turbo \
                freetype \
                libwebp \
                libxpm \
                libzip \
                sqlite-libs \
                libpq \
                libcurl \
                libbz2 \
                icu-libs \
                libgcc \
                libstdc++ \
                libldap"

ENV UID=991 \
    GID=991

LABEL description="nginx and php7 based on alpine" \
      tags="latest" \
      nginx_version="${NGINX_VER}" \
      php_version="${PHP_VER}"

RUN export BUILD_DEPS="build-base \
                    wget \
                    gnupg \
                    autoconf \
                    libressl-dev \
                    g++ \
                    pcre-dev \
                    curl-dev \
                    libedit-dev \
                    gcc \
                    zlib-dev \
                    make \
                    pkgconf \
                    wget \
                    ca-certificates \
                    libxml2-dev \
                    ${CUSTOM_BUILD_PKGS}" \
    && NB_CORES=${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} \
    && apk add -U ${BUILD_DEPS} \
                    curl \
                    libedit \
                    libxml2 \
                    libressl \
                    pcre \
		            zlib \
                    ${CUSTOM_PKGS} \
    && wget http://nginx.org/download/nginx-${NGINX_VER}.tar.gz -O /tmp/nginx-${NGINX_VER}.tar.gz \
    && wget http://nginx.org/download/nginx-${NGINX_VER}.tar.gz.asc -O /tmp/nginx-${NGINX_VER}.tar.gz.asc \
    && wget ${PHP_MIRROR}/get/php-${PHP_VER}.tar.gz/from/this/mirror -O /tmp/php-${PHP_VER}.tar.gz \
    && wget ${PHP_MIRROR}/get/php-${PHP_VER}.tar.gz.asc/from/this/mirror -O /tmp/php-${PHP_VER}.tar.gz.asc \
    && for server in ha.pool.sks-keyservers.net hkp://keyserver.ubuntu.com:80 hkp://p80.pool.sks-keyservers.net:80 pgp.mit.edu; \
	    do \
            echo "Fetching GPG key $NGINX_GPG from $server"; \
            gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys $NGINX_GPG && found=yes && break; \
        done \
    && gpg --batch --verify /tmp/nginx-${NGINX_VER}.tar.gz.asc /tmp/nginx-${NGINX_VER}.tar.gz \
    && for server in ha.pool.sks-keyservers.net hkp://keyserver.ubuntu.com:80 hkp://p80.pool.sks-keyservers.net:80 pgp.mit.edu; \
	    do \
            echo "Fetching GPG key $PHP_GPG from $server"; \
            gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys $PHP_GPG && found=yes && break; \
        done \
    && gpg --batch --verify /tmp/php-${PHP_VER}.tar.gz.asc /tmp/php-${PHP_VER}.tar.gz \
    && mkdir -p /php/conf.d \
    && mkdir -p /usr/src \
    && tar xzf /tmp/nginx-${NGINX_VER}.tar.gz -C /usr/src \
    && tar xzvf /tmp/php-${PHP_VER}.tar.gz -C /usr/src \
    && cd /usr/src/nginx-${NGINX_VER} \
    && ./configure ${NGINX_CONF} \
    && make -j ${NB_CORES} \
    && make install \
    && mv /usr/src/php-${PHP_VER} /usr/src/php \
    && cd /usr/src/php \
    && ./configure ${PHP_CONF} \
    && make -j ${NB_CORES} \
    && make install \
    && { find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; } \
    && make clean \
    && chmod u+x /usr/local/bin/* \
    && if [ "${PHP_EXT_LIST}" != "" ]; then docker-php-ext-install ${PHP_EXT_LIST}; fi \
    && apk del ${BUILD_DEPS} \
    && rm -rf /tmp/* /var/cache/apk/* /usr/src/* \