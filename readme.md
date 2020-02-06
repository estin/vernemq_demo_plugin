# VerneMQ Demo Plugin

| WARNING: This is a ugly approach to pass api key from environment variable |
| --- |

This plugin demonstrates how to use plugin system to set up admin api key from environment variable. 

Compile plugin
```bash
rebar3 compile
```

Configure environment variables in [docker-compose.yaml]
```bash
docker-compose up
```

In output you will see
```bash
...
vernemq_1  | 17:41:17.706 [info] api keys before: []
vernemq_1  | 17:41:17.707 [info] api keys after: [<<"myapikey">>]
```

Check api key
```bash
$ curl "http://myapikey@localhost:8888/api/v1/cluster/show"
{"table":[{"Node":"VerneMQ@172.25.0.2","Running":true}],"type":"table"}
```
