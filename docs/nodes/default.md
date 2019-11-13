The default node
=====================

Add fields and/or tags to a data_point or batch if they do not already exist.
Does not overwrite or update any fields or tags.


Example
-------

    |default()
    .fields('id', 'vs', 'df')
    .field_values('some_id', 1, '05.043')

The above example will set the field `id` to the value 'some_id' , if a field with the name `id` does not already exist.
Accordingly `vs` will be set to 1, `df` will be set to '05.043'.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
fields( `string_list` )| list of fieldnames | []
field_values( `list` )|list of values for the given fields (must have the same length as fieldnames)|[]
tags( `string_list` )| list of tagnames | []
tag_values( `list` )|list of values for the given tags (must have the same length as tagnames)|[]
