The value_emitter node
=====================

This node is for debugging purposes.

It periodically emits random values.

Example
-------

```dfs  

|value_emitter()
.every(1s)
.type(point)
```
 
Emit a data_point with a random value in field val every second.

Parameters
----------

| Parameter               | Description                                 | Default         |
|-------------------------|---------------------------------------------|-----------------|
| every( `duration` )     | emit interval                               | 5s              |
| jitter( `duration` )    | add time jitter to the values produced      | 0ms             |
| type( `atom` )          | emit point or batch                         | batch           |
| fields( `string_list` ) | what fields to emit                         | ['val']         |
| format( `atom` )        | the format of the fields emitted flat/ejson | flat            |
| align( is_set )         | align the time to the every param           | false (not set) |
