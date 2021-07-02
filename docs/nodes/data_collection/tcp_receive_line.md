The tcp_receive_line node
=====================

This node connects to a tcp endpoint and awaits data in a `line separated` special format, 
which is defined by the `parser` parameter.
The parser will then try to convert the data to faxe's internal format and emit the result.

At the moment the line separator is fixed to `\n`. 
    
If the `changed` option is given, the node will only emit on changed values (crc32 checksum comparison).

The tcp listener is protected against flooding with the {active, once} inet option.

Example
-------
```dfs    
def parser = 'parser_conv_tracking_v1'

|tcp_recv_line()
.ip('212.14.149.3')
.port(2004)
.parser(parser)
.as('data')
     
```


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
ip( `string` )| ip or hostname for the tcp peer | 
port( `integer` )| port number |
parser( `string` )| name of parser to use for data conversion, see table below|
as( `string` ) | name of the field for parsed data|
changed( is_set )| whether to check for changed data| false (not set) 
min_length( integer)|lines shorter than min_length bytes will be ignored | 61

Available Parsers
-----------------
 