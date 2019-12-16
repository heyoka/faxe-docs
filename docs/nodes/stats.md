The stats node
==============

The stats node lets you compute statistical functions on data_points and data_batches.

See nodes under `statistics` for details.

Stats nodes produce a new stream, the incoming stream is not outputted.

Parameters
----------
All statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( string )|name of the field used for computation|
as( string )| name for the field for output values| defaults to the name of the stats-node