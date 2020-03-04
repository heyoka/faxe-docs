The combine node
=====================

Combine the values of 2 nodes, use to enrich data from one node.

Port 1 is the trigger port. 
Every time a value is received on the trigger port, the node will emit a value, combined with whatever current value on port 2.
The node will never emit on port 2 values.

No output is given, as long as there has not arrived a value on port 2 to combine with.

The `fields` parameter defines the fields to inject into the combination for the stream on port 2.
To rename these fields, parameter `prefix` or `aliases` can be used.
With `prefix_delimiter` a delimiter can be given, defaults to: `'_'`

Example
-------
```dfs  
 def in1 =
  |value_emitter()
  .every(500ms)
  .type(point)
  .fields('val')
 
 def in2 =
  |value_emitter()
  .every(4s)
  .type(point)
  .fields('val2', 'val3') 
 
 in1
  |combine(in2)
  .fields('val2', 'val3')
  .prefix('comb')
  .prefix_delimiter('_')
```

In this example values from the stream called `in1` will be enriched with values from `in2`.
Outputfields will be called: `val`, `comb_val2` and `comb_val3` .
The flow will emit every 500 milliseconds after 4 seconds have past initially.
 


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
[node] (`port`)| input node for port 2 |
fields( `string_list` )| List of fields to include| []
tags( `string_list` )| List of tags to include | []
aliases( `string_list` )| List of field aliases to use instead of the original field names| []
prefix( `string` )|Prefix for the injected fields from stream 2| undefined
prefix_delimiter( `string` )|Used to separate prefix and the original field name from stream 2|'_'

Either `prefix` or `aliases` must be given these are mutually exclusive parameters. If both are given, then `prefix` will win.
  