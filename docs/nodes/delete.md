The delete node
=====================

Delete fields and/or tags from a data_point or from all data_points in a data_batch.


Example
-------

    |delete()
    .fields('temp', 'data.meta[3]')

The above example will delete the field named `temp` and the third array entry of the field `data.meta` .


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
fields( `string_list` )| list of fieldnames to delete | []
tags( `string_list` )| list of tagnames to delete | []
