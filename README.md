# bnf-program
## BNF Context-Free Grammar REPL

You can input strings that follow a variation of BNF grammar, and this program will scan, parse, and derive them.

The grammar rules are as follows:

```
<proc>         → ON <body> OFF
<instructions> → <line> | <line> - <instructions>
<line>         → sqr <xy>,<xy> | tri <xy>,<xy>,<xy>
<xy>           → <x><y>
<x>            → a | b | c | d | e | f
<y>            → 1 | 2 | 3 | 4 | 5 | 6
```

Example input: `ON sqr b3,e5 - tri c3,a1,f6 OFF`

You can always type `HALT` to exit.


## Running the program
This program was originally written in Lua 5.3.3, but I'm guessing it will work on other Lua versions (5.x.x)
Once you have Lua on your system, you can run it using the following command:

```shell
lua main.lua
```

## Brief overview of code

`derivator`       -> Contains code for doing a right derivation of the parsed input (inside of the AST)

`parser`          -> Contains code for parsing the input from the scanner to create an AST

`parser/charts`   -> Contains code for creating a primitive ASCII tree, representing what is inside of the AST

`scanner`         -> Contains code for scanning and filtering the user input

`scanner/structs` -> Contains the types used in helping the scanner in detecting what was inputted

`main.py`         -> Ties everything together into a text-based frontend


Repository link: https://github.com/ub2024-s1-bnf-program-t3/bnf-program
