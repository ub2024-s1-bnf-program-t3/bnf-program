local Scanner = require("scanner.Scanner")
local Parser = require("parser.Parser")
local Derivator = require("derivator.Derivator")
local scanner = Scanner:new()

local function getInput()
    io.write("Enter your input (or type 'HALT' to quit): ")
    return io.read()
end

while true do
    ::continue::
    print("\n--- BNF Context-Free Grammar REPL ---")
    print("Welcome to the BNF Context-Free Grammar REPL!")
    print("You can input strings that follow a variation of BNF grammar, and this program will scan, parse, and derive them.\n")
    print("The grammar rules are as follows:")
    print("<proc>         → ON <body> OFF")
    print("<instructions> → <line> | <line> - <instructions>")
    print("<line>         → sqr <xy>,<xy> | tri <xy>,<xy>,<xy>")
    print("<xy>           → <x><y>")
    print("<x>            → a | b | c | d | e | f")
    print("<y>            → 1 | 2 | 3 | 4 | 5 | 6\n")
    print("Example input: ON sqr b3,e5 - tri c3,a1,f6 OFF")
    print("You can always type 'HALT' to exit.\n")
    
    local input = getInput()
    if input == "HALT" then
        print("Exiting the program. Goodbye!")
        break
    end

    local scanning_device = scanner:scan(input)

    -- If scanning fails, prompt the user to try again
    if #scanning_device == 0 then
        print("\nError: Unable to scan the input. Please ensure it follows the grammar rules.")
        goto continue
    end

    print("\n--- Scanning Results ---")
    for i = 1, #scanning_device do
        print("Token: " .. scanning_device[i]:getValue())
    end
    print("--- End of Scanning Results ---\n")

    -- Pass the scanning device to the parser
    local parser = Parser:new(scanning_device, input)
    local ast = parser:parse()

    -- If parsing fails, prompt the user to try again
    if ast == -1 then
        print("\nError: Parsing failed. Please check your input for correctness.")
        goto continue
    end

    -- Derivation process
    print("\n--- Derivation Process ---")
    local derivator = Derivator:new(parser, ast)
    derivator:new_derivation()
    print("--- End of Derivation ---\n")

    -- Wait for the user to press Enter to display the AST
    io.write("Press Enter to display the Abstract Syntax Tree (AST)...")
    io.read() -- wait for Enter key press

    print("\n--- Abstract Syntax Tree (AST) ---")
    ast:print()
    print("--- End of AST ---\n")

    -- Ask the user if they want to try another input or halt
    io.write("Type 'HALT' to exit, or press Enter to try another input: ")
    local answer = io.read():upper()

    if answer == "HALT" then
        print("Exiting the program. Goodbye!")
        break
    end
end