The postgre_statement node
=====================

_`Experimental`_ since vs. 1.0.13

Execute a statement against a postreSQL or compatible database.

2 different execution modes are available:

* **one shot**:
    This mode is the default mode, when the `every` parameter is not set.
    The node will execute the given statement **only once**, possibly retrying on failure.
    After the statement has been executed sucessfully, the node will emit a data item and then will do nothing from this point on.
* **periodically**:
    With the `every` parameter given, the node will execute the provided SQL statement periodically.

The execution of the statement can also be triggered by a data item that enters the node (param `start_on_trigger` set to true). 
But the execution mode will remain the same, in this case.


> Note: The statement can be anything from SELECT, INSERT, DELETE or even any schema manipulation. Handle with care !


Example
-------
```dfs  
def source_schema = 'doc'
def source_table = '0x145f'
%% the SHOW CREATE TABLE statement is supported by CrateDB, not by Postgre itself
def table_statement = 'SHOW CREATE TABLE "{{source_schema}}"."{{source_table}}"' 

%% statement to get the table create statement
|postgre_statement()
.host('127.0.0.1')
.statement(table_statement) 
.retries(2)
.result_type('point')

```

Executes the SHOW CREATE TABLE statement and emits a datapoint with a field that holds the result of the statement

Because we can execute a statement from an incoming data item, we could use the result of the first example, to copy our table to
a different database. So we extend our example by adding a second postgre_statement node that uses the result:

```dfs  
def source_schema = 'doc'
def source_table = '0x145f'
def table_statement = 'SHOW CREATE TABLE "{{source_schema}}"."{{source_table}}"' 
def fieldname = 'SHOW_CREATE_TABLE_{{source_schema}}_{{source_table}}'

%% statement to get the table create statement
|postgre_statement()
.host('127.0.0.1')
.statement(table_statement)  
.result_type('point')

%% here we use the result of the SHOW CREATE TABLE statement
|postgre_statement()
%% as statement we use the value of the incoming data point
.host('192.168.2.1')
.statement_field(fieldname)   
.start_on_trigger(true)

``` 



Parameters
----------

| Parameter                     | Description                                                                                                                                              | Default                                            |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| host( `string` )              | hostname or ip address of endpoint                                                                                                                       | config: `crate.host`/`FAXE_CRATE_HOST`             |
| port( `integer` )             | port number                                                                                                                                              | config: `crate.port`/`FAXE_CRATE_PORT`             |
| tls( `boolean` )              | whether to use tls for the connection                                                                                                                    | config: `crate.tls.enable`/`FAXE_CRATE_TLS_ENABLE` | 
| user( `string` )              | username                                                                                                                                                 | config: `crate.user`/`FAXE_CRATE_USER`             |
| pass( `string` )              | password                                                                                                                                                 | config: `crate.pass`/`FAXE_CRATE_PASS`             |
| statement( `string` )         | SQL statement, that should be executed.                                                                                                                  | undefined                                          |
| statement_field( `string` )   | Name of the field, that holds the SQL statement, that should be executed. `start_on_trigger` must be set to true in order to use this feature.           | undefined                                          |
| every( `duration` )           | Interval at which to execute the statement (periodically), if not given, the node is in one-shot mode.                                                   | undefined                                          |
| result_type( `string` )       | Type of the resulting data item, 'batch' or 'point'                                                                                                      | 'batch'                                            |
| start_on_trigger( `boolean` ) | if true, the node waits for an incoming data item before sending the statement to the database, this must be set to true, when `statement_field` is used | false                                              |
| retries( `integer` )          | max retry attempts, when a statement fails                                                                                                               | 2                                                  |

 Either `statement` or `statement_field` must be given.