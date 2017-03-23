#!/bin/bash

#&& adduser -s /sbin/nologin -g nginx nginx \
#&& rm nginx.tar.gz \
#&& wget -O pcre.tar.gz "$PCRE_TGZ_URL" \
#&& wget -O nginx.tar.gz "$NGINX_TGZ_URL" \
#NGINX_VERSION 1.8.1
#user:nginx
#group:nginx
#Building nginx
#--------------
#Download building pcre and zlib.
#nginx installation path is /usr/mpsp/nginx
#sudo su - root 

NGINX_HOME=/usr/mpsp/nginx
USER_HMOE=/usr/mpsp

NGINX_VERSION=1.8.0
PCRE_VERSION=pcre-8.40
ZLIB_VERSION=zlib-1.2.11
SERVERNAME=KJ_OS

NGINX_TGZ_URL=http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
PCRE_TGZ_URL=https://ftp.pcre.org/pub/pcre/$PCRE_VERSION
ZLIB_TGZ_URL=http://www.zlib.net/$ZLIB_VERSION

CONFIG="\
--prefix=${NGINX_HOME} \
--with-pcre=/tmp/$PCRE_VERSION \
--with-zlib=/tmp/$ZLIB_VERSION \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_realip_module \
"
grep nginx /etc/group >& /dev/null
if [ $? -ne 0 ]
then
groupadd nginx
fi \
\
&& yum groupinstall "Development tools" -y \
&& cd /tmp \
&& tar -zxf $PCRE_VERSION.tar.gz \
&& tar -zxf $ZLIB_VERSION.tar.gz \
&& tar -zxf nginx-$NGINX_VERSION.tar.gz \
&& cd $PCRE_VERSION \
&& ./configure --disable-shared \
&& cd ../nginx-$NGINX_VERSION \
\
&& sed -i "/NGINX_VER/{s/nginx/$SERVERNAME/g}" src/core/nginx.h \
&& sed -i "/static char/{s/nginx/$SERVERNAME/g}" src/http/ngx_http_header_filter_module.c \
&& ./configure $CONFIG \
&& make && make install
chown -R mpsp.mpsp $NGINX_HOME
