The modbus node
=====================

Read data from a modbus slave device via **modbus tcp**, supported read functions are :
['coils', 'hregs', 'iregs', 'inputs', 'memory']

Reading can be done periodically (if `every` is given) and/or via a trigger (incoming value).

Read multiple values with possibly different functions at once.

The node will optimize reading by treating contiguous values as one reading var. 

If the `align` property is set to true (default), the nodes's read times will be truncated to the every property
(For example, if the node is started at 12:06 and the every property is 5m then the next read will 
occur at 12:10, then the next at 12:15 and so on, instead of 12:06, 12:11 and so on).



Examples
-------
```dfs  

|modbus()
.ip('127.0.0.1') 
.device(255)
.every(1s)
.function('coils', 'hregs', 'iregs', 'hregs')
.from(2127, 3008, 104, 30306)
.count(1, 2, 2, 4)
.as('data.EnergyConsumption', 'data.CurrentValue', 'data.EnergyDelivered')
.output('int16', 'float32', 'float32', 'double')
.signed(true, true, false, false) 
```


```dfs  

|modbus()
.ip('127.0.0.1')  
.every(2m)
.function('hregs', 'hregs', 'hregs')
.from(2127, 2125, 104)
.count(2, 2, 2)
.as('data.EnergyConsumption', 'data.CurrentValue', 'data.EnergyDelivered')
.output('float32', 'float32', 'float32') 
``` 


Parameters
----------

| Parameter                       | Description                                                                                                                                    | Default                 |
|---------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|
| ip( `string` )                  | ip address of modbus device                                                                                                                    |                         |
| port( `integer` )               | port of modbus device                                                                                                                          | 502                     |
| every( `duration` )             | time between reads                                                                                                                             | undefined               |
| align( `boolean` )              | align read intervals according to every                                                                                                        | true                    |
| device( `integer` )             | modbus device id (0-255)                                                                                                                       | 255                     |
| function( `string_list` )       | list of read functions, one of `['coils', 'hregs', 'iregs', 'inputs', 'memory']`                                                               |                         |
| from( `integer_list` )          | list of start values                                                                                                                           |                         |
| count( `integer_list`)          | list of count values, how much data to read for every function given                                                                           |                         |
| as( `string_list` )             | output names for the read values                                                                                                               |                         |
| output( `string_list` )         | list of output formats one of `['int16', 'int32', 'float32', 'double', 'coils', 'ascii', 'binary']`                                            | undefined               |
| signed( `atom_list` true/false) | list of values indicating if values are signed                                                                                                 | undefined               |
| round( `integer` )              | Round all `float32` and `double` values with the given precision. If a value has less than the given decimal places, it will be left untouched | undefined (no rounding) |

Note that, if given, all read parameters(`function, from, count, as, output, signed`) must have the same length, this means if you have two
values you want to read :
```dfs
.function('coils', 'hregs')` 
```

all corresponding read params (if given) must have the same length:


```dfs

.as('val1', 'val2')
.output(int16, float32)
.from(1,2) 
.count(2,4)
.signed(true, true)

```
