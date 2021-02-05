# Flow concurrency

From every task (flow) registered with Faxe a number of copies (concurrent flows) can be started, this is called a task-group.

Flow concurrency helps with building bridging functionality where it is useful to increase throughput by concurrency.
Every member of a task-group will run exactly the same flow.

