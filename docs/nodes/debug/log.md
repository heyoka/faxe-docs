The log node
=====================

Log incoming data to a file in json format (line by line).

That means, every incoming data-item will be converted to a json string and then appended as a new line to the given file.
 
The node tries to ensure, that all parent directories for the specified file exist, trying to create them, if necessary.


> Note: Only single data_points will be written to the file. If the node is fed data_batch items, they will be unbatched to single data_points first.

Example
-------
```dfs  
|log('topics.txt') 

```

Parameters
----------

| Parameter                 | Description                           | Default |
|---------------------------|---------------------------------------|---------|
| _[node]_ file( `string` ) | valid writeable or creatable filepath |         |
