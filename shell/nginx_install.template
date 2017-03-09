#!/bin/bash

#NGINX_VERSION 1.8.1
#user:nginx
#group:nginx
#Building nginx
#--------------
#Download building pcre and zlib.
#nginx installation path is /usr/mpsp/nginx

NGINX_HOME=/usr/mpsp/nginx
USER_HMOE=/usr/mpsp

NGINX_VERSION=1.8.1
PCRE_VERSION=pcre-8.4.0
ZLIB_VERSION=zlib-1.2.11
SERVER_NAME=KJ_OS

NGINX_TGZ_URL=http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
PCRE_TGZ_URL=https://ftp.pcre.org/pub/pcre/$PCRE_VERSION
ZLIB_TGZ_URL=http://www.zlib.net/$ZLIB_VERSION

CONFIG="\
	--prefix=${NGINX_HOME} \
	--with-pcre=$USER_HOME/$PCRE_VERSION \
	--with-zlib=$USER_HOME/$ZLIB_VERSION \
	--with-http_stub_status_module \
	--with-http_ssl_module \
	--with-http_realip_module \
	"
grep nginx /etc/group >& /dev/null \
&& if [ $? -ne 0 ]
then
  groupadd nginx
fi \
&& adduser -D -s /sbin/nologin -G nginx nginx \
&& yum groupinstall "Development tools" -y \
&& exit \
&& cd /tmp \
&& wget -O pcre.tar.gz "$PCRE_TGZ_URL" \
&& wget -O nginx.tar.gz "$NGINX_TGZ_URL" \
&& tar -zxC $USER_HOME/ -f pcre.tar.gz \
&& tar -zxf nginx.tar.gz \
&& rm nginx.tar.gz \
&& cd nginx-$NGINX_VERSION \
&& sed -i '/NGINX_VER/{s/nginx/"$SERVER_NAME"/g}' src/core/nginx.h \
&& sed -i '/static char/{s/nginx/"SERVER_NAME"/g}' src/http/ngx_http_header_filter_module.c \
&& ./configure $CONFIG
