The default node
=====================

Add fields and/or tags to a data_point or batch if they do not already exist.
Does not overwrite or update any fields or tags.

Note: 
This nodes checks for existence of fields before writing them. 
Consider using the [set node](set.md), if you just want some fields set.
It is more performant especially with high frequency data streams.

Examples
-------
```dfs  
|default()
.fields('id', 'vs', 'df')
.field_values('some_id', 1, '05.043')
```

The above example will set the field `id` to the value 'some_id' , if a field with the name `id` does not already exist.
Accordingly `vs` will be set to 1, `df` will be set to '05.043'.


```dfs  
|default()
.fields('id', 'vs', 'df')
.field_values(25.44)
```

Since v0.19.41: If exactly 1 value is given for `field_values`, it is used for every field name given.



Parameters
----------

| Parameter               | Description                                                                          | Default |
|-------------------------|--------------------------------------------------------------------------------------|---------|
| fields( `string_list` ) | list of fieldnames                                                                   | []      |
| field_values( `list` )  | list of values for the given fields (exactly one entry or same length as fieldnames) | []      |
| tags( `string_list` )   | list of tagnames                                                                     | []      |
| tag_values( `list` )    | list of values for the given tags (exactly one or same length as tagnames)           | []      |
