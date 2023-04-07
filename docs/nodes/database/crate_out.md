The crate_out node
=====================

Write data to CrateDB.

Sends data to a CRATE DB HTTP endpoint using Crate's HTTP Api.
If any errors occur during the request, the node will attempt to retry sending.

> Note: This node is a sink node and does not output any flow-data, therefore any node connected to this node will not get any data.


### Since vs. 1.0.13:
If `db_fields` and `faxe_fields` are not given, the node now tries to find the table structure on its own,
by querying the destination table. In this mode, the remaining_fields_as parameter will be ignored.


Example
-------
```dfs  
def db_table = 'grip_log_fulltext3'
def db_fields = ['id', 'df', 'vs', 'topic']
def faxe_fields = ['id', 'df', 'vs', 'topic']

|crate_out() 
.table(db_table)
.db_fields(db_fields)
.faxe_fields(faxe_fields)
.remaining_fields_as('data_obj')

```

Inserts the faxe-fields `id`, `df`, `vs`, `topic` into the db-fields with the same names and all remaining fields into
the db-field named `data_obj` (which is of type 'OBJECT') in the table `grip_log_fulltext3` .

> Note: The timestamp field `ts` will always be written.


```dfs  
def db_table = 'grip_log_fulltext3' 

|crate_out() 
.database('test')
.table(db_table) 

```
Since vs. 1.0.13
The node derives the list of fields (faxe and db) by querying the schema for the given table.
In this example schema (`database`) 'test' is used.



Parameters
----------

| Parameter                       | Description                                                                                                                            | Default                  |
|---------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| host( `string` )                | hostname or ip address of endpoint                                                                                                     | from config file         |
| port( `integer` )               | port number                                                                                                                            | from config file         |
| user( `string` )                | username                                                                                                                               | from config file         |
| pass( `string` )                | password                                                                                                                               | from config file         |
| tls( `is_set` )                 | whether to use tls ie. https                                                                                                           | false (not set)          |
| database( `string` )            | database/schema name                                                                                                                   | 'doc'                    |
| table( `string` )               | database tablename                                                                                                                     |                          |
| db_fields( `string_list` )      | db fieldnames (mapping for faxe fieldname to table field names), since 1.0.13: If not given, fields will be determined automatically   | undefined (since 1.0.13) |
| faxe_fields( `string_list` )    | faxe fieldnames (mapping for faxe fieldname to table field names), since 1.0.13: If not given, fields will be determined automatically | undefined (since 1.0.13) |
| remaining_fields_as( `string` ) | if given inserts all fields not in faxe_fields into the given field, which must be of type 'object'                                    | undefined                |
| max_retries( `integer` )        | max retry attempts after INSERT statement fails                                                                                        | 3                        |

 