Nodes are normally connected by their occurence in the dfs script.

```dfs
|node1()
|node2()

```
node1 is connected to node2

```dfs

def s1 =
|node1()
|node1_1

def s2 =
|node2()
|node2_1()

s1|combine(s2)

```