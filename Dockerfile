FROM ubuntu:18.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN rm /etc/dpkg/dpkg.cfg.d/excludes
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y man sudo
RUN mkdir /test && chmod 777 /test
# ADD root
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

######################### BEGIN CUSTOMIZATION ######################
# Utilities
RUN sudo DEBIAN_FRONTEND=noninteractive \
apt-get install -y nodejs gcc g++ \
make zip unzip rsync cron \
ntpdate htop openssl curl \
wget git nmap tcptraceroute iperf3 \
net-tools iproute2 tcpdump vim nano gawk diffstat \
texinfo gcc-multilib build-essential chrpath \
libsdl1.2-dev xterm qemu-utils \
mc tcpflow whois python3 python3-pip \
valgrind inetutils-traceroute iputils-ping --fix-missing

# OpenVPN Configuration
RUN echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
RUN echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
RUN sudo apt-get install -y openvpn easy-rsa iptables iptables-persistent openssl
RUN sudo adduser --system --shell /usr/sbin/nologin --no-create-home openvpn

# Create this rnd file if it doesn't exist.
RUN if ! [ -f $HOME/.rnd ]; then dd if=/dev/urandom of=$HOME/.rnd bs=256 count=1 ; fi


######################### END CUSTOMIZATION #########################
WORKDIR /testenv

CMD /bin/bash
