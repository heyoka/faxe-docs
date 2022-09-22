The udp_send node
=====================

This node sets up an udp socket and sends data to a specified endpoint (host, port).
Before sending, data-items will be converted to json format.


> Note: Broadcast messages are not possible with this node.

------------ 

> Note: This node is a sink node and does not output any flow-data, therefore any node connected to this node will not get any data.

Example
-------

```dfs  
|udp_send()
.host('127.0.0.1')
.port(5555)

```     
Will send incoming data-items json-encoded to the specified endpoint.

 
Parameters
----------

| Parameter         | Description                     | Default |
|-------------------|---------------------------------|---------|
| host( `string` )  | ip or hostname for the udp peer |         |
| port( `integer` ) | port number                     |         |
 
 