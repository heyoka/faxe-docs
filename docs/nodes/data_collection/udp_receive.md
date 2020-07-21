The udp_receive node
=====================

This node listens on an `udp socket` and awaits data in a special format, which is defined
by the `parser` parameter, the parser will then try to convert the data to faxe format and emit the
result.

If the `changed` option is given, the node will only emit on changed values (crc32 checksum comparison).

The udp listener is protected against flooding with the {active, once} inet option.

Example
-------

```dfs  
def parser = 'parser_robot_plc_v1'

|udp_recv()
.ip('212.14.149.8')
.port(9715)
.parser(parser)
.as('data')
```     


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
port( `integer` )| port number |
parser( `string` )| name of parser to use for data conversion, see table below|
as( `string` ) | name of the field for parsed data|
changed( is_set )| whether to check for changed data| false (not set) 

Available Parsers
-----------------

Parser name            | Description
-----------------------|-------------------------------------------------
`parser_robot_plc_v1`  | parses the special robotplc binary data format
`parser_conv_tracking_v1`|parser for the conveyor tracking ascii-protocol