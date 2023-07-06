The array_explode node
==============

Given a data_point with one or more array fields, create and emit one new data_point for every entry in the array(s).

If more than 1 array field is used, then the arrays must have to be of the same size, otherwise the mapping will fail.
Any field not found in an incoming data-point, will just be ignored.


For every point created out of the array(s) a time offset will be added to the previous point timestamp, starting with the timestamp of the
original data_point for the first resulting data-point.

Example
-------

```dfs
|json_emitter(
    '{"motor": {"drive": [1,2,3,4,5,6,7,8,9]}, 
    "torque": [6,7,8,9,1,2,3,4,5], 
    "zip": [4,5,6,7,8,9,1,2,3]}'
    )
    
|array_explode()
.fields('motor.drive', 'zip')
.as('data.ex_drive', 'data.ex_zip')

```

On every emit of the json_emitter node, the `array_explode` node will produce 10 (length of the arrays) new data-items
with 2 values: `data.ex_drive` (with one value from motor.drive) and `data.ex_zip` (with a value from the zip field).


Parameters
----------

| Parameter                 | Description                                                                          | Default   |
|---------------------------|--------------------------------------------------------------------------------------|-----------|
| fields( `string_list` )   | names of the fields used for each computation                                        |           |
| as( `string_list` )       | list of output field names according to `fields`, defaults to the values of `fields` | undefined |
| time_offset( `duration` ) |                                                                                      | 1s        |
| keep( `string_list` )     | list of field-names, that should be kept from the original data-point                | undefined |
