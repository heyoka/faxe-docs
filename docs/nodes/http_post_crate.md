The http_post_crate node
=====================

Sends data to a CRATE DB HTTP endpoint using Crate's HTTP Api.
If any errors occur during the request, the node will attempt to retry sending.



Example
-------
```dfs  
def db_table = 'grip_log_fulltext3'
def db_fields = ['id', 'df', 'vs', 'topic']
def faxe_fields = ['id', 'df', 'vs', 'topic']

|http_post_crate()
.host(<<< http://deves-crate.internal >>>)
.port(4201) 
.table(db_table)
.db_fields(db_fields)
.faxe_fields(faxe_fields)
.remaining_fields_as('data_obj')

```

Inserts the faxe-fields `id`, `df`, `vs`, `topic` into the db-fields with the same names and all remaining fields into
the db-field named `data_obj` (which is of type 'OBJECT') in the table `grip_log_fulltext3` .


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
host( `string` )| hostname or ip address of endpoint |
port( `integer` )|port number|
table( `string` )| database tablename | 'doc'
db_fields( `string_list` )|db fieldnames (mapping for faxe fieldname to table field names)|
faxe_fields( `string_list` )|faxe fieldnames (mapping for faxe fieldname to table field names)|
remaining_fields_as( `string` )| if given inserts all fields not in faxe_fields into the given field, which must be of type 'object'| undefined  

 