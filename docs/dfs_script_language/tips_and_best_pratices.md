# DFS Script Language tips and best pratices

### Variables

Ok, they are unmutable really, so we call them declarations.

```dfs
def stream_id = 'ee29e1f8552e4a2561329fec59688e60'
```

When using declarations in DFS script you should stick to one type of naming schema. Be it CamelCase naming or
all lowercase with underscores like in the example above.

### Lambda expressions

As a rule we say: Avoid lambda expressions, if you can achieve your goal without them. Of course you cannot do everything without
lambda expression, as many nodes require them to work.

### 
