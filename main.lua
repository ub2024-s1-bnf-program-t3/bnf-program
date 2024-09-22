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
    print("Enter 'HALT' to exit the program")
    local input = getInput()
    if input == "HALT" then
        break
    end
    local scanning_device = scanner:scan(input)
    -- print(scanning_device)
    -- Go through the array array and print the values
    if(#scanning_device == 0) then
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
    print("--- AST ---")
    if ast ~= -1 then
        ast:print()
    end
    print("--- End of AST ---")
    print("--- Derivation ---")
    if ast == -1 then
        print("Error in parsing")
        goto continue
    end
    local derivator = Derivator:new(parser, ast)
    derivator:new_derivation()
    print("--- End of Derivation ---")
end
