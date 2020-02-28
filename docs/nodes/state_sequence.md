The state_sequence node
=====================

This node takes a list of lambda expressions representing different states.

It will emit values only after each state has evaluated as true in the given order and, for each step in the sequence
within the corresponding timeout.

A transition timeout must be defined for every state transition with the `within` parameter.

If a timeout occurs at any point the sequence will be reset and started from the first expression again.

Note that the sequence timeouts start after the first data_point has satisfied the first lambda expression.
Therefore, if 3 lambda states are given, only 2 durations for the `within` parameter can be defined.

With the `strict` parameter the sequence of states must be met exactly without any intermediary data_points coming in,
that do not satisfy the current state expression.
Normally this would not reset the sequence of evaluation, in this mode, it will.

On a successful evaluation of the whole sequence, the node will simply output the last value, that completed the sequence.

The state_sequence node can be used with one or many input nodes.

Example
-------
    in1
    |state_sequence(in2, in3) %% can use any number of nodes
    .states(
        lambda: "data.topic" == 'in1', %% state 1
        lambda: "data.topic" == 'in2', %% state 2
        lambda: "data.topic" == 'in3'  %% state 3
    )
    .within(
        25s, %% transition-time from state 1 to state 2
        20s  %% transition-time from state 2 to state 3
        ) 




Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
[node] nodes_in( `node_list` )| a list of node(chains) | optional
states (`lambda_list`) | the states |
within( `duration_list` )| one timeout for every state-transition |  
strict( `is_set` ) | whether the state sequence must be transition exactly | false (not set)
 