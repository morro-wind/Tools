sudo cat > /etc/yum.repos.d/base.repo << EOF
[CentOS Base]
name=centos base
baseurl=http://mirrors.aliyun.com/centos/6/os/x86_64/
gpgcheck=0
enabled=1
gpgkey=
EOF

sudo yum clean all
sudo yum update -y
sudo yum upgrade -y
