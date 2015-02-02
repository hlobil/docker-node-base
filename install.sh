set -ex

echo 'runing install script'

# Install build dependencies
buildDeps='build-essential curl ca-certificates pkg-config python git openssh-client'
apt-get update -qq
apt-get upgrade -qqy
apt-get install -qqy --no-install-recommends ${buildDeps}
rm -rf /var/lib/apt/lists/*

# prime with github and bitbucket keys
#
# [anga.funkfeuer.at]:2022,[78.41.115.130]:2022 ssh-rsa AAAAB...fgTHaojQ==
mkdir -p /root/.ssh/
ssh-keyscan -t rsa,dsa github.com >> /root/.ssh/known_hosts
ssh-keyscan -t rsa,dsa bitbucket.com >> /root/.ssh/known_hosts



# Install node.js
curl --silent http://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | \
    tar -C /usr/local/ --strip-components=1 -xvz > /dev/null; 

# Install npm    
npm install -g npm@${NPM_VERSION}

# change root password
echo 'root:zlobil' | chpasswd

# setup default directory for web app
mkdir -p /var/www/

# cleanup apt cache to save image space
# apt-get -qqy autoclean
# apt-get -qqy clean
# rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# npm cache clear
