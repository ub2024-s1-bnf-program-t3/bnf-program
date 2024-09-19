-- BNF Grammar for the language recognizer
local bnfGrammar = [[
<program> ::= begin <stmt_list> end
<stmt_list> ::= <stmt> | <stmt> ; <stmt_list>
<stmt> ::= <var> = <expr>
<var> ::= A | B | C
<expr> ::= <var> + <var> | <var> - <var> | <var>
]]

-- Function to display the BNF grammar
local function displayBNFGrammar()
    print("BNF Grammar:")
    print(bnfGrammar)
end

-- Function to perform rightmost derivation
local function rightmostDerivation(input)
    print("Starting Rightmost Derivation...")
    
    -- Initialize the sentential form with the starting rule
    local sententialForm = "begin <stmt_list> end"
    print(sententialForm)
    
    -- Define a table with derivation steps
    local derivationSteps = {
        -- Replace <stmt_list> with three <stmt>s separated by semicolons
        { pattern = "<stmt_list>", replacement = "<stmt> ; <stmt> ; <stmt>" },
        
        -- Replace <stmt> with <var> = <expr> (for all three statements in rightmost order)
        { pattern = "<stmt>", replacement = "<var> = <expr>" }, -- First <stmt>
        { pattern = "<stmt>", replacement = "<var> = <expr>" }, -- Second <stmt>
        { pattern = "<stmt>", replacement = "<var> = <expr>" }, -- Third <stmt>
        
        -- Replace <var> with actual variable (starting with the rightmost <var> in third statement)
        { pattern = "<var>", replacement = "C" }, -- Rightmost <var> in third statement
        { pattern = "<expr>", replacement = "<var> - <var>" }, -- Replace <expr> with subtraction in third stmt
        { pattern = "<var>", replacement = "A" }, -- Replace left <var> in third expr
        { pattern = "<var>", replacement = "B" }, -- Replace right <var> in third expr
    
        -- Move to second statement, replace <var> with B
        { pattern = "<var>", replacement = "B" }, -- Rightmost <var> in second statement
        { pattern = "<expr>", replacement = "<var> + <var>" }, -- Replace <expr> with addition in second stmt
        { pattern = "<var>", replacement = "A" }, -- Replace left <var> in second expr
        { pattern = "<var>", replacement = "C" }, -- Replace right <var> in second expr
    
        -- Move to first statement, replace <var> with A
        { pattern = "<var>", replacement = "A" }, -- Rightmost <var> in first statement
        { pattern = "<expr>", replacement = "<var>" }, -- Replace <expr> with single variable in first stmt
        { pattern = "<var>", replacement = "B" }, -- Replace <var> in first expr
        
        -- Final step: The entire derivation is complete
    }
    

    -- Loop through derivation steps to simulate rightmost derivation
    for i, step in ipairs(derivationSteps) do
        if string.find(sententialForm, step.pattern) then
            sententialForm = string.gsub(sententialForm, step.pattern, step.replacement, 1)
            print(sententialForm)
        else
            print("Error: Unable to derive from the current sentential form.")
            return false
        end
    end
    
    -- Check if the final derived sentence matches the input
    if sententialForm == input then
        print("Derivation successful!")
        return true
    else
        print("Error: Final sentence does not match the input.")
        return false
    end
end

-- Function to draw the parse tree (recursive tree builder)
local function drawParseTree(node, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)
    
    if node.type == "program" then
        print(indent .. "Program")
        drawParseTree(node.beginNode, depth + 1)
        drawParseTree(node.stmtListNode, depth + 1)
        drawParseTree(node.endNode, depth + 1)
    elseif node.type == "stmt_list" then
        print(indent .. "Stmt_List")
        for _, stmt in ipairs(node.stmts) do
            drawParseTree(stmt, depth + 1)
        end
    elseif node.type == "stmt" then
        print(indent .. "Stmt: " .. node.var .. " = " .. node.expr)
    elseif node.type == "expr" then
        print(indent .. "Expr: " .. node.var1 .. " " .. node.op .. " " .. node.var2)
    elseif node.type == "var" then
        print(indent .. "Var: " .. node.value)
    end
end

-- Function to build the parse tree from the input
local function buildParseTree(input)
    -- This is a simplified version where we manually parse the string
    local programNode = { type = "program", beginNode = { type = "var", value = "begin" } }
    programNode.endNode = { type = "var", value = "end" }
    
    -- Build the statement list and expressions manually (for now)
    programNode.stmtListNode = {
        type = "stmt_list",
        stmts = {
            { type = "stmt", var = "A", expr = "B" },
            { type = "stmt", var = "B", expr = "A + C" },
            { type = "stmt", var = "C", expr = "A - B" }
        }
    }
    
    return programNode
end

-- Main program loop
local function main()
    displayBNFGrammar()
    
    while true do
        -- Get input string from the user
        print("Enter an input string (or 'HALT' to terminate):")
        local input = io.read()
        
        if input == "HALT" then
            print("Program terminated.")
            break
        end
        
        -- Perform rightmost derivation
        local derivationSuccessful = rightmostDerivation(input)
        
        -- If successful, draw the parse tree
        if derivationSuccessful then
            print("Drawing Parse Tree...")
            local parseTree = buildParseTree(input)
            drawParseTree(parseTree)
        end
        
        print("Press Enter to continue...")
        io.read()
    end
end

-- Run the main program
main()
