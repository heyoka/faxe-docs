The collect_fields node
=====================

_`Experimental`_ since vs. 1.0.13

A very simple version of the collect node.

From every incoming data-point collect the fields given, potentially overriding the value seen before for any field.
The node will keep the value for a field, when an incoming data-point does not have this field present.

If `default` is given, every field that has not been seen yet, will have the default value.
That means, that, if a default value is given, the output will always include every field from the given list.
Otherwise, if default is not given, every field not seen, will not be present in the output data-point.

_timestamp_, _delivery_tag_ and all _tags_ from the current incoming data-point will be used for the output data-point.
 

 
Example
-------
```dfs  
def j1 =
|json_emitter(
    '{"hallo":"ho"}',
    '{"ballo":"du", "sim": 3}',
    '{"rallo":"su"}',
    '{"gallo":"mu", "rallo": "srrt", "dim": 232.3}',
    '{"mallo":"ffu"}',
    '{"hallo":"hott"}',
    '{"ballo":"dutt", "sim": 3}',
    '{"rallo":"sutt", "rallo": "srrt", "dim": 222.3}',
    '{"gallo":"mutt"}',
    '{"mallo":"tutt"}'
)
.select('rand')

|collect_fields('hallo', 'mallo', 'gallo', 'trimm') 
.default(0.0) 

```
Since `default` is given, the data-point that gets emitted by the `collect_fields` node, will always have all the fields given in `fields`.

Let's say after the node starts up, the first data-point it sees incoming is
```json

{"ts":1, "hallo": "hott"}

``` 
This is what the first emitted data-point will look like:
```json

{"ts":1, "hallo": "hott", "mallo":  0.0, "gallo":  0.0, "trimm":  0.0}

``` 


> Note: The field 'trimm' is not present in any of the incoming data-items, so it will always have the default value 0.0




Parameters
----------

| Parameter                        | Description                                                                                                                                                       | Default   |
|----------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| _[node]_ fields( `string_list` ) | The list of field names (paths) to collect.                                                                                                                       |           |
| default( `any` )                 | Default value for any field, that has not be seen yet. If not given and there has not yet been a value for a field, the field is not included in the output item. | undefined | 
 