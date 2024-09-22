local ast = require("parser.structs.AST.AST")
Derivator = {}
-- Use the AST to create a right-recursive derivation tree

Derivator.__index = Derivator
local last_traversal_string = ""

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

-- Recursive function to traverse the AST and generate derivation steps using right-to-left preorder traversal
local function traverse_node(node, steps)
    if not node then return end
    -- Create a string for all the current children's values of the node we're in
    local children_values = {}
    for _, child in ipairs(node.children) do
        table.insert(children_values, child.value)
    end
    -- Check if these children contain the string "<x>" and "<y>"
    -- If it does we need to concatenate the children's values without any spaces
    local children_str_nospace = table.concat(children_values, "")
    local children_str = ""
    if children_str_nospace:find("<x>") ~= nil and children_str_nospace:find("<y>") ~= nil then
        children_str = children_str_nospace
    else
        children_str = table.concat(children_values, " ")
    end
    -- local children_str = node.value
    if children_str ~= "" then
        -- ON tri a1, a2, d4 - sqr a1, d2 - tri b1, b2, c3 OFF --
        -- print("Ignoring " .. ignore_traversal_N .. " replacements")
        -- print("Children string: " .. children_str)

        -- Check if the children_str is a non-terminal value
        -- if children_str:find("<") == nil then
        --     -- If the children_str is a non-terminal value, then we need to ignore the next N traversal strings
        --     ignore_traversal_N = 1
        -- elseif ignore_traversal_N > 0 then
        --     ignore_traversal_N = 0
        -- end

        -- Replace the last (terminal) value in the traveral string that is surrounded by "<>" with the children string
        -- ON tri a1, a2, d4 - sqr a1, d2 - tri b1, b2, c3 OFF
        if last_traversal_string == "" then
            last_traversal_string = children_str
            table.insert(steps, last_traversal_string)
        else
            -- last_traversal_string = last_traversal_string:gsub("<[^<>]*>(?!.*<[^<>]*>)", children_str)
            -- Find the last occurrence of a substring enclosed in angle brackets
            local last_reversal = last_traversal_string:reverse()
            -- print("Last traversal string: " .. last_reversal)
            last_reversal = string.match(last_reversal, ">[^<>]*<")
            if last_reversal ~= nil then
                -- print("Last reversal: " .. last_reversal)
                -- last_reversal = last_reversal:reverse()
                -- print("Last traversal string (1): " .. last_traversal_string)
                -- Make the replacement
                last_traversal_string = last_traversal_string:reverse()
                last_traversal_string = last_traversal_string:gsub(last_reversal, children_str:reverse(), 1)
                -- print("Last traversal string (2): " .. last_traversal_string)
                last_traversal_string = last_traversal_string:reverse()
                -- string.match (testvar:reverse(), "(%d+%.?%d*)"):reverse()
                -- string.match (testvar, ".*%f[%d.](%d*%.?%d+)")

                -- last_traversal_string = last_traversal_string:sub(1, last_match_end - 1) .. children_str .. last_traversal_string:sub(last_match_end + 1)
                -- end
                table.insert(steps, last_traversal_string)
            end
        end
        -- table.insert(steps, children_str)
    end

    -- table.insert(steps, derivation .. " " .. node.value)
    for i = #node.children, 1, -1 do
        local child = node.children[i]
        traverse_node(child, steps)
    end
end

-- Method to derive the AST and generate a derivation tree
function Derivator:new_derivation()
    last_traversal_string = ""  -- Reset the last traversal string
    local root_node = self.ast:getRoot()
    local steps = {}
    traverse_node(root_node, steps)
    for i, step in ipairs(steps) do
        print(string.format("%02d → %s", i, step))
    end
end

return Derivator
