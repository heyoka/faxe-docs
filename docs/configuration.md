# Configuration
 

FAXE supports a sysctl like configuration syntax.
Here are the simple rules of the syntax:

+ Everything you need to know about a single setting is on one line
+ Lines are structured Key = Value
+ Any line starting with # is a comment, and will be ignored.

Every config item can be overwritten with OS Environment variables (see 'ENV-Key'). 

```cfg

## Name of the Erlang node
## 
## Default: faxe@127.0.0.1
## 
## ENV-Key: FAXE_NODENAME
## 
## Acceptable values:
##   - text
nodename = faxe@127.0.0.1

## Cookie for distributed node communication.  All nodes in the
## same cluster should use the same cookie or they will not be able to
## communicate.
## 
## Default: distrepl_proc_cookie
## 
## ENV-Key: FAXE_DISTRIBUTED_COOKIE
## 
## Acceptable values:
##   - text
distributed_cookie = distrepl_proc_cookie

## Base directory for mnesia files
## 
## Default: ./mnesia_data
## 
## ENV-Key: FAXE_MNESIA_DIR
## 
## Acceptable values:
##   - the path to a directory
mnesia_dir = ./mnesia_data

## Sets the number of threads in async thread pool, valid range
## is 0-1024. If thread support is available, the default is 64.
## More information at: http://erlang.org/doc/man/erl.html
## 
## Default: 64
## 
## ENV-Key: FAXE_ERLANG_ASYNC_THREADS
## 
## Acceptable values:
##   - an integer
erlang.async_threads = 64

## The number of concurrent ports/sockets
## Valid range is 1024-134217727
## 
## Default: 262144
## 
## ENV-Key: FAXE_ERLANG_MAX_PORTS
## 
## Acceptable values:
##   - an integer
erlang.max_ports = 262144

## --------------------------------------------------------------------------
## Erlangs timewarp and time-correction behaviour
## More info: https://www.erlang.org/doc/apps/erts/time_correction.html#Multi_Time_Warp_Mode
## ------------------------------------------------------------------------------
## What time wrap mode to use for the erlang runtime system
## 
## Default: multi_time_warp
## 
## ENV-Key: FAXE_ERLANG_TIME_WARP_MODE
## 
## Acceptable values:
##   - one of: no_time_warp, single_time_warp, multi_time_warp
## erlang.time.warp_mode = multi_time_warp

## Whether to use time correction
## 
## Default: false
## 
## ENV-Key: FAXE_ERLANG_TIME_CORRECTION
## 
## Acceptable values:
##   - one of: true, false
## erlang.time.correction = false

## --------------------------------------------------------------------------
## Erlangs scheduler busy wait threshold
## More info: https://www.erlang.org/doc/man/erl.html
## ------------------------------------------------------------------------------
## scheduler busy wait threshold
## 
## Default: medium
## 
## ENV-Key: FAXE_ERLANG_BUSY_WAIT_CPU_SCHEDULER
## 
## Acceptable values:
##   - one of: none, very_short, short, medium, long, very_long
## erlang.busy_wait.cpu_scheduler = medium

## 
## Default: short
## 
## ENV-Key: FAXE_ERLANG_BUSY_WAIT_DIRTY_CPU_SCHEDULER
## 
## Acceptable values:
##   - one of: none, very_short, short, medium, long, very_long
## erlang.busy_wait.dirty_cpu_scheduler = short

## 
## Default: short
## 
## ENV-Key: FAXE_ERLANG_BUSY_WAIT_DIRTY_IO_SCHEDULER
## 
## Acceptable values:
##   - one of: none, very_short, short, medium, long, very_long
## erlang.busy_wait.dirty_io_scheduler = short

## --------------------------------------------------------------
## LOGGING
## --------------------------------------------------------------
## set the logging level for console
## 
## Default: info
## 
## ENV-Key: FAXE_LOG_CONSOLE_LEVEL
## 
## Acceptable values:
##   - one of: debug, info, notice, warning, error, alert
## log.console_level = info

## set the log level for the emit backend
## 
## Default: warning
## 
## ENV-Key: FAXE_LOG_EMIT_LEVEL
## 
## Acceptable values:
##   - one of: debug, info, notice, warning, error, alert
## log.emit_level = warning

## whether to send logs to logstash
## logs will be sent via a udp or tcp socket to the configured logstash host
## 
## Default: off
## 
## ENV-Key: FAXE_LOG_LOGSTASH_BACKEND_ENABLE
## 
## Acceptable values:
##   - on or off
log.logstash_backend_enable = off

## whether to send logs to logstash using the udp or tcp protocol
## 
## Default: udp
## 
## ENV-Key: FAXE_LOG_LOGSTASH_BACKEND_PROTOCOL
## 
## Acceptable values:
##   - one of: udp, tcp
## log.logstash_backend_protocol = udp

## enable/disable tls
## enable the use of tls for the logstash handler, if tcp is used
## 
## Default: off
## 
## ENV-Key: FAXE_LOG_LOGSTASH_BACKEND_SSL_ENABLE
## 
## Acceptable values:
##   - on or off
## log.logstash_backend.ssl_enable = off

## logstash host name or address
## 
## Default: 127.0.0.1
## 
## ENV-Key: FAXE_LOG_LOGSTASH_HOST
## 
## Acceptable values:
##   - text
## log.logstash_host = 127.0.0.1

## logstash port
## 
## Default: 9125
## 
## ENV-Key: FAXE_LOG_LOGSTASH_PORT
## 
## Acceptable values:
##   - an integer
## log.logstash_port = 9125

## set the log level for the logstash backend
## 
## Default: info
## 
## ENV-Key: FAXE_LOG_LOGSTASH_LEVEL
## 
## Acceptable values:
##   - one of: debug, info, notice, warning, error, alert
## log.logstash_level = info

## --------------------------------------------------------------
## AUTO START faxe flows (tasks)
## --------------------------------------------------------------
## whether to start tasks marked "permanent" automatically on node startup
## 
## Default: off
## 
## ENV-Key: FAXE_FLOW_AUTO_START
## 
## Acceptable values:
##   - on or off
## flow_auto_start = off

## --------------------------------------------------------------
## AUTO RELOAD faxe flows (tasks)
## --------------------------------------------------------------
## whether to reload all tasks automatically on node startup
## 
## Default: off
## 
## ENV-Key: FAXE_FLOW_AUTO_RELOAD
## 
## Acceptable values:
##   - on or off
## flow_auto_reload = off

## --------------------------------------------------------------
## DFS
## --------------------------------------------------------------
## path to folder where dfs scripts live
## 
## Default: /home/heyoka/workspace/faxe/dfs/
## 
## ENV-Key: FAXE_DFS_SCRIPT_PATH
## 
## Acceptable values:
##   - the path to a directory
## dfs.script_path = /home/heyoka/workspace/faxe/dfs/

## ----------------------------------------------------------------
## API USER - default user, that will be created on first startup
## ----------------------------------------------------------------
## anonymous access to the api endpoint
## set to false for production use
## 
## Default: true
## 
## ENV-Key: FAXE_ALLOW_ANONYMOUS
## 
## Acceptable values:
##   - true or false
allow_anonymous = true

## 
## Default: user
## 
## ENV-Key: FAXE_DEFAULT_USERNAME
## 
## Acceptable values:
##   - text
## default_username = user

## 
## Default: pass
## 
## ENV-Key: FAXE_DEFAULT_PASSWORD
## 
## Acceptable values:
##   - text
## default_password = pass

## 
## Default: false
## 
## ENV-Key: FAXE_RESET_USER_ON_STARTUP
## 
## Acceptable values:
##   - true or false
## reset_user_on_startup = false

## ----------------------------------------------------------------
## API AUTH with JWT
## ----------------------------------------------------------------
## 
## Default: /path/to/cacertfile.pem
## 
## ENV-Key: FAXE_HTTP_API_JWT_PUBLIC_KEY_FILE
## 
## Acceptable values:
##   - the path to a file
## http_api.jwt.public_key_file = /path/to/cacertfile.pem

## ----------------------------------------------------------------
## REST API
## ----------------------------------------------------------------
## http port for rest api endpoint
## 
## Default: 8081
## 
## ENV-Key: FAXE_HTTP_API_PORT
## 
## Acceptable values:
##   - an integer
http_api_port = 8081

## 
## Default: 3000000
## 
## ENV-Key: FAXE_HTTP_API_MAX_UPLOAD_SIZE
## 
## Acceptable values:
##   - an integer
http_api.max_upload_size = 3000000

## http-api tls
## enable the use of tls for the http-api
## 
## Default: off
## 
## ENV-Key: FAXE_HTTP_API_TLS_ENABLE
## 
## Acceptable values:
##   - on or off
## http_api.tls.enable = on

## http-api ssl certificate
## 
## Default: /path/to/certfile.pem
## 
## ENV-Key: FAXE_HTTP_API_SSL_CERTFILE
## 
## Acceptable values:
##   - the path to a file
## http_api.ssl.certfile = /path/to/certfile.pem

## http-api ssl ca certificate
## 
## Default: /path/to/cacertfile.pem
## 
## ENV-Key: FAXE_HTTP_API_SSL_CACERTFILE
## 
## Acceptable values:
##   - the path to a file
## http_api.ssl.cacertfile = /path/to/cacertfile.pem

## http-api ssl key file
## 
## Default: /path/to/keyfile.key
## 
## ENV-Key: FAXE_HTTP_API_SSL_KEYFILE
## 
## Acceptable values:
##   - the path to a file
## http_api.ssl.keyfile = /path/to/cert.key

## a list of ciphers to use for the http listener
## 
## Default: ECDHE-RSA-AES256-GCM-SHA384, ECDHE-RSA-AES128-GCM-SHA256, DHE-RSA-AES256-GCM-SHA384, DHE-RSA-AES128-GCM-SHA256, TLS_AES_256_GCM_SHA384,ECDHE-RSA-AES256-GCM-SHA384
## 
## ENV-Key: FAXE_HTTP_API_CIPHERS
## 
## Acceptable values:
##   - text
## http_api.ciphers = ECDHE-RSA-AES256-GCM-SHA384, ECDHE-RSA-AES128-GCM-SHA256, DHE-RSA-AES256-GCM-SHA384, DHE-RSA-AES128-GCM-SHA256, TLS_AES_256_GCM_SHA384,ECDHE-RSA-AES256-GCM-SHA384

## -----------------------------------------------------------
## PYTHON
## -----------------------------------------------------------------
## python version
## 
## Default: 3
## 
## ENV-Key: FAXE_PYTHON_VERSION
## 
## Acceptable values:
##   - text
## python.version = 3

## path to custom python files
## 
## Default: /home/heyoka/workspace/faxe/python/
## 
## ENV-Key: FAXE_PYTHON_SCRIPT_PATH
## 
## Acceptable values:
##   - the path to a directory
python.script_path = /home/heyoka/workspace/faxe/python/

## -------------------------------------------------------------------
## ESQ
## -------------------------------------------------------------------
## several faxe nodes use persistent queues for safe data-delivery and buffering in
## case any upstream services are disconnected temporarily
## These queues can be configured with the following settings.
## base directory for persistent queues
## 
## Default: /tmp
## 
## ENV-Key: FAXE_QUEUE_BASE_DIR
## 
## Acceptable values:
##   - the path to a directory
queue_base_dir = /tmp

## queue message time to live
## expired messages are evicted from queue
## 
## Default: 4h
## 
## ENV-Key: FAXE_QUEUE_TTL
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
queue_ttl = 4h

## queue sync to disc interval
## queue time-to-sync (rotate) file segments.
## Any enqueued message might remain invisible until sync is performed.
## 
## Default: 300ms
## 
## ENV-Key: FAXE_QUEUE_TTS
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
queue_tts = 300ms

## queue time to flight
## ttf message time-to-flight in milliseconds,
## the time required to deliver message acknowledgment before it reappears to client(s) again.
## 
## Default: 20000ms
## 
## ENV-Key: FAXE_QUEUE_TTF
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
queue_ttf = 20000ms

## capacity defines the size of in-memory queue.
## The queue would not fetch anything from disk into memory buffer if capacity is 0.
## 
## Default: 30
## 
## ENV-Key: FAXE_QUEUE_CAPACITY
## 
## Acceptable values:
##   - an integer
queue_capacity = 30

## dequeue interval.
## Start interval at which the queue is asked for an element.
## 
## Default: 15ms
## 
## ENV-Key: FAXE_DEQUEUE_INTERVAL
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
dequeue_interval = 15ms

## dequeue min interval.
## Min interval at which the queue is asked for an element.
## 
## Default: 3ms
## 
## ENV-Key: FAXE_DEQUEUE_MIN_INTERVAL
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
dequeue.min_interval = 3ms

## dequeue max interval.
## Max interval at which the queue is asked for an element.
## 
## Default: 200ms
## 
## ENV-Key: FAXE_DEQUEUE_MAX_INTERVAL
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
dequeue.max_interval = 200ms

## interval change step size.
## Step size for dequeue interval changes
## 
## Default: 3
## 
## ENV-Key: FAXE_DEQUEUE_STEP_SIZE
## 
## Acceptable values:
##   - an integer
dequeue.step_size = 3

## -------------------------------------------------------------------------
## S7 DEFAULTS
## -------------------------------------------------------------------------
## for every unique ip address used by s7_read nodes,
## faxe will maintain a separate connection pool,
## each pool will have at least 's7pool.min_size' connections
## and a maximum of 's7pool.max_size' connections
## s7 connection pool min size
## 
## Default: 2
## 
## ENV-Key: FAXE_S7POOL_MIN_SIZE
## 
## Acceptable values:
##   - an integer
s7pool.min_size = 2

## s7 connection pool max size
## 
## Default: 16
## 
## ENV-Key: FAXE_S7POOL_MAX_SIZE
## 
## Acceptable values:
##   - an integer
s7pool.max_size = 16

## whether to use the s7 pool (default for all s7read nodes)
## 
## Default: off
## 
## ENV-Key: FAXE_S7POOL_ENABLE
## 
## Acceptable values:
##   - on or off
s7pool.enable = off

## whether to use the optimized s7 reader
## 
## Default: off
## 
## ENV-Key: FAXE_S7READER_OPTIMIZED
## 
## Acceptable values:
##   - on or off
s7reader.optimized = off

## -------------------------------------------------------------------------------
## MQTT defaults
## -------------------------------------------------------------------------------
## 
## Default: on
## 
## ENV-Key: FAXE_MQTT_POOL_ENABLE
## 
## Acceptable values:
##   - on or off
mqtt_pool.enable = on

## max size (maximum number of connections) for the mqtt connection pool
## 
## Default: 30
## 
## ENV-Key: FAXE_MQTT_POOL_MAX_SIZE
## 
## Acceptable values:
##   - an integer
mqtt_pool.max_size = 30

## 
## Default: 10.14.204.20
## 
## ENV-Key: FAXE_MQTT_HOST
## 
## Acceptable values:
##   - text
mqtt.host = 10.14.204.20

## mqtt port
## 
## Default: 1883
## 
## ENV-Key: FAXE_MQTT_PORT
## 
## Acceptable values:
##   - an integer
mqtt.port = 1883

## mqtt user
## 
## Default: username
## 
## ENV-Key: FAXE_MQTT_USER
## 
## Acceptable values:
##   - text
## mqtt.user = username

## mqtt pass
## 
## Default: password
## 
## ENV-Key: FAXE_MQTT_PASS
## 
## Acceptable values:
##   - text
## mqtt.pass = password

## mqtt ssl
## enable the use of ssl for mqtt connections
## 
## Default: off
## 
## ENV-Key: FAXE_MQTT_SSL_ENABLE
## 
## Acceptable values:
##   - on or off
## mqtt.ssl.enable = off

## mqtt ssl peer verification
## 
## Default: verify_none
## 
## ENV-Key: FAXE_MQTT_SSL_VERIFY
## 
## Acceptable values:
##   - one of: verify_none, verify_peer
## mqtt.ssl.verify = verify_none

## mqtt ssl certificate
## 
## Default: 
## 
## ENV-Key: FAXE_MQTT_SSL_CERTFILE
## 
## Acceptable values:
##   - the path to a file
## mqtt.ssl.certfile = /path/to/certfile.pem

## mqtt ssl ca certificate
## 
## Default: 
## 
## ENV-Key: FAXE_MQTT_SSL_CACERTFILE
## 
## Acceptable values:
##   - the path to a file
## mqtt.ssl.cacertfile = /path/to/cacertfile.pem

## mqtt ssl key file
## 
## Default: 
## 
## ENV-Key: FAXE_MQTT_SSL_KEYFILE
## 
## Acceptable values:
##   - the path to a file
## mqtt.ssl.keyfile = /path/to/cert.key

## 
## Default: 2
## 
## ENV-Key: FAXE_MQTT_PUB_POOL_MIN_SIZE
## 
## Acceptable values:
##   - an integer
mqtt_pub_pool.min_size = 2

## mqtt publisher connection pool max size
## 
## Default: 30
## 
## ENV-Key: FAXE_MQTT_PUB_POOL_MAX_SIZE
## 
## Acceptable values:
##   - an integer
mqtt_pub_pool.max_size = 30

## mqtt publisher connection pool max worker rate (message throughput per second)
## this is used for the elastic pool grow/shrink mechanism
## 
## Default: 70
## 
## ENV-Key: FAXE_MQTT_PUB_POOL_WORKER_MAX_RATE
## 
## Acceptable values:
##   - an integer
mqtt_pub_pool.worker_max_rate = 70

## whether to use the s7 pool (default for all s7read nodes)
## 
## Default: on
## 
## ENV-Key: FAXE_MQTT_PUB_POOL_ENABLE
## 
## Acceptable values:
##   - on or off
mqtt_pub_pool.enable = on

## -------------------------------------------------------------------------------
## AMQP defaults
## -------------------------------------------------------------------------------
## amqp host
## 
## Default: 10.14.204.28
## 
## ENV-Key: FAXE_AMQP_HOST
## 
## Acceptable values:
##   - text
amqp.host = 10.14.204.28

## amqp port
## 
## Default: 5672
## 
## ENV-Key: FAXE_AMQP_PORT
## 
## Acceptable values:
##   - an integer
amqp.port = 5672

## amqp user
## 
## Default: guest
## 
## ENV-Key: FAXE_AMQP_USER
## 
## Acceptable values:
##   - text
## amqp.user = username

## amqp pass
## 
## Default: guest
## 
## ENV-Key: FAXE_AMQP_PASS
## 
## Acceptable values:
##   - text
## amqp.pass = password

## amqp heartbeat interval
## 
## Default: 60s
## 
## ENV-Key: FAXE_AMQP_HEARTBEAT
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
## amqp.heartbeat = 60s

## amqp ssl
## enable the use of ssl for amqp connections
## 
## Default: off
## 
## ENV-Key: FAXE_AMQP_SSL_ENABLE
## 
## Acceptable values:
##   - on or off
## amqp.ssl.enable = off

## amqp ssl certificate
## 
## Default: 
## 
## ENV-Key: FAXE_AMQP_SSL_CERTFILE
## 
## Acceptable values:
##   - the path to a file
## amqp.ssl.certfile = /path/to/certfile.pem

## amqp ssl ca certificate
## 
## Default: 
## 
## ENV-Key: FAXE_AMQP_SSL_CACERTFILE
## 
## Acceptable values:
##   - the path to a file
## amqp.ssl.cacertfile = /path/to/cacertfile.pem

## amqp ssl key file
## 
## Default: 
## 
## ENV-Key: FAXE_AMQP_SSL_KEYFILE
## 
## Acceptable values:
##   - the path to a file
## amqp.ssl.keyfile = /path/to/cert.key

## amqp ssl peer verification
## 
## Default: verify_none
## 
## ENV-Key: FAXE_AMQP_SSL_VERIFY
## 
## Acceptable values:
##   - one of: verify_none, verify_peer
## amqp.ssl.verify = verify_none

## -------------------------------------------------------------------------------
## RabbitMQ defaults
## -------------------------------------------------------------------------------
## rabbitmq default exchange
## the amqp_publish node will use this exchange as default
## 
## Default: x_lm_fanout
## 
## ENV-Key: FAXE_RABBITMQ_ROOT_EXCHANGE
## 
## Acceptable values:
##   - text
rabbitmq.root_exchange = x_lm_fanout

## 
## Default: q_
## 
## ENV-Key: FAXE_RABBITMQ_QUEUE_PREFIX
## 
## Acceptable values:
##   - text
rabbitmq.queue_prefix = q_

## 
## Default: x_
## 
## ENV-Key: FAXE_RABBITMQ_EXCHANGE_PREFIX
## 
## Acceptable values:
##   - text
rabbitmq.exchange_prefix = x_

## -------------------------------------------------------------------------------
## CrateDB defaults (postgreSQL connect)
## -------------------------------------------------------------------------------
## CrateDB host
## 
## Default: crate.example.com
## 
## ENV-Key: FAXE_CRATE_HOST
## 
## Acceptable values:
##   - text
crate.host = crate.example.com

## CrateDB port
## 
## Default: 5432
## 
## ENV-Key: FAXE_CRATE_PORT
## 
## Acceptable values:
##   - an integer
crate.port = 5432

## CrateDB user
## 
## Default: crate
## 
## ENV-Key: FAXE_CRATE_USER
## 
## Acceptable values:
##   - text
crate.user = crate

## CrateDB password
## 
## Default: 
## 
## ENV-Key: FAXE_CRATE_PASS
## 
## Acceptable values:
##   - text
## crate.pass = pass

## CrateDB database
## 
## Default: doc
## 
## ENV-Key: FAXE_CRATE_DATABASE
## 
## Acceptable values:
##   - text
crate.database = doc

## crate tls
## enable the use of tls for crate postgre connections
## 
## Default: off
## 
## ENV-Key: FAXE_CRATE_TLS_ENABLE
## 
## Acceptable values:
##   - on or off
## crate.tls.enable = off

## -------------------------------------------------------------------------------
## CrateDB defaults (http api)
## -------------------------------------------------------------------------------
## CrateDB host
## 
## Default: 10.14.204.10
## 
## ENV-Key: FAXE_CRATE_HTTP_HOST
## 
## Acceptable values:
##   - text
crate_http.host = 10.14.204.10

## CrateDB port
## 
## Default: 4200
## 
## ENV-Key: FAXE_CRATE_HTTP_PORT
## 
## Acceptable values:
##   - an integer
crate_http.port = 4200

## CrateDB user
## 
## Default: crate
## 
## ENV-Key: FAXE_CRATE_HTTP_USER
## 
## Acceptable values:
##   - text
crate_http.user = crate

## CrateDB password
## 
## Default: 
## 
## ENV-Key: FAXE_CRATE_HTTP_PASS
## 
## Acceptable values:
##   - text
## crate_http.pass = pass

## CrateDB database
## 
## Default: doc
## 
## ENV-Key: FAXE_CRATE_HTTP_DATABASE
## 
## Acceptable values:
##   - text
crate_http.database = doc

## crate tls
## enable the use of tls for crate http connections
## 
## Default: off
## 
## ENV-Key: FAXE_CRATE_HTTP_TLS_ENABLE
## 
## Acceptable values:
##   - on or off
## crate_http.tls.enable = off

## -------------------------------------------------------------------------------
## InfluxDB defaults (http api)
## -------------------------------------------------------------------------------
## InfluxDB host
## 
## Default: influx.example.com
## 
## ENV-Key: FAXE_INFLUX_HTTP_HOST
## 
## Acceptable values:
##   - text
influx_http.host = influx.example.com

## InfluxDB port
## 
## Default: 8086
## 
## ENV-Key: FAXE_INFLUX_HTTP_PORT
## 
## Acceptable values:
##   - an integer
influx_http.port = 8086

## InfluxDB user
## 
## Default: influx
## 
## ENV-Key: FAXE_INFLUX_HTTP_USER
## 
## Acceptable values:
##   - text
influx_http.user = influx

## InfluxDB pass
## 
## Default: 
## 
## ENV-Key: FAXE_INFLUX_HTTP_PASS
## 
## Acceptable values:
##   - text
## influx_http.pass = password

## ----------------------------------------------------------------------------
## EMAIL defaults
## ----------------------------------------------------------------------------
## email from address
## 
## Default: noreply@example.com
## 
## ENV-Key: FAXE_EMAIL_FROM
## 
## Acceptable values:
##   - text
email.from = noreply@example.com

## email smtp relay
## 
## Default: smtp.example.com
## 
## ENV-Key: FAXE_EMAIL_SMTP
## 
## Acceptable values:
##   - text
email.smtp = smtp.example.com

## email smtp port
## 
## Default: 25
## 
## ENV-Key: FAXE_EMAIL_PORT
## 
## Acceptable values:
##   - an integer
email.port = 25

## email smtp tls, whether to use tls
## 
## Default: off
## 
## ENV-Key: FAXE_EMAIL_TLS
## 
## Acceptable values:
##   - on or off
email.tls = off

## email smtp user
## 
## Default: username
## 
## ENV-Key: FAXE_EMAIL_USER
## 
## Acceptable values:
##   - text
## email.user = username

## email smtp pass
## 
## Default: password
## 
## ENV-Key: FAXE_EMAIL_PASS
## 
## Acceptable values:
##   - text
## email.pass = password

## email html template
## 
## Default: /home/user/template.html
## 
## ENV-Key: FAXE_EMAIL_TEMPLATE
## 
## Acceptable values:
##   - text
email.template = /home/user/template.html

## --------------------------------------------------------------------------
## AZURE BLOB
## -------------------------------------------------------------------------------
## account-url
## 
## Default: https://someblob.blob.core.windows.net
## 
## ENV-Key: FAXE_AZURE_BLOB_ACCOUNT_URL
## 
## Acceptable values:
##   - text
azure_blob.account_url = https://someblob.blob.core.windows.net

## 
## Default: azblob-secret
## 
## ENV-Key: FAXE_AZURE_BLOB_ACCOUNT_SECRET
## 
## Acceptable values:
##   - text
azure_blob.account_secret = azblob-secret

## 
## --------------------------------------------------------------------
## DEBUG, LOGS, METRICS, CONNECTION STATUS, FLOW_CHANGED
## --------------------------------------------------------------------
## There are mqtt handlers for debug, logs, metrics, connection-status and flow_changed events.
## Note that the base options for these mqtt connections come from the 'mqtt' options above.
## If needed you can override these default mqtt-options for every handler type.
## 
## Default: 
## 
## ENV-Key: FAXE_REPORT_DEBUG_MQTT_HOST
## 
## Acceptable values:
##   - text
## report_debug.mqtt_host = example.com

## 
## ----------------------- METRICS ------------------------------
## Metrics handler MQTT sends metric events to an mqtt broker
## 
## Default: off
## 
## ENV-Key: FAXE_METRICS_HANDLER_MQTT_ENABLE
## 
## Acceptable values:
##   - on or off
metrics.handler.mqtt.enable = off

## metrics handler mqtt host
## 
## Default: 
## 
## ENV-Key: FAXE_METRICS_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
## metrics.handler.mqtt.host = example.com

## metrics handler mqtt port
## 
## ENV-Key: FAXE_METRICS_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
## metrics.handler.mqtt.port = 1883

## metrics handler mqtt base topic
## The mqtt handler will prefix its topic with this value,
## note that it must be a valid mqtt topic string.
## 
## Default: sys/faxe
## 
## ENV-Key: FAXE_METRICS_HANDLER_MQTT_BASE_TOPIC
## 
## Acceptable values:
##   - text
## metrics.handler.mqtt.base_topic = sys/faxe

## flow-metrics publish interval
## Interval at which flow-metrics get publish to the handler
## 
## Default: 30s
## 
## ENV-Key: FAXE_METRICS_PUBLISH_INTERVAL
## 
## Acceptable values:
##   - text
metrics.publish_interval = 30s

## ----------------------- CONNECTION STATUS ------------------------
## Conn_status handler MQTT sends connection status events to an mqtt broker.
## 
## Default: on
## 
## ENV-Key: FAXE_CONN_STATUS_HANDLER_MQTT_ENABLE
## 
## Acceptable values:
##   - on or off
conn_status.handler.mqtt.enable = on

## 
## Default: 
## 
## ENV-Key: FAXE_CONN_STATUS_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
## conn_status.handler.mqtt.host = example.com

## connection status handler mqtt port
## 
## ENV-Key: FAXE_CONN_STATUS_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
## conn_status.handler.mqtt.port = 1883

## connection status handler mqtt base topic
## 
## Default: sys/faxe
## 
## ENV-Key: FAXE_CONN_STATUS_HANDLER_MQTT_BASE_TOPIC
## 
## Acceptable values:
##   - text
## conn_status.handler.mqtt.base_topic = sys/faxe

## ----------------------- DEBUG AND TRACE --------------------------
## Debug trace handler MQTT
## enable/disable debug_trace handler mqtt
## 
## Default: off
## 
## ENV-Key: FAXE_DEBUG_HANDLER_MQTT_ENABLE
## 
## Acceptable values:
##   - on or off
debug.handler.mqtt.enable = off

## debug_trace handler mqtt host
## 
## Default: 
## 
## ENV-Key: FAXE_DEBUG_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
## debug.handler.mqtt.host = example.com

## debug_trace handler mqtt port
## 
## ENV-Key: FAXE_DEBUG_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
## debug.handler.mqtt.port = 1883

## debug_trace handler mqtt base topic
## 
## Default: sys/faxe
## 
## ENV-Key: FAXE_DEBUG_HANDLER_MQTT_BASE_TOPIC
## 
## Acceptable values:
##   - text
## debug.handler.mqtt.base_topic = sys/faxe

## time debug and node-metric messages will be published to the configured endpoints
## 
## Default: 3m
## 
## ENV-Key: FAXE_DEBUG_TIME
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
debug.time = 3m

## ----------------------- FLOW_CHANGED --------------------------
## flow_changed handler MQTT
## enable/disable flow_changed handler mqtt
## 
## Default: off
## 
## ENV-Key: FAXE_FLOW_CHANGED_HANDLER_MQTT_ENABLE
## 
## Acceptable values:
##   - on or off
flow_changed.handler.mqtt.enable = off

## flow_changed handler mqtt host
## 
## Default: 
## 
## ENV-Key: FAXE_FLOW_CHANGED_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
## flow_changed.handler.mqtt.host = example.com

## flow_changed handler mqtt port
## 
## ENV-Key: FAXE_FLOW_CHANGED_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
## flow_changed.handler.mqtt.port = 1883

## flow_changed handler mqtt base topic
## 
## Default: sys/faxe
## 
## ENV-Key: FAXE_FLOW_CHANGED_HANDLER_MQTT_BASE_TOPIC
## 
## Acceptable values:
##   - text
## flow_changed.handler.mqtt.base_topic = sys/faxe





```
 