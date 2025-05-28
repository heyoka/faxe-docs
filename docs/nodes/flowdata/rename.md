The rename node
=====================

Rename existing fields and/or tags.

If a field or tag given does not exist, it will be ignored.

Examples
-------
```dfs  
|rename()
.fields('topic', 'temperature') 
.as_fields('cipot', 'mean_temp')
```
A list of strings for the new field names is given.


_`Since 0.19.4`_ : We can now also use [lambda expressions](../../dfs_script_language/lambda_expressions.md) for the `as_fields` parameter.

```dfs  
|rename()
.fields('topic', 'temperature') 
.as_fields('cipot', lambda: str_concat("data.prefix", '_temp'))
```
Here we use a mixed list, strings and a lambda expression, for the as_fields parameter.

### A special case:
```dfs  
|rename()
.fields('') 
.as_fields('data')
```
Every field in the root object will be moved to a new object `data`.

Before:
```json
{"field_a":  1, "field_b":  "2"}
```
After:
```json
{"data": {"field_a":  1, "field_b":  "2"}}
```


Parameters
----------

| Parameter                | Description                                                                 | Default |
|--------------------------|-----------------------------------------------------------------------------|---------|
| fields( `string_list` )  | list of fieldnames to rename                                                | []      |
| as_fields( `list` )      | list of strings or lambda expressions (can be mixed) for the new fieldnames | []      |
| tags( `string_list` )    | list of tagnames to rename                                                  | []      |
| as_tags( `string_list` ) | list of new tagnames for renaming                                           | []      |
