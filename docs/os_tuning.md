## Tune OS Limits

### Number of file desciptors

https://www.rabbitmq.com/install-debian.html#kernel-resource-limits

https://github.com/basho/basho_docs/blob/master/content/riak/kv/2.2.3/using/performance/open-files-limit.md#debian--ubuntu

https://docs.riak.com/riak/kv/2.2.3/using/performance/open-files-limit/#debian-ubuntu

#### For current session

```
$ ulimit -n 100000
```

#### Permanent settings

Linux: In /etc/security/limit.conf set these two lines:

```
* soft nofile 65536
* hard nofile 100000
```

##### Docker
https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-configuration-file


##### erlang

Q flag is used in vm.args

`+Q Number `


##### check actual number used

```
erlang:system_info(port_limit).
```