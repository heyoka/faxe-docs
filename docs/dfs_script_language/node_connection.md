Nodes are normally connected by their occurence in the dfs script.

```dfs
|node1()
|node2()

```
Node1 is connected to node2.

The above could also be written as:

```dfs
def n1 = |node1()

n1
|node2()

```

... which results in the same computing flow.

Here we see that we can actively manipulate the connections in a flow by binding a node to a declaration with the `def` keyword.
Whole chains of nodes ie: sub-graph can be bound to a variable.
This is called a `chain-declaration`.

With the above example we can connect another node to n1:

```dfs

def n1 = |node1()

n1
|node2()

n1
|node3()

```
Here both nodes node2 and node3 are connected to node1.

#### Note:
Every use of the `def` keyword interrupts the auto chaining of nodes, ie:

```dfs
|node1()
|node2()
def n3 = |node3()
|node4()

```

In the above example, node3 and node4 are not connected to node2, as a consequence of using the `def` keyword.
Instead we have 2 chains in this flow: 1. Node1 connected to node2 and 2. node3 connected node4.

If we'd like to union these 2 node chains:

```dfs
def in1 =
|node1()
|node2()

def in2 = 
|node3()
|node4()

in1
|union(in2)

```


There are several node-types in faxe that deal with more than one input node, for example the `combine` node.
Here the use of `chain-declarations` is necessary:

```dfs

def s1 =
|node1()
|node1_1

def s2 =
|node2()
|node2_1()

s1|combine(s2)

```