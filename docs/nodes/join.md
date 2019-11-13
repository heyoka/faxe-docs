The join node
=====================

Join data from two or more nodes, given a list of prefixes, for each row.

If the 'field_merge' parameter is given, the node will merge the field given from every in-node, instead of
joining.

When considering the "fill" option, the following rules apply:

* none - (default) skip rows where a point is missing, inner join.
* null - fill missing points with null, full outer join.
* Any numerical value - fill fields with given value, full outer join.

Note, that this node will produce a completely new stream.



Example
-------
    
    def v1 =
    |value_emitter()
    .every(3s)
    .type(point)
    .align()

    def v2 =
    |value_emitter()
    .every(5s)
    .type(point)
    .align()

    v1
        |join(v2)
        .prefix('v1.joined', 'v2.joined')
        .tolerance(3s)
        .missing_timeout(3s)
        .fill(none)

Joins the fields of `v1` and `v2` and produces a stream, that has the fields `v1.joined.val` and `v2.joined.val`


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
prefix( `string_list` )| list of prefixes (used in join mode) | []
field_merge( `string` )|when given, the join node will do a field merge operation| undefined
missing_timeout( `duration` )| values that do not arrive within this timeout will be treated as missing | 20s
tolerance( `duration` )|db fieldnames (mapping for faxe fieldname to table field names)|
fill( 'none' 'null' `any` )|fill missing values / join behaviour|'none'
