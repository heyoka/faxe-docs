The collect_fields node
=====================

_`Experimental`_ since vs. 1.0.13

A very simple version of the collect node.

For every given field in `fields`, the node adds this field (and latest value seen) to an output data-point.
If there is a field already in the internal data-point, it will be overwritten with the value of the same field in the current data item.
If the field is not present in the current incoming data item, it will be left untouched in the internal point.

If `default` is given, and the node has never seen an incoming item with a specific field, it will get the default as value.
Otherwise, if default is not given, the specific field will not be included in the output item, as long as there was no item seen with the specific field present.

The _timestamp_, _delivery_tag_ and all _tags_ from the current incoming data-point will be used in the output point.

The resulting data-point at max include all the fields specified with the `fields` parameter.
If default is given, the resulting data-point will have exactly this fields on all emits.

 
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

|collect_fields()
.fields('hallo', 'mallo', 'gallo', 'trimm')
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

| Parameter                     | Description                                                                                                                                                       | Default          |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------|
| fields( `string_list` )       | The list of field names (paths), that make up the resulting data point.                                                                                           | from config file |
| default( `any` )              | Default value for any field, that has not be seen yet. If not given and there has not yet been a value for a field, the field is not included in the output item. | undefined        | 
 