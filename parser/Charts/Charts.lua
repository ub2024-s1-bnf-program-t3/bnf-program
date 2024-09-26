local Charts = {}
Charts.__index = Charts

function Charts:new(ast)
    local charts = {
        tree = ast,
        line = {},
        current_node = nil,
        current_childn_o = {},
        index = 0,
        index_length = 0
    }
    setmetatable(charts, Charts)
    return charts
end

function Charts:append_line(value)
    table.insert(self.line, value)
end

function Charts:traverse_node(node, reference_to)
    if not node then return end
    print("Hi", node, reference_to)
    reference_to = reference_to or 0

    -- Create a string for all the current children's values of the node we're in
    local children_values = {}
    for _, child in ipairs(node.children) do
        table.insert(children_values, child.value)
        -- print("Node value: " .. child.value)
    end

    
    local amount_of_separation = reference_to;
    -- print("Amount of separation", amount_of_separation)
    local inserts = string.rep("--", amount_of_separation) -- Amount of branch separation to create
    local spaces_inserts = string.gsub(inserts, "-", " "); -- Amount of spaces to skip
    spaces_inserts = spaces_inserts .. string.rep(" ", self.index_length) -- Amount of spaces to skip
    local branch = ""
    -- Print the starting line (connector)
    if reference_to > 0 then
        -- amount of tabs required is equal to reference to
        -- local amount_of_tabs = reference_to
        -- local prefix = string.rep("  ", amount_of_tabs) -- Amount of spaces to skip
        -- prefix = spaces_inserts .. prefix .. "│"
        local prefix = spaces_inserts .. "│"
        table.insert(self.line, prefix);
    end
    if #node.children == 1 then
        branch = spaces_inserts .. "┬"
    end
    if #node.children >= 2 then
        branch = "┌──" -- The full branch
    end

    if #node.children >= 2 then
        for i, child in ipairs(node.children) do
            -- Are we at the last child?
            if i == #node.children then
                break
            end
            -- Find the length of the child value
            local child_value_length = string.len(child.value)
            local inserts = string.rep("-", child_value_length)
            branch = branch .. inserts .. "──┐" -- Extend the branch out further
        end
    end

    if #node.children >= 1 then
        table.insert(self.line, branch);                   -- Insert the branch
    end
    local children_values_str = table.concat(children_values, spaces_inserts);
    table.insert(self.line, children_values_str);          -- Insert the children values


    -- Get the index of the current node's value inside of children_values
    if node.value then
        for index, child in ipairs(self.current_childn_o) do
            if self.current_node == nil then
                break
            end
            print("Value", child, self.current_node.value, index)
            if child == self.current_node.value then
                print("Value (2)", child, self.current_node.value, index)
                print("INdex", index)
                self.index = index
                self.index_length = string.len(self.current_node.value)
                break
            end
        end
    end
    self.current_childn_o = children_values;
    -- Continue traversing the tree (left-to-right)
    for i, child in ipairs(node.children) do
        if child then
            -- if self.index then
            self.current_node = child
            self:traverse_node(child, self.index or 0)     -- Center aligned
            -- end
        else
            print("Error: root_node is nil")
        end
    end
end

function Charts:print()
    -- Run through the tree and print the values
    local root_node = self.tree:getRoot()
    if root_node then
        self:traverse_node(root_node, 2) -- Center aligned
    else
        print("Error: root_node is nil")
    end
    -- Print out everything that's in `line` table
    for i, line in ipairs(self.line) do
        print(line)
    end
end

return Charts
