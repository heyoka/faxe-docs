The keep node
=====================

Keep only those fields and tags specified by the parameters.

Example
-------
    
    |keep()
    .fields('topic', 'temperature') 


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
fields( `string_list` )| list of fieldnames to keep from the incoming data | []
tags( `string_list` )| list of tagnames to keep from the incoming data | []
