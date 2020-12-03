The tcp_send node
=====================

This node connects to a tcp endpoint and sends data with a defined packet size.

Data to be sent can be:
* a predefined string
* a predefined json string
* data that comes in to this node from downstream nodes
 
Sending can be done either periodically (if `every` is given) or triggered by an incoming data-item. 

The node can also handle "responses" from the peer endpoint (timeout can be given).
After the node has sent a tcp message, it starts the timeout to wait for the response. 
Any data that comes in after this timeout will be ignored.

But note: There is no guarantee, that a message that is received by this node on its tcp socket is in any way
related to the message it just sent out. In other words: unless every message (and its response) is marked with some
unique id, there is no means of ensuring that any incoming message is the "response" to a previous send operation done by this node.
A tcp endpoint can send a message to another endpoint whenever is wants to do so.
If you rely on a strict request-response paradigm, consider using http, as this is made for such operations.

`packet` can be: 1 | 2 | 4 and defaults to 2.
Packets consist of a header specifying the number of bytes in the packet,
followed by that number of bytes. The header length can be one, two, or four bytes,
and containing an unsigned integer in big-endian byte order.

    `Length_Header:16/integer, Data:{Length_Header}/binary`
     

The tcp listener is protected against flooding with the {active, once} inet option.

Example
-------

```dfs  
|tcp_send()
.ip('127.0.0.1')
.port(5555)
.every(3s)
.msg_text('hello tcp!') 
```     
tcp_send will send the string "hello tcp!" every 3 seconds ignoring any incoming tcp data. It will also send the same string, if any data-item is received from parent nodes.


```dfs  
 
|tcp_send()
.ip('127.0.0.1')
.port(5555) 
.response_as('data.tcp.response[1]')
.response_timeout(2s)
.response_json()
```     

tcp_send will send all data coming in from its downstream nodes, after sending it will wait for data with a 2 second timeout.
Data received will be interpreted as a json-string and injected into the current data-item with the path: data.tcp.response[1]
(first array entry of the data-tcp-response subobject)


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
ip( `string` )| ip or hostname for the tcp peer | 
port( `integer` )| port number |
packet( `integer` )| packet length | 2
every( `string` )| send interval| undefined
msg_text( `string` ) | predefined string to send to the peer endpoint| undefined
msg_json( `string` ) | predefined json-string to send to the peer endpoint| undefined
response_as( `string` ) | name of the field for parsed data| undefined
response_json( is_set ) | interprets a response as a json-string| false (not set)
response_timeout( duration ) | timeout for a "response" after a message has been sent| 5s
 