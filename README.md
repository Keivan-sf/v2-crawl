## V2 Crawl
Telegram crawler for v2ray URIs + connectivity testing

This is simply a quickstart script for the following repos running together:
- [Keivan-sf/v2ray-config-tester](https://github.com/Keivan-sf/v2ray-config-tester)
- [Keivan-sf/v2ray-config-finder-tg](https://github.com/Keivan-sf/v2ray-config-finder-tg)
- [Keivan-sf/v2-uri-parser](https://github.com/Keivan-sf/v2-uri-parser)

### Prerequisites
- You'll need `proxychains`, `curl`, `wget`, `pnpm`, `node`
- You'll need a telegram application API ID and API Hash which you can get from [my.telegram.org/apps](https://my.telegram.org/apps)
- You'll need a working local socks5 proxy in order for the app to connect to telegram using proxychains

### How to use
- Clone the repository and run `chmod +xrw ./install.sh && ./install.sh` then follow the installation process
- You can now run `./start.sh` to run the app.
- A local subscription link will be exposed at `http://127.0.0.1:5574/s/configs`
