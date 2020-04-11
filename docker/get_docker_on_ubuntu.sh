#!/bin/sh
echo "## get docker start."

echo '## step 1: sudo apt-get remove docker docker-engine docker.io containerd runc -y'
sudo apt-get remove docker docker-engine docker.io containerd runc -y

echo '## step 2: sudo apt-get update -y'
sudo apt-get update -y

echo '## step 3: apt-get install apt-transport-https ...'
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

echo '## step 4: sudo curl -fsSL ...'	
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo '## step 5: sudo apt-key fingerprint 0EBFCD88'
sudo apt-key fingerprint 0EBFCD88

echo '## step 6: sudo add-apt-repository ...'
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"	

echo '## step 7: sudo apt-get update -y'
sudo apt-get update -y

echo '## step 8: sudo apt-get install docker-ce docker-ce-cli containerd.io -y'
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo "## get docker done."