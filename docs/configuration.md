# Configuration


TBD


FAXE supports a sysctl like configuration syntax.
Here are the simple rules of the syntax:

+ Everything you need to know about a single setting is on one line
+ Lines are structured Key = Value
+ Any line starting with # is a comment, and will be ignored.

```cfg

## Name of the Erlang node
## 
## Default: faxe1
## 
## ENV-Key: FAXE_NODENAME
## 
## Acceptable values:
##   - text
nodename = faxe1

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
##   - text
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

## Set scheduler forced wakeup interval. All run queues will be
## scanned each Interval milliseconds. While there are sleeping
## schedulers in the system, one scheduler will be woken for each
## non-empty run queue found. An Interval of zero disables this
## feature, which also is the default.
## This feature is a workaround for lengthy executing native code, and
## native code that do not bump reductions properly.
## More information: http://www.erlang.org/doc/man/erl.html#+sfwi
## 
## ENV-Key: FAXE_ERLANG_SCHEDULERS_FORCE_WAKEUP_INTERVAL
## 
## Acceptable values:
##   - an integer
## erlang.schedulers.force_wakeup_interval = 500

## Enable or disable scheduler compaction of load. By default
## scheduler compaction of load is enabled. When enabled, load
## balancing will strive for a load distribution which causes as many
## scheduler threads as possible to be fully loaded (i.e., not run out
## of work). This is accomplished by migrating load (e.g. runnable
## processes) into a smaller set of schedulers when schedulers
## frequently run out of work. When disabled, the frequency with which
## schedulers run out of work will not be taken into account by the
## load balancing logic.
## More information: http://www.erlang.org/doc/man/erl.html#+scl
## 
## ENV-Key: FAXE_ERLANG_SCHEDULERS_COMPACTION_OF_LOAD
## 
## Acceptable values:
##   - one of: true, false
## erlang.schedulers.compaction_of_load = false

## Enable or disable scheduler utilization balancing of load. By
## default scheduler utilization balancing is disabled and instead
## scheduler compaction of load is enabled which will strive for a
## load distribution which causes as many scheduler threads as
## possible to be fully loaded (i.e., not run out of work). When
## scheduler utilization balancing is enabled the system will instead
## try to balance scheduler utilization between schedulers. That is,
## strive for equal scheduler utilization on all schedulers.
## More information: http://www.erlang.org/doc/man/erl.html#+sub
## 
## ENV-Key: FAXE_ERLANG_SCHEDULERS_UTILIZATION_BALANCING
## 
## Acceptable values:
##   - one of: true, false
## erlang.schedulers.utilization_balancing = true

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

## -----------------------------------------------------------------
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
## Default: /path/to/python/
## 
## ENV-Key: FAXE_PYTHON_SCRIPT_PATH
## 
## Acceptable values:
##   - the path to a directory
python.script_path = /path/to/python/

## -------------------------------------------------------------------
## ESQ
## -------------------------------------------------------------------
## base directory for persistent queues
## out must be a binary
## 
## Default: /tmp/
## 
## ENV-Key: FAXE_QUEUE_BASE_DIR
## 
## Acceptable values:
##   - the path to a directory
queue_base_dir = /tmp/

## 
## --------------------------------------------------------------------
## DEBUG, LOGS, METRICS, CONNECTION STATUS
## --------------------------------------------------------------------
## ----------------------- METRICS ------------------------------
## Metrics handler MQTT
## 
## Default: example.com
## 
## ENV-Key: FAXE_METRICS_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
metrics.handler.mqtt.host = example.com

## metrics handler mqtt port
## 
## Default: 1883
## 
## ENV-Key: FAXE_METRICS_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
metrics.handler.mqtt.port = 1883

## metrics handler mqtt base topic
## 
## Default: ttgw/sys/faxe
## 
## ENV-Key: FAXE_METRICS_HANDLER_MQTT_BASE_TOPIC
## 
## Acceptable values:
##   - text
metrics.handler.mqtt.base_topic = ttgw/sys/faxe

## ----------------------- CONNECTION STATUS ------------------------
## Conn_status handler MQTT
## connection status handler mqtt host
## 
## Default: example.com
## 
## ENV-Key: FAXE_CONN_STATUS_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
conn_status.handler.mqtt.host = example.com

## connection status handler mqtt port
## 
## Default: 1883
## 
## ENV-Key: FAXE_CONN_STATUS_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
conn_status.handler.mqtt.port = 1883

## connection status handler mqtt base topic
## 
## Default: ttgw/sys/faxe
## 
## ENV-Key: FAXE_CONN_STATUS_HANDLER_MQTT_BASE_TOPIC
## 
## Acceptable values:
##   - text
conn_status.handler.mqtt.base_topic = ttgw/sys/faxe

## ----------------------- DEBUG AND TRACE --------------------------
## Debug trace handler MQTT
## 
## Default: example.com
## 
## ENV-Key: FAXE_DEBUG_TRACE_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
debug_trace.handler.mqtt.host = example.com

## debug_trace handler mqtt port
## 
## Default: 1883
## 
## ENV-Key: FAXE_DEBUG_TRACE_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
debug_trace.handler.mqtt.port = 1883

## debug_trace handler mqtt base topic
## 
## Default: ttgw/sys/faxe
## 
## ENV-Key: FAXE_DEBUG_TRACE_HANDLER_MQTT_BASE_TOPIC
## 
## Acceptable values:
##   - text
debug_trace.handler.mqtt.base_topic = ttgw/sys/faxe

## time debug messages will be published to the configured endpoints
## 
## Default: 10s
## 
## ENV-Key: FAXE_DEBUG_TIME
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
debug.time = 10s

## -------------------------------------------------------------------------
## S7 DEFAULTS
## -------------------------------------------------------------------------
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

## email smtp user
## 
## Default: 
## 
## ENV-Key: FAXE_EMAIL_USER
## 
## Acceptable values:
##   - text
## email.user = username

## email smtp pass
## 
## Default: 
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

## -------------------------------------------------------------------------------
## MQTT defaults
## -------------------------------------------------------------------------------
## mqtt host
## 
## Default: mqtt.example.com
## 
## ENV-Key: FAXE_MQTT_HOST
## 
## Acceptable values:
##   - text
mqtt.host = mqtt.example.com

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
## Default: 
## 
## ENV-Key: FAXE_MQTT_USER
## 
## Acceptable values:
##   - text
## mqtt.user = username

## mqtt pass
## 
## Default: 
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
## Default: /path/to/certfile.pem
## 
## ENV-Key: FAXE_MQTT_SSL_CERTFILE
## 
## Acceptable values:
##   - text
## mqtt.ssl.certfile = /path/to/certfile.pem

## mqtt ssl ca certificate
## 
## Default: /path/to/cacertfile.pem
## 
## ENV-Key: FAXE_MQTT_SSL_CACERTFILE
## 
## Acceptable values:
##   - text
## mqtt.ssl.cacertfile = /path/to/cacertfile.pem

## mqtt ssl key file
## 
## Default: /path/to/cert.key
## 
## ENV-Key: FAXE_MQTT_SSL_KEYFILE
## 
## Acceptable values:
##   - text
## mqtt.ssl.keyfile = /path/to/cert.key

## -------------------------------------------------------------------------------
## AMQP defaults
## -------------------------------------------------------------------------------
## amqp host
## 
## Default: amqp.example.com
## 
## ENV-Key: FAXE_AMQP_HOST
## 
## Acceptable values:
##   - text
amqp.host = amqp.example.com

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
## Default: 
## 
## ENV-Key: FAXE_AMQP_USER
## 
## Acceptable values:
##   - text
## amqp.user = username

## amqp pass
## 
## Default: 
## 
## ENV-Key: FAXE_AMQP_PASS
## 
## Acceptable values:
##   - text
## amqp.pass = password

## amqp ssl
## enable the use of ssl for mqtt connections
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
##   - text
## amqp.ssl.certfile = /path/to/certfile.pem

## amqp ssl ca certificate
## 
## Default: 
## 
## ENV-Key: FAXE_AMQP_SSL_CACERTFILE
## 
## Acceptable values:
##   - text
## amqp.ssl.cacertfile = /path/to/cacertfile.pem

## amqp ssl key file
## 
## Default: 
## 
## ENV-Key: FAXE_AMQP_SSL_KEYFILE
## 
## Acceptable values:
##   - text
## amqp.ssl.keyfile = /path/to/cert.key

## -------------------------------------------------------------------------------
## RabbitMQ defaults
## -------------------------------------------------------------------------------
## rabbitmq default exchange
## the amqp_publish node will use this exchange as default
## 
## Default: x_root
## 
## ENV-Key: FAXE_RABBITMQ_ROOT_EXCHANGE
## 
## Acceptable values:
##   - text
rabbitmq.root_exchange = x_root

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
## Default: crate.example.com
## 
## ENV-Key: FAXE_CRATE_HTTP_HOST
## 
## Acceptable values:
##   - text
crate_http.host = crate.example.com

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
## Logging
## -------------------------------------------------------------------------------
## Lager colored
## 
## Default: true
## 
## ENV-Key: FAXE_LAGER_COLORED
## 
## Acceptable values:
##   - one of: true, false
lager.colored = true

## 
## Default: true
## 
## ENV-Key: FAXE_LAGER_ERROR_LOGGER_REDIRECT
## 
## Acceptable values:
##   - one of: true, false
lager.error_logger_redirect = true



```
 