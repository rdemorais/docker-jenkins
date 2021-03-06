FROM jenkins/jenkins

# install docker, docker-compose, docker-machine
# see: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
# see: https://docs.docker.com/engine/installation/linux/linux-postinstall/
# see: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

USER root

# prerequisites for docker
RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

# docker repos
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
  && echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" >> /etc/apt/sources.list.d/additional-repositories.list \
  && echo "deb http://ftp-stud.hs-esslingen.de/ubuntu xenial main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 437D05B5 \
  && apt-get update

# docker
RUN apt-get -y install docker-ce

# npm
RUN curl -k -L https://deb.nodesource.com/setup_8.x | bash -  && \
  apt-get install -y nodejs --no-install-recommends

# yarn 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install --no-install-recommends yarn

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose

RUN apt-get install -y git && \
  git --version

# give jenkins docker rights
RUN usermod -aG docker jenkins

USER jenkins
