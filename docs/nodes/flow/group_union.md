The group_union node
=====================

This node is used to terminate and 'un-group' a grouped dataflow. It must be placed `after a group_by` node.

The group_union node acts as a [union](union.md) for grouped dataflows.

If this node is used without a `group_by` node, it will have no effect at all on the data-flow.

> Note: The behaviour of using more than 1 `group_union` node is not defined.

See [group_by](group_by.md) 


Examples
-------

```dfs   

  |group_by('fieldname1')
  %% 1 debug-node per group 
  |debug()
  |group_union()
  %% end of grouping
  |debug()

```
An instance of the first debug node wil be started for every group, the second one will exist only once.
