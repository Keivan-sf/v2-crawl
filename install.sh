git clone https://github.com/Keivan-sf/v2ray-config-tester;
git clone https://github.com/Keivan-sf/v2ray-config-finder-tg;
cd ./v2ray-config-tester
pnpm i
cd ../v2ray-config-finder-tg
pnpm i
cd ../

echo "finished cloning repos"

cd ./v2ray-config-tester
wget https://github.com/Keivan-sf/v2-uri-parser/releases/download/v0.1.1/v2parser && chmod +x ./v2parser
cd ../


echo "finished downloading v2-uri-parser"

read -p "Your telegram app api id:" API_ID
read -p "Your telegram app api hash:" API_HASH

cat > ./v2ray-config-finder-tg/.env <<EOF
APP_API_ID=$API_ID
APP_API_HASH="$API_HASH"
CONFIG_TESTER_URL="http://127.0.0.1:5574/add-config"
EOF

read -p "Local socks5 port to connect to telegram. This proxy must actually work in order for script to function (1-65535):" LOCAL_SOCKS_PORT

cat > ./v2ray-config-finder-tg/proxychains.conf <<EOF
strict_chain

quiet_mode

proxy_dns

remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
localnet 127.0.0.0/255.0.0.0
[ProxyList]
socks5 127.0.0.1 $LOCAL_SOCKS_PORT 
EOF

cd ./v2ray-config-finder-tg
echo "Log in with your crawler telegram account:"
ONLY_AUTH=true proxychains4 -f ./proxychains.conf pnpm start
echo "Logged in successfully, authentication stored"
echo "Generating start script"

cd ../

cat > ./start.sh <<EOF
p_cleanup() {
  kill 0
}
trap p_cleanup EXIT


echo -e "\n\nsubscription available at http://127.0.0.1:5574/s/configs \n\n"

sleep 1

cd ./v2ray-config-tester
pnpm start | sed 's/^/[config-tester] /' & 
sleep 2
cd ../v2ray-config-finder-tg
proxychains4 -f ./proxychains.conf pnpm start | sed 's/^/[config-finder] /' &


wait
EOF

chmod +xrw ./start.sh

echo "Finished! you can now run ./start.sh to start the process"
