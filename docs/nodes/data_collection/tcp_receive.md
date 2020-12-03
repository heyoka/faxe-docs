The tcp_receive node
=====================

This node connects to a tcp endpoint and awaits data with a defined packet size.

It awaits data in a special format, which is defined by the `parser` parameter, if given.
The parser will then try to convert the data to faxe's internal format and emit the result.

If no `parser` is defined, incoming data will be set as is to the field given with the `as` paramenter.

`packet` can be: 1 | 2 | 4 and defaults to 2.
Packets consist of a header specifying the number of bytes in the packet,
followed by that number of bytes. The header length can be one, two, or four bytes,
and containing an unsigned integer in big-endian byte order.

    `Length_Header:16/integer, Data:{Length_Header}/binary`
    
If the `changed` option is given, the node will only emit on changed values (crc32 checksum comparison).

The tcp listener is protected against flooding with the {active, once} inet option.

Example
-------

```dfs  
def parser = 'parser_robot_plc_v1'

|tcp_recv()
.ip('212.14.149.8')
.port(9715)
.parser(parser)
.as('data')
```     

```dfs  
 
|tcp_recv()
.ip('212.14.149.8')
.port(9715) 
.packet(4)
.as('data.raw')
```     


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
ip( `string` )| ip or hostname for the tcp peer | 
port( `integer` )| port number |
packet( `integer` )| packet length | 2
parser( `string` )| name of parser to use for data conversion, see table below|
as( `string` ) | name of the field for parsed data|
changed( is_set )| whether to check for changed data| false (not set) 

Available Parsers
-----------------

Parser name            | Description
-----------------------|-------------------------------------------------
`parser_robot_plc_v1`  | parses the special robotplc binary data format
`parser_conv_tracking_v1`|parser for the conveyor tracking ascii-protocol
`parser_wms_rmst_v1`| 
`parser_lrep_v1`|parser for lrep ascii-protocol