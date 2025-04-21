echo Server running on port 80
/usr/sbin/sshd -D &
python3 -m http.server 80 -d /var/www/html
