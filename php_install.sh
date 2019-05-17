#!/bin/bash

wget https://www.php.net/distributions/php-7.3.5.tar.gz
tar zxf php-7.3.5.tar.gz
cd php-7.3.5
./configure '--prefix=/usr/local/php' '--with-config-file-path=/usr/local/php/etc' '--enable-bcmath' '--enable-ctype' '--enable-sockets' '--enable-mbstring' '--with-gettext' '--enable-fpm' '--with-mysqli' '--with-curl' '--with-zlib' '--with-freetype-dir' '--with-jpeg-dir' '--with-gd'

[[ $? -ne 0 ]] && echo "configure failed" && exit 35

make && sudo make install
[[ $? -ne 0 ]] && echo "make failed" && exit 45

if [ -d /usr/local/php/etc ]; then
    sudo cp php.ini-production /usr/local/php/etc/php.ini
    sudo cp sapi/fpm/php-fpm.conf /usr/local/php/etc/php-fpm.conf
    sudo cp sapi/fpm/www.conf /usr/local/php/etc/php-fpm.d/
    sudo cp api/fpm/init.d.php-fpm /etc/init.d/php-fpm
fi
sed -i "s/post_max_size = 8M/post_max_size = 16M/" /usr/local/php/etc/php.ini
sed -i "s/max_execution_time = 30/max_execution_time = 300/" /usr/local/php/etc/php.ini
sed -i "s/max_input_time = 60/max_input_time = 300/" /usr/local/php/etc/php.ini
