docker-node-base
================

docker node base image


#### `node-base /with ssh-agent`

```
docker run --rm -i -t \
    -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent \
    -e SSH_AUTH_SOCK=/ssh-agent \
    hlobil/node-base /bin/bash
```

#### `tagging`

    git tag -a 0.11.14 -m 'node v0.11.14'
    git push origin --tags


#### `reference`

https://github.com/heroku/heroku-buildpack-nodejs
