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



```dfs
%% enum mappings
def alarm_state_map = '{"NOAL":0,"ERR":1}'
def opmode_map = '{"NOMO":0,"AUTO":1,"MANU":2}'
def opstate_map = '{"ON":0,"OFF":1}'
def order_state_map = '{"RDY":0,"NRDY":1,"OFF":2}'

def topic_out = 'ttgw/data/grip/rovolutionmarchtrenk/condition/robot_state'

def republish_timeout = 15s
def topic_in = 'tgw/data/marchtrenk/rovolutionmarchtrenk/pcr/grip/wms/RMST/v1'

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
    lambda: map_get("data.alarm_state.name", ls_mem('alarm_state')),
    lambda: map_get("data.operating_mode.name", ls_mem('opmode')),
    lambda: map_get("data.operating_state.name", ls_mem('opstate')),
    lambda: map_get("data.order_state.name", ls_mem('order_state'))
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
%%%%%%%%%%%%%%%%%%%%% enum lookup tables %%%%%%%%%%
def barrier = true
|mem()
.key('alarm_state')
.default(alarm_state_map)
.default_json()
|mem()
.key('opmode')
.default(opmode_map)
.default_json()
|mem()
.key('opstate')
.default(opstate_map)
.default_json()
|mem()
.key('order_state')
.default(order_state_map)
.default_json()
```