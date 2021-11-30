Macros are a way to reuse often used parts and to build more complex scripts more easy.

Every task that is registered with `faxe` can be used as a macro-script.

Note: Macros are implemented on the script-level, so faxe's internal engine does not know anything about macros.

```dfs
%%% MACRO called 'multiply_above_threshold'
def threshold = 30
def factor = 2
|where(lambda: "value" > threshold)
|eval(lambda: "value" * factor)
.as('multiple')

```

Once the above dfs script is registered with faxe, we can use it as a macro:

```dfs
|value_emitter()
.every(500ms) 

||multiply_above_threshold()
.threshold(2.7)
 

```

A macro is referenced with a double pipe symbol `||`, followed by the name of the task which we want to use as macro.

The resulting script will look like this:

```dfs
|value_emitter()
.every(500ms) 

def threshold = 2.7
def factor = 2
|where(lambda: "value" > threshold)
|eval(lambda: "value" * factor)
.as('multiple')

```

We can override every literal declaration within the macro-script by simply using them as node-parameters.
Ie: here the declaration 'threshold' is overriden, we could also override 'factor'.

Theoretically any number of macro-references `||dfs_script_name` can be used in a single dfs-script.
Furthermore every macro used in a script can itself reference any number of macros, as every macro-script is an ordinary
dfs-script registered in `faxe`.
