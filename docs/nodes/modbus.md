The modbus node
=====================

Pull data via modbus tcp, supported read functions are :
['coils', 'hregs', 'iregs', 'inputs', 'memory']


Read multiple values with possibly different functions at once

If the `align` property is set, the nodes's read times will be truncated to the every property
(For example, if the node is started at 12:06 and the every property is 5m then the next read will 
occur at 12:10, then the next at 12:15 and so on, instead of 12:06, 12:11 and so on).


Example
-------
```dfs  

|modbus()
.ip('127.0.0.1') 
.device(255)
.every(1s)
.function('coils', 'hregs', 'iregs')
.from(2127, 3008, 104)
.count(1, 2, 2)
.as('Energy.EnergyConsumption', 'Energy.CurrentValue', 'Energy.EnergyDelivered')
.output('int16', 'float32', 'float32')
.signed(true, true, false) 
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
ip( `string` )| ip address of modbus device |
port( `integer` )| port of modbus device|502
every( `duration` )|time between reads|1s
align( is_set )|align read intervals according to every|false (not set)
device( `integer` )|modbus device id (0-255)|255
function( `string_list` )|list of read functions, one of `['coils', 'hregs', 'iregs', 'inputs', 'memory']`|
from( `integer_list` )|list of start values|
count( `integer_list`)|list of count values, how much data to read for every function given|
as( `string_list` )|output names for the read values|
output( `string_list` )|list of output formats one of `['int16', 'int32', 'float32', 'coils', 'ascii', 'binary']`|undefined
signed( `atom_list` true/false)|list of values indicating if values are signed|undefined


Note that, if given, all read parameters(`function, from, count, as, output, signed`) must have the same length, this means if you have two
values you want to read -> .function('coils', 'hregs') all corresponding read params must have the same length
-> .as('val1', 'val2').output(int16, float32).from(1,2).count(2,4).signed(true, true)
