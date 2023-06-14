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


sshkey
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
