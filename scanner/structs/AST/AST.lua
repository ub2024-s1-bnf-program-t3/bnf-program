-- AST.lua

local AST = {}
AST.__index = AST

-- Constructor for creating a new AST node
function AST:new(value)
    local node = {
        value = value,
        children = {}
    }
    setmetatable(node, AST)
    return node
end

-- Method to append a child node to the current node
function AST:append(value)
    local child = AST:new(value)
    table.insert(self.children, child)
    return child
end

-- Method to print the AST for debugging purposes
function AST:print(level)
    level = level or 0
    local prefix = string.rep("  ", level)
    print(prefix .. self.value)
    for _, child in ipairs(self.children) do
        child:print(level + 1)
    end
end

return AST