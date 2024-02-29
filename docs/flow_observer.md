# Flow observer
 

A flow observer process - one per flow - keeps track and reports connection problems and other errors that a flow
may have.
The only report backend at the moment is a configurable mqtt broker.

> mqtt topic : 

## config

```cfg


## ----------------------- FLOW HEALTH STATUS (observer) --------------------------
## enable/disable flow health observer process
## 
## Default: on
## 
## ENV-Key: FAXE_FLOW_HEALTH_OBSERVER_ENABLE
## 
## Acceptable values:
##   - on or off
flow_health.observer.enable = on

## 
## Default: 3m
## 
## ENV-Key: FAXE_FLOW_HEALTH_OBSERVER_REPORT_INTERVAL
## 
## Acceptable values:
##   - a time duration with units, e.g. '10s' for 10 seconds
flow_health.observer.report_interval = 3m

## 
## Default: on
## 
## ENV-Key: FAXE_FLOW_HEALTH_HANDLER_MQTT_ENABLE
## 
## Acceptable values:
##   - on or off
flow_health.handler.mqtt.enable = on

## flow_health handler mqtt host
## 
## Default: 
## 
## ENV-Key: FAXE_FLOW_HEALTH_HANDLER_MQTT_HOST
## 
## Acceptable values:
##   - text
## flow_health.handler.mqtt.host = example.com

## flow_health handler mqtt port
## 
## ENV-Key: FAXE_FLOW_HEALTH_HANDLER_MQTT_PORT
## 
## Acceptable values:
##   - an integer
## flow_health.handler.mqtt.port = 1883



```
 