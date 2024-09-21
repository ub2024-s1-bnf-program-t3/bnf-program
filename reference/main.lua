local parser = require("parser.Parser")
local treeDrawer = require("TreeDrawer")

local function main()
    -- Logic to display BNF grammar and take user input
    while true do
        print("Enter an input string (or 'HALT' to terminate):")
        local input = io.read()
        
        if input == "HALT" then
            break
        end
        
        if parser.isValidExpression(input) then
            print("Derivation successful!")
            parser.rightmostDerivation(input)
            treeDrawer.drawParseTree(input)
        else
            print("Error: Invalid input string.")
        end
    end
end

main()
