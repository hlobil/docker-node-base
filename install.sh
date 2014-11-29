set -ex

echo 'runing install script'

# https://superuser.com/questions/615565/can-i-make-apt-get-always-use-no-install-recommends
cat > /etc/apt/apt.conf.d/01norecommend << EOF
APT::Install-Recommends "0";
APT::Install-Suggests "0";
EOF

# prime with github and bitbucket keys
#
# [anga.funkfeuer.at]:2022,[78.41.115.130]:2022 ssh-rsa AAAAB...fgTHaojQ==
mkdir -p /root/.ssh/
ssh-keyscan -t rsa,dsa github.com >> /root/.ssh/known_hosts
+ssh-keyscan -t rsa,dsa bitbucket.com >> /root/.ssh/known_hosts



# Install build dependencies
apt-get update -qq
apt-get upgrade -qqy
apt-get -qq -y install build-essential python gcc g++ make curl bzip2 git openssh-client

# Install node.js
curl --silent http://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | \
    tar -C /usr/local/ --strip-components=1 -xvz > /dev/null; \
    npm update -g npm

# change root password
echo 'root:zlobil' | chpasswd

# setup default directory for web app
mkdir -p /var/www/

# cleanup apt cache to save image space
apt-get -qqy autoclean
apt-get -qqy clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
