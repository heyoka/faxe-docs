## Modbus to MQTT

In this example we write a simple DFS which reads energy data from a modbus-tcp device periodically and
publishes to an mqtt broker.
```dfs  
def device_id = 255
def modbus_ip = '127.0.0.1'
def mqtt_broker = '10.14.204.3'

|modbus()
.ip('127.0.0.1')
%% not the default port here
.port(8899)
.device(device_id)
%% we read the values every second
.every(1s)

%% we read 3 values 
.function('coils', 'hregs', 'iregs')
%% start addresses
.from(2127, 3008, 104)
%% amount of data for each value
.count(1, 2, 2)
%% we want these resulting fieldnames
.as('ActiveEnergyConsumption', 'MaximalCurrentValue', 'BlindEnergyDelivered') 

%% add some default values to each message

|default()
.fields('id', 'vs', 'df')
.field_values('my_id_string', 1, '01.010')

%% publish to mqtt broker

|mqtt_publish()
.host(mqtt_broker)
.port(1883)
.qos(1)
.topic('ttopic/energy')
.retained()
```