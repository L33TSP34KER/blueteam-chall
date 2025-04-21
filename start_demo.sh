echo "building building malicious binary :3"
cargo build --release
echo "building docker image (might take a long time)"
docker build -t backdoor_demo . >/dev/null
echo starting docker image
echo -e "\tyou can connect through ssh with the"
echo -e "\tusername toor"
echo -e "\tpassword a"
echo -e "\tthen type sudo su to start the chall"
docker run backdoor_demo
