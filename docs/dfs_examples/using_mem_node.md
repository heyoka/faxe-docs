## mem node

Using the [mem](../nodes/mem.md) node standalone with predefined data as a lookup table.



```dfs  
def default_map = 
    <<<{"key1":"topic/1/new", "key2":"topic/2/new", "key3":"topic/3/new"}>>>

%% setup the mem node with the json-map, we can reference this map later in lambda expressions with
%% the key `topic_lookup`
|mem() 
.key('topic_lookup')
.default(default_map)
.default_json()




```