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
## Default: faxe_dev1
## 
## ENV-Key: FAXE_NODENAME
## 
## Acceptable values:
##   - text
nodename = faxe_dev1

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

## --------------------------------------------------------------
## AUTO START faxe flows (tasks)
## --------------------------------------------------------------
## whether to start tasks marked "permanent" automatically on node startup
## 
## Default: on
## 
## ENV-Key: FAXE_FLOW_AUTO_START
## 
## Acceptable values:
##   - on or off
## flow_auto_start = on

## --------------------------------------------------------------
## DFS
## --------------------------------------------------------------
## path to folder where dfs scripts live
## 
## Default: /home/user/faxe/dfs/
## 
## ENV-Key: FAXE_DFS_SCRIPT_PATH
## 
## Acceptable values:
##   - the path to a directory
## dfs.script_path = /home/user/faxe/dfs/

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

## http-api tls
## enable the use of tls for the http-api
## 
## Default: on
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
## Default: /home/user/python/
## 
## ENV-Key: FAXE_PYTHON_SCRIPT_PATH
## 
## Acceptable values:
##   - the path to a directory
python.script_path = /home/user/python/

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

## -------------------------------------------------------------------------------
## MQTT defaults
## -------------------------------------------------------------------------------
## mqtt host
## 
## Default: 127.0.0.1
## 
## ENV-Key: FAXE_MQTT_HOST
## 
## Acceptable values:
##   - text
mqtt.host = 127.0.0.1

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
## ENV-Key: FAXE_MQTT_USER
## 
## Acceptable values:
##   - text
## mqtt.user = username

## mqtt pass
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

## mqtt ssl certificate
## 
## ENV-Key: FAXE_MQTT_SSL_CERTFILE
## 
## Acceptable values:
##   - the path to a file
## mqtt.ssl.certfile = /path/to/certfile.pem

## mqtt ssl ca certificate
## 
## ENV-Key: FAXE_MQTT_SSL_CACERTFILE
## 
## Acceptable values:
##   - the path to a file
## mqtt.ssl.cacertfile = /path/to/cacertfile.pem

## mqtt ssl key file
## 
## ENV-Key: FAXE_MQTT_SSL_KEYFILE
## 
## Acceptable values:
##   - the path to a file
## mqtt.ssl.keyfile = /path/to/cert.key

## -------------------------------------------------------------------------------
## AMQP defaults
## -------------------------------------------------------------------------------
## amqp host
## 
## Default: 127.0.0.1
## 
## ENV-Key: FAXE_AMQP_HOST
## 
## Acceptable values:
##   - text
amqp.host = 127.0.0.1

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
## ENV-Key: FAXE_AMQP_SSL_CERTFILE
## 
## Acceptable values:
##   - the path to a file
## amqp.ssl.certfile = /path/to/certfile.pem

## amqp ssl ca certificate
## 
## ENV-Key: FAXE_AMQP_SSL_CACERTFILE
## 
## Acceptable values:
##   - the path to a file
## amqp.ssl.cacertfile = /path/to/cacertfile.pem

## amqp ssl key file
## 
## ENV-Key: FAXE_AMQP_SSL_KEYFILE
## 
## Acceptable values:
##   - the path to a file
## amqp.ssl.keyfile = /path/to/cert.key

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

## -------------------------------------------------------------------------------
## CrateDB defaults (http api)
## -------------------------------------------------------------------------------
## CrateDB host
## 
## Default: 127.0.0.1
## 
## ENV-Key: FAXE_CRATE_HTTP_HOST
## 
## Acceptable values:
##   - text
crate_http.host = 10.1.1.2

## CrateDB port
## 
## Default: 4201
## 
## ENV-Key: FAXE_CRATE_HTTP_PORT
## 
## Acceptable values:
##   - an integer
crate_http.port = 4201

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

## 
## --------------------------------------------------------------------
## DEBUG, LOGS, METRICS, CONNECTION STATUS
## --------------------------------------------------------------------
## There are mqtt handlers for debug, logs, metrics and connection-status events.
## Note that the base options for these mqtt connections come from the 'mqtt' options above.
## If needed you can override these default mqtt-options for every handler type.
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
## metrics.handler.mqtt.base_topic = /base/topic

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
## conn_status.handler.mqtt.base_topic = /base/topic

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
## debug.handler.mqtt.base_topic = base/topic

## time debug messages will be published to the configured endpoints
## 
## Default: 25s
## 
## ENV-Key: FAXE_DEBUG_TIME
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
debug.time = 25s






```
 