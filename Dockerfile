FROM ubuntu:bionic

ADD ./ansible /ansible


RUN set -x && \
  apt update -y && \
  apt install -y ansible


RUN set -x && \
  cd /ansible && \
  ansible-playbook \
    --inventory-file=./configuration/hosts \
    --connection=local \
    playbooks/provision-container.yml


RUN set -x && \
  apt-get purge \
    --auto-remove ansible -y


ENV \
  USER=root \
  GOPATH=$HOME/go \
  PATH=$PATH:$HOME/.local/bin:/usr/local/go/bin:$GOPATH/bin


VOLUME /mnt/direct
