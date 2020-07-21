The triggered_timeout node
=====================

Emits a point, if there is no message coming in for the given amount of time.

A timeout will be started on an explicit trigger:
* When a lambda expression is given for parameter `timeout_trigger`, this expression must evaluate as true
to start (and after a timeout has occurred to restart) a timeout.

* If no lambda expression is given for the `timeout_trigger`, the trigger is any data_point coming in on port 1, the
so called `trigger_port`.

A new trigger does not restart a running timeout.
After a timeout occurred, the node waits for a new trigger to come in before it starts a new timeout.

After a timeout is started the node waits for data coming in,
that either does not satisfy the trigger expression(when a lambda expression is given for
the `timeout_trigger` parameter) or is coming in on any port except the `trigger_port` (port 1).

Data for the outgoing data-point can be defined with the `fields` and `field_values` parameters.
This node can have any number of input-nodes.

Example
-------

```dfs  

def timeout = 30s
% ...

in1
|triggered_timeout(in2)
.timeout(timeout)
.timeout_trigger(lambda: "data.topic" == 'in1')


def condition_reason = 'oh no !!'

robot_state
|triggered_timeout(orderlog)
.timeout(timeout)
.fields(
    'combined.condition.name', 
    'combined.condition_reason', 
    'combined.condition.id')
.field_values(
    'ERROR', 
    condition_reason, 
    2)
%.cancel_fields('combined.condition.name', 'combined.condition_reason', 'combined.condition.id')
%.cancel_field_values('OK', '', 0)
 
```

 
Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
timeout( `duration` )|  | 
timeout_trigger( `lambda` ) | lambda expression which triggers the timeout | optional
fields (`string_list`) | paths for the output fields | optional
field_values( `list` ) | values for the output fields | optional
 