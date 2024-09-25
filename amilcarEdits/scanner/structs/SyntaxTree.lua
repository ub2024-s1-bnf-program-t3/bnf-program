local Keyword = require("scanner.structs.Keyword")


-- Define the SyntaxTree class
SyntaxTree = {}
SyntaxTree.__index = SyntaxTree

-- Constructor for SyntaxTree
function SyntaxTree:new(keywords, instructions, operators)
    assert(keywords and type(keywords) == "table" and keywords.__index == Keyword.__index, "keywords must be an instance of Keyword")
    assert(instructions and type(instructions) == "table", "instructions must be a table")
    assert(instructions.Subprogram and type(instructions.Subprogram) == "table", "instructions must contain a Subprogram array")
    assert(instructions.xy and type(instructions.xy) == "table", "instructions must contain an xy array")
    assert(operators and type(operators) == "table", "operators must be an array of instances of Operators")

    local instance = setmetatable({}, SyntaxTree)
    instance.keywords = keywords
    instance.instructions = instructions
    instance.operators = operators
    return instance
end

-- Example usage
-- Assuming Keyword, Subprogram, xy, and Operators are defined elsewhere
-- local keywords = Keyword:new()
-- local instructions = { Subprogram = {Subprogram:new()}, xy = {xy:new()} }
-- local operators = {Operators:new()}
-- local syntaxTree = SyntaxTree:new(keywords, instructions, operators)

return SyntaxTree