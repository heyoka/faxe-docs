The oracle_query node
=====================

Read data from OracleDB.

Example
-------
```dfs  
def host = 'my.oracle.host'
def port = 1521
def user = 'MY_ORACLE_USER'
def password = 'MY_ORACLE_PASS'
def service_name = 'MY.service'

def query = '
    select * from room order by room_number
'

|oracle_query()
.host(host)
.port(port)
.user(user)
.pass(password)
.service_name(service_name)
.query(query)
.every(10s)
.align()

```

 
Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host ( `string` ) | host name or ip address |
port ( `integer` )|  | 1521
user ( `string`) | username | 
pass ( `string` )|the users password|
service_name ( `string` )| |
query ( `string` ) | a valid sql select statement |
result_type ( `string` ) | eighter 'batch' or 'point' | 'batch'
time_field ( `string` ) | name of the time field |
every ( `duration` ) | read interval | 5s
align ( is_set ) | whether to align every | false (not set) 
 
 