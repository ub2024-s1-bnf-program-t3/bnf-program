local Scanner = require("scanner.Scanner")
local Parser = require("parser.Parser")
local Derivator = require("derivator.Derivator")
local scanner = Scanner:new()

local function getInput()
    io.write("Enter input to scan: ")
    return io.read()
end

while true do
    ::continue::
    print("\n--- REPL ---")
    print("Welcome to the BNF Context-Free REPL!\n")
    print("The following are the rules for this variation of the BNF grammar:\n")
    print("<proc> → ON <body> OFF")
    print("<instructions> → <line> | <line> - <instructions>")
    print("<line> → sqr <xy>,<xy> | tri <xy>,<xy>,<xy>")
    print("<xy> → <x><y>")
    print("<x> → a | b | c | d | e | f")
    print("<y> → 1 | 2 | 3 | 4 | 5 | 6")
    print("\n\nAnd here is an example of an accepted string to try out: \"ON sqr b3,e5 - tri c3,a1,f6 OFF\"")
    print("Note you can always enter 'HALT' to exit the program.\n\nEnjoy!\n")
    local input = getInput()
    if input == "HALT" then
        break
    end
    local scanning_device = scanner:scan(input)
    -- print(scanning_device)
    -- Go through the array array and print the values
    if (#scanning_device == 0) then
        print("Error in scanning. Please check your input.")
        goto continue
    end
    print("--- Scanning device values ---")
    for i = 1, #scanning_device do
        print(scanning_device[i]:getValue())
    end
    print("--- End of scanning device values ---")

    -- Pass the scanning device to the parser --
    local parser = Parser:new(scanning_device, input)
    local ast = parser:parse()
    -- Print the AST for debugging purposes
    if ast ~= -1 then
        print("--- AST ---")
        ast:print()
        print("--- End of AST ---")
    end
    if ast == -1 then
        print("Error in parsing")
        goto continue
    end
    print("--- Derivation ---")
    local derivator = Derivator:new(parser, ast)
    derivator:new_derivation()
    print("--- End of Derivation ---")
end
