local ast = require("parser.structs.AST.AST")
Derivator = {}
-- Use the AST to create a right-recursive derivation tree

Derivator.__index = Derivator

-- Constructor for creating a new Derivator object
function Derivator:new(parser, ast)
    local derivator = {
        parser = parser,
        ast = ast,
        index = 1
    }
    setmetatable(derivator, Derivator)
    return derivator
end

-- Recursive function to traverse the AST and generate derivation steps
local function traverse_node(node, derivation, steps)
    if not node then return end
    table.insert(steps, derivation .. " " .. node.value)
    for _, child in ipairs(node.children) do
        traverse_node(child, derivation .. " " .. (node.value == "<proc>" and node.value .. " →" or node.value), steps)
    end
end

-- Method to derive the AST and generate a derivation tree
function Derivator:new_derivation()
    local root_node = self.ast:getRoot()
    local root_node = root_node.children[1] -- Skip the <proc> node since we seemingly only want the statement list
    local steps = {}
    traverse_node(root_node, "<proc> → ON", steps)
    for i, step in ipairs(steps) do
        print(string.format("%02d → %s OFF", i, step))
    end
end

return Derivator
