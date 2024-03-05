The collect_fields node
==============

For every field in `fields`, holds the latest value and outputs a  data-point item with these fields on every incoming data-point.
If a field is not present in an input data-point, it will be ignored and the last known value for this field is used in output data.

It is possible to set a `default` value for fields that have not been seen so far.

With `emit_unchanged` set to **false**, no data is emitted for a data-point, that did not change any of the values.



> If you need more complex collecting behaviors, take a look at the [collect](./collect.md) node.

Example
-------

```dfs

|json_emitter(
'{"hallo":"ho"}',
'{"ballo":"du", "sim": 3}',
'{"rallo":"su"}',
'{"gallo":"mu", "rallo": "srrt", "dim": 232.3}',
'{"mallo":"ffu"}',
'{"hallo":"hott"}',
'{"ballo":"dutt", "sim": 3}',
'{"rallo":"sutt", "rallo": "srrt", "dim": 232.3}',
'{"gallo":"mutt"}',
'{"mallo":"ffutt"}'
)
.select('rand')

|collect_fields('hallo', 'mallo', 'gallo')
.default(0.003)

```

This will output a data-point item with the fields `hallo`, `mallo` and `gallo`. Fields that have no value in the buffer yet,
will get the default value.


Parameters
----------

| Parameter                     | Description                                                                                                                                                                              | Default   |
|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| [node]fields( `string_list` ) | names of the fields used for each computation                                                                                                                                            |           |
| default( `any` )              | Default value for field, that have not been collected so far. If this is not given, that output item will only contain fields, that have been seen already.                              | undefined | 
| keep(`string_list`)           | If given, these fields will be included in output additionally to `fields`. The values for `keep` fields are taken from the current (incoming) data-point.                               | []        |
| keep_as(`string_list`)        | Rename fields that are kept (must have the same number of entries as `keep`).                                                                                                            | undefined |
| emit_unchanged (`boolean`)    | When set to false, processing of a data-item that does not result in a change to the previous output, will not trigger an output of data. `keep` fields are excluded from this decision. | true      |
