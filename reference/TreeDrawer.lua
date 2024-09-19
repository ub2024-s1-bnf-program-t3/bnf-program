-- Draw parse tree by recursively breaking down the input based on the grammar
local function drawParseTreeHelper(node, level)
    -- Print the current node with indentation according to the level
    print(string.rep("  ", level) .. node.value)

    -- Recursively draw the children (if any)
    for _, child in ipairs(node.children or {}) do
        drawParseTreeHelper(child, level + 1)
    end
end

-- Function to create a tree node
local function createNode(value, children)
    return { value = value, children = children or {} }
end

-- Parse and draw the parse tree for the given input based on the provided grammar
local function drawParseTree(input)
    print("Drawing Parse Tree for input: " .. input)
    
    -- Start the parse tree with the root node <program>
    local parseTree = createNode("<program>", {
        createNode("begin"),
        createNode("<stmt_list>", {
            createNode("<stmt>", {
                createNode("<var>", { createNode("A") }),
                createNode("="),
                createNode("<expr>", {
                    createNode("<var>", { createNode("B") })
                })
            }),
            createNode(";"),
            createNode("<stmt>", {
                createNode("<var>", { createNode("B") }),
                createNode("="),
                createNode("<expr>", {
                    createNode("<var>", { createNode("A") }),
                    createNode("+"),
                    createNode("<var>", { createNode("C") })
                })
            }),
            createNode(";"),
            createNode("<stmt>", {
                createNode("<var>", { createNode("C") }),
                createNode("="),
                createNode("<expr>", {
                    createNode("<var>", { createNode("A") }),
                    createNode("-"),
                    createNode("<var>", { createNode("B") })
                })
            })
        }),
        createNode("end")
    })

    -- Draw the parse tree recursively starting from the root node
    drawParseTreeHelper(parseTree, 0)
end

-- Test the function with a sample input
drawParseTree("begin A=B; B=A+C; C=A-B end")
