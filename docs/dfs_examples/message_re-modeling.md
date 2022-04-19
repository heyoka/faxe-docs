This example uses different faxe [nodes](../nodes/index.md) to remodel and extend a json message that is received via mqtt.

### Input message

```json
{
  "ts": 1634657531710,
  "data": {
    "availablitiy": "NRDY",
    "operatingState": "ON",
    "operatingMode": "AUTO",
    "alarmState": "NOAL",
    "errorStates": [],
    "Typ": "ATS",
    "Id": 3179
  }
}

```

### Desired message 

```json
{
  "ts": 1634657531710,
  "data": {
    "robot_state": "BUSY",
    "order_state": {
      "name": "NRDY",
      "id": 1
    },
    "operating_state": {
      "name": "ON",
      "id": 0
    },
    "operating_mode": {
      "name": "AUTO",
      "id": 1
    },
    "alarm_state": {
      "name": "NOAL",
      "id": 0,
      "errors": []
    },
    "Typ": "ATS",
    "Id": 3179
  }
}

```

##Example

```dfs
%% enum mappings
def alarm_state_map = '{"NOAL":0,"ERR":1}'
def opmode_map = '{"NOMO":0,"AUTO":1,"MANU":2}'
def opstate_map = '{"ON":0,"OFF":1}'
def order_state_map = '{"RDY":0,"NRDY":1,"OFF":2}'

def topic_out = 'msm/r1/grp/condition/robot_state'

def republish_timeout = 15s
def topic_in = 'msm/r1/grp/wms/RMST/v1'

def out =
|mqtt_subscribe()
    .host('10.10.1.102')
    .topic(topic_in)
    .include_topic(false) 

|rename()
.fields(
    'data.alarmState',
    'data.operatingMode',
    'data.operatingState',
    'data.errorStates',
    'data.availablitiy'
)
.as_fields(
    'data.alarm_state.name',
    'data.operating_mode.name',
    'data.operating_state.name',
    'data.alarm_state.errors',
    'data.order_state.name'
)

|eval(
    lambda: map_get("data.alarm_state.name", alarm_state_map),
    lambda: map_get("data.operating_mode.name", opmode_map),
    lambda: map_get("data.operating_state.name", opstate_map),
    lambda: map_get("data.order_state.name", order_state_map)
)
.as(
    'data.alarm_state.id',
    'data.operating_mode.id',
    'data.operating_state.id',
    'data.order_state.id'
)

|case(
    lambda: "data.alarm_state.name" == 'ERR',
    lambda: "data.operating_state.name" == 'ON' AND "data.operating_mode.name" == 'AUTO' AND "data.order_state.name" == 'NRDY',
    lambda: "data.operating_state.name" == 'ON' AND "data.operating_mode.name" == 'AUTO' AND "data.order_state.name" == 'IDLE'
)
.values(
    'ERROR',
    'BUSY',
    'IDLE'
)
.default('OFF')
.as('data.robot_state')
 
out
|mqtt_publish()
.topic(topic_out) 
```