The mongo_query node
=====================

_`Experimental`_. 

Since 0.15.2

Read data from MongoDB.

`Database`, `collection` and _selector_ (`query`) can be specified by the user.

The mongo_query node will always output `data_batch` items at the moment, even if there is only 1 result document.

> Note: Faxe is not optimized for heavy batch processing, it is rather designed for massive concurrent stream processing. 
> If you want to process more than a few thousand rows at a time, maybe faxe is not the right tool for your job.

Example
-------
```dfs  
def host = 'localhost'

|mongo_query()
.host(host)
.user('root')
.pass('root')
.database('test')
.collection('inventory')
.query(<<< {"item": "canvas"} >>>)
.every(5s)
.as('data')

```
Every 5 seconds query mongo db on database _test_ and collection _inventory_ for documents, that have
"canvas" as their values for the "item" field. Sets root field to 'data'.


```dfs
def host = 'localhost'

|value_emitter()
.every(7s)

|mongo_query()
.host(host)
.user('root')
.pass('root')
.database('test')
.collection('inventory')
.query(<<< {"size.h": {"$gt": 16}} >>>) 

```
Every time a dataitem arrives at this node, from outside, it will query mongodb for documents that have a  
nested `h` field inside a `size` object, that has a value greater than 16.
The node will query mongodb every 7 seconds, triggered by data coming in from the [value_emitter](../debug/value_emitter.md) node.

 
Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host ( `string` ) | host name or ip address |
port ( `integer` )|  | 27017
user ( `string`) | username | 
pass ( `string` )|the users password|
database ( `string` )| mongo database name |
collection ( `string` )| mongo collection name in database `database`|
query ( `string` ) | a valid `mongo selector` as a json string | {} 
every ( `duration` ) | read interval | 5s
align ( is_set ) | whether to align the `every` parameter | false (not set) 
as | set the root path for outputs | undefined
