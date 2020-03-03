The rename node
=====================

Rename existing fields and/or tags.

Example
-------
```dfs  
|rename()
.fields('topic', 'temperature') 
.as_fields('cipot', 'mean_temp')
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
fields( `string_list` )| list of fieldnames to rename | []
as_fields( `string_list` )| list of new fieldnames for renaming | []
tags( `string_list` )| list of tagnames to rename | []
as_tags( `string_list` )| list of new tagnames for renaming | []
