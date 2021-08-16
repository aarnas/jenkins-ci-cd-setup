FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
       apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli

# Using Ubuntu
#curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
#sudo apt-get install -y nodejs

#sudo npm install --global yarn

RUN apt-get install -y sudo

# RUN apt-get update \
#       && apt-get install -y sudo \
#       && rm -rf /var/lib/apt/lists/*
# RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN echo "jenkins:jenkins" | chpasswd && adduser jenkins sudo

USER jenkins
RUN jenkins-plugin-cli --plugins blueocean