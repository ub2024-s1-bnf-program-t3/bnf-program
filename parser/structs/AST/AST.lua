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

-- Method to print the AST in a tree-like format
function AST:print(level, is_last)
    level = level or 0
    is_last = is_last or true
    local prefix = string.rep("  ", level)

    -- Print the current node with a connecting branch
    if level > 0 then
        local branch = is_last and "└── " or "├── "
        prefix = string.rep("│   ", level - 1) .. branch
    end

    print(prefix .. self.value)

    -- Recursively print child nodes
    for i, child in ipairs(self.children) do
        local last_child = i == #self.children
        child:print(level + 1, last_child)
    end
end

-- Method to get the root node of the AST
function AST:getRoot()
    return self
end

return AST