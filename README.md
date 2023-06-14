# server-init

Repo for server deploy preparation

Run with

Setup Server

```shell
curl -s -o setup.sh https://raw.githubusercontent.com/ppulwey/server-init/main/init.sh && chmod +x setup.sh && sudo ./setup.sh
```

Add domain

```shell
curl -s -o addDomain.sh https://raw.githubusercontent.com/ppulwey/server-init/main/addDomain.sh && chmod +x addDomain.sh && sudo ./addDomain.sh
```

Add test
```shell
curl -s -o test.sh https://raw.githubusercontent.com/ppulwey/server-init/main/test.sh && chmod +x test.sh && sudo ./test.sh
```

Remove
```shell
rm addDomain.sh test.sh setup.sh /etc/nginx/sites-available/testserver.meeploy.com /etc/nginx/sites-enabled/testserver.meeploy.com /var/meeploy/pm2.config.json
rm -rf /var/meeploy/apps/testserver/


```
