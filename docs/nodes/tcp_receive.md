The tcp_receive node
=====================

This node connects to a tcp endpoint and awaits data in a special format, which is defined by the `parser` parameter.
The parser will then try to convert the data to faxe's internal format and emit the result.

At the moment tcp messages must start with a `2 byte header` denoting the length of the following data.

    `Length_Header:16/integer, Data:{Length_Header}/binary`
    
If the `changed` option is given, the node will only emit on changed values (crc32 checksum comparison).

The tcp listener is protected against flooding with the {active, once} inet option.

Example
-------
    
    def parser = 'parser_robot_plc_v1'
    
    |tcp_recv()
    .ip(212.14.149.8)
    .port(9715)
    .parser(parser)
    .as('data')
     


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
ip( `string` )| ip or hostname for the tcp peer | 
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