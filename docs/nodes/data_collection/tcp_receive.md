The tcp_receive node
=====================

This node is used to receive data from a tcp socket.
There are two modes it can operate in:

+ `Connect`: If `ip` is set to a valid hostname or ip address, the node will connect to that peer and then just waits for incoming data.
+ `Listen`: Without `ip`, the node will just open a tcp listen port and waits for a connection from outside to receive data.

 

### Data - Parser

When we define a parser module, incoming data can be parsed to faxe's internal data-format with it. 

If no `parser` is defined, incoming data will be set as is to the field given with the `as` paramenter.

If both `parser` and `as` are not given, the node assumes, that incoming data has JSON format and will try to decode it into
faxe's internal format.


### Packet size

Data is expected with a defined packet size.

`packet` can be: 1 | 2 | 4 and defaults to 2.
Packets consist of a header specifying the number of bytes in the packet,
followed by that number of bytes. The header length can be one, two, or four bytes,
and containing an unsigned integer in big-endian byte order.

    `Length_Header:16/integer, Data:{Length_Header}/binary`

Since `0.19.19`: packet now can also have the value 'line', if this is given, data from the socket will be
treated as separated by newline characters (\n, \r\n).

-----


If the `changed` option is given, the node will only emit on changed values (crc32 checksum comparison).

The tcp listener is protected against flooding with the {active, once} inet option.

Examples
-------

```dfs  
|tcp_recv() 
.port(9745) 
.packet(4) 
```     
Sets up a tcp listen socket on port 9745 and awaits an incoming connection. It uses a 4-byte length header to determine 
packet boundaries and will try to json-decode incoming data.

---------------------------------------
```dfs  
def parser = 'parser_robot_plc_v1'

|tcp_recv()
.ip('212.14.149.8')
.port(9715)
.parser(parser)
.as('data')
```     
--------------------------------

```dfs  
 
|tcp_recv()
.ip('212.14.149.8')
.port(9715) 
.packet(4)
.as('data.raw')
```     


Parameters
----------

| Parameter                      | Description                                | Default         |
|--------------------------------|--------------------------------------------|-----------------|
| ip( `string` )                 | ip or hostname for the tcp peer            | undefined       |
| port( `integer` )              | port number                                |                 |
| packet( `integer`  or 'line' ) | packet length/type                         | 2               |
| parser( `string` )             | name of parser to use for data conversion  | undefined       |
| as( `string` )                 | name of the field for parsed data          | undefined       |
| changed( is_set )              | whether to check for changed data          | false (not set) |
