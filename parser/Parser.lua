local AST = require("parser.structs.AST.AST") -- Import the AST class
Parser = {}
Parser.__index = Parser

-- Constructor for creating a new Parser object
function Parser:new(scanning_device)
    local parser = {
        scanning_device = scanning_device,
        current_token = scanning_device[1]:getValue(),
        index = 1
    }
    setmetatable(parser, Parser)
    return parser
end

-- Method to parse the scanning device and generate an AST
function Parser:parse()
    -- If the scanning device is empty, return an empty AST --
    if #self.scanning_device == 0 then
        return AST:new("PROGRAM")
    end
    local ast = AST:new("PROGRAM")
    local current_node = ast
    ::continue::
    while self.index <= #self.scanning_device do
        local token = self.scanning_device[self.index]:getValue()

        if self.index == 1 and token ~= "ON" then
            return error("Invalid program header. Program must start with 'ON'");
        end

        -- Program headers --
        if token == "ON" or token == "OFF" then
            if token == "OFF" then
                ast:append(token)
            else
                current_node = current_node:append(token)
            end
            self.index = self.index + 1
            goto continue
        end

        -- if self.index == 2 and token ~= "tri" or token ~= "sqr" then
        --     return error(
        --         "There must be a built-in function after the program header. Built-in functions must be either 'tri' or 'sqr'");
        -- end

        -- Program built-in functions --
        if token == "tri" or token == "sqr" then
            current_node = current_node:append(token)
            self.index = self.index + 1
            -- Handle other cases (which can only be coordinates and alphanumeric characters) --
            local x = self.scanning_device[self.index]:getX()
            local y = self.scanning_device[self.index]:getY()
            current_node = current_node:append("COORDINATES")
            current_node:append(x)
            current_node:append(y)

            self.index = self.index + 1
            goto continue
        end
        self.index = self.index + 1
    end
    return ast
end

return Parser
