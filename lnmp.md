

./configure --prefix=/opt/nginx --conf-path=/opt/conf/nginx/nginx.conf --error-log-path=/opt/logs/nginx/error.log --http-log-path=/opt/logs/nginx/access.log --user=www --group=www --with-http_ssl_module --with-http_flv_module --with-http_stub_status_module --with-http_gzip_static_module --http-client-body-temp-path=/opt/temp/nginx/client --http-proxy-temp-path=/opt/temp/nginx/proxy --http-fastcgi-temp-path=/opt/temp/nginx/fcgi --without-http_uwsgi_module --without-http_scgi_module --with-http_image_filter_module --with-file-aio --with-http_realip_module --pid-path=/opt/logs/nginx/nginx.pid

配置nginx文件

编译安装mysql
mysql version：5.7
先决条件：
1.boost_1_59_0		5.7版本开始boost库是必须的.切记，版本要是1.59.0，配置编译过程中会对版本做验证，版本不符合无法通过
2.cmake				所有平台上的构建框架
3.make				建议make版本3.75+
4.gcc-c++
5.ncurses library
安装相关依赖
yum install -y gcc gcc-c++ make cmake ncurses-devel wget

下载boost_1_59_0
访问https://www.boost.org/users/history/ 查找对应版本下载并解压
可通过修改boost/version.hpp文件内的版本标记，使配置编译通过，但后期会对程序造成何种影响未知

cmake 参数说明https://dev.mysql.com/doc/refman/5.7/en/source-configuration-options.html
mysql配置编译
cd /src/mysql-5.7.21
mkdir bld
cd bld
参数如下
cmake .. -DCMAKE_INSTALL_PREFIX=/opt/mysql \
-DMYSQL_DATADIR=/opt/data/mysql \
-DSYSCONFDIR=/opt/conf/mysql \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS:STRING=utf8,gbk \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1 \
-DWITH_BOOST=/opt/src/boost_1_59_0

预编译
make -j `grep processor /proc/cpuinfo | wc -l`

编译过程中有报错，报错为not found rpcgen
rpcgen 包含在glibc 包中，因系统环境glibc包有版本冲突，重新安装了glibc，但安装不完全，导致缺少rpcgen，升级glibc，包含glibc-common、glibc-header、glibc-devel，应该只要升级安装glibc-common即可，我将所有的都升级为统一的版本了
下载glibc rpm升级包
rpm -Uvh glic.rpm
清除编译文件，重新编译
make clean
make -j `grep processor /proc/cpuinfo | wc -l`
编译安装
make install

配置my.cn



php5.6

./configure --prefix=/opt/php --with-config-file-path=/opt/conf/php --with-mysql --with-mysqli \
--with-config-file-scan-dir=/opt/conf/php/php.d --enable-fpm --with-gd --with-iconv \
--with-zlib --enable-xml --enable-inline-optimization --with-openssl --enable-pcntl \
--enable-zip --with-curl --with-bz2 --with-jpeg-dir --with-png-dir --enable-mbstring --with-freetype-dir --with-gettext --enable-sockets --enable-bcmath --with-ldap --with-ldap-sasl

make -j `grep processor /proc/cpuinfo | wc -l`
make install