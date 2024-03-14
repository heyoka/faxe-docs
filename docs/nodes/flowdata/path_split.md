The path_split node
=====================

since v1.3.3

Split a data-point by field root paths.

Outputs a data-point for every object, that is found under a root path. Values that are not objects themselves are ignored.

With `include_name` and `include_as`, the name of the root path can be used as a new field for the resulting data-points.

> Note, that field/path names must start with a letter !

Examples
-------
```dfs  
def path_prefix = 'module'

|json_emitter(
    '{"module1" : {"what" : "ever"}, "module2": {"this" : 555}, "module3" : 14}'
)

|path_split()
.include_as(path_prefix)
```
Here root paths are: `module1`, `module2` and `module3`.

This example will produce 2 new data-points:

```json

{"ts":  1675147412200, "module": "module1", "what": "ever"}

```
and
```json

{"ts":  1675147412200, "module": "module2", "this": 555}

```
Data from root path `module3` is ignored, because it is not an object (the value is '14') .



Parameters
----------

| Parameter                 | Description                                                                   | Default |
|---------------------------|-------------------------------------------------------------------------------|---------|
| include_name( `boolean` ) | Whether to include the root path name as a new field in the resulting points. | true    |
| include_as( `string` )    | The field name for the new field, if include_name is true.                    | 'name'  |
