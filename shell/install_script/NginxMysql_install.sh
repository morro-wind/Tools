#/bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo service iptables stop
sudo setenforce 0

sudo yum groupinstall "Development Libraries" -y
sudo yum groupinstall "Development Tools" -y

sudo yum install yum-utils -y

sudo cat > /etc/yum.repos.d/nginx.repo <<EOF
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/6/x86_64/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
EOF

sudo yum-config-manager --enable nginx-mainline
sudo yum install nginx -y
[[ ! -d /etc/nginx/conf.d ]] && echo "110" && exit 110

rm -rf /etc/nginx/conf.d/default.conf
cat > /etc/nginx/conf.d/default.conf << EOF
server {
    listen  80;
    server_name localhost;
    location  / {
        root    /usr/share/zabbix;
        index   index.php index.html;
    }
    error_page  500 502 503 504  /50x.html;
    location = /50x.html {
        root    /usr/share/nginx/html;
    }
    location ~ \\.php\$ {
        root    /usr/share/zabbix;
        fastcgi_pass    127.0.0.1:9000;
        fastcgi_param   SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
        include         fastcgi_params;
    }
}
EOF

sudo chkconfig nginx on

curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
sudo sed -i "s/\$releasever/6/" /etc/yum.repos.d/mariadb.repo
sudo yum install MariaDB-server MariaDB-client -y


sudo service mysql start
sudo chkconfig mysql on
