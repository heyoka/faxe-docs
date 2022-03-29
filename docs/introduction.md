# Intro

DFS is quite simple and limited in some ways as a 'language', of course because it is not a language but a DSL.
And this is intended.

To get started, we look at some concepts to deal with, when writing dfs scripts.




## Data

## Strings and References

Unlike what is possible in some programming languages, 
where you can use two different string notations: `'a string'` or `"also a string"`,
in DFS these two notations have a completely different meaning.

In DFS, single quotes are used for strings

```dfs 
'faxe is canned beer' 

'baseField.subField'
```

or for text

```dfs 
'
    SELECT * 
    FROM table 
    ORDER BY timestamp
    LIMIT 5;
'   
```




Double quotes are used for references and are used only in lambda-expressions, 
to retrieve the value of the specified field from the current data-point.

```dfs 
lambda: "data.value" > 3  
```

Return whether the value at `data.value` is greater than 3.


## Lambda expressions

## Rest Api

## How nodes are connected