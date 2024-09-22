local AST = require("parser.structs.AST.AST")              -- Import the AST class
local Scanner = require("scanner.Scanner")                 -- Import the Scanner module
local ParserErrors = require("parser.errors.ParserErrors") -- Import the ParserErrors module
local xy = require("scanner.structs.xy")                   -- Import the xy class
Parser = {}
Parser.__index = Parser
Input = nil

-- Constructor for creating a new Parser object
function Parser:new(scanning_device, input)
    assert(scanning_device, "Invalid scanning device")
    assert(scanning_device.__index ~= Scanner, "Invalid scanning device")
    local parser = {
        scanning_device = scanning_device,
        current_token = scanning_device[1]:getValue(),
        index = 1
    }
    setmetatable(parser, Parser)
    Input = input
    return parser
end

-- Method to parse the scanning device and generate an AST
function Parser:parse()
    -- If the scanning device is empty, return an empty AST --
    if #self.scanning_device == 0 then
        return AST:new("<proc>")
    end
    local ast = AST:new("<proc>")
    local root_node = ast
    local statement_list_node = nil
    local current_node = statement_list_node
    local at_program_end = false
    ::continue::
    while self.index <= #self.scanning_device + 1 do
        -- Check if we're at the end of the program --
        if self.index == #self.scanning_device + 1 and at_program_end ~= true then
            return error("Invalid program footer. Expected 'OFF' at the end of the program");
        elseif self.index == #self.scanning_device + 1 and at_program_end == true then
            break
        end

        local token = self.scanning_device[self.index]:getValue()
        if self.index == 1 and token ~= "ON" then
            return error("Invalid program header. Program must start with 'ON'");
        end

        -- Program headers --
        if token == "ON" or token == "OFF" then
            if self.index > 1 and token == "ON" then
                return error("Invalid program header. Program header must be at the beginning of the program");
            end
            if at_program_end ~= true and token == "OFF" then
                at_program_end = true
            elseif at_program_end == true and token == "OFF" then
                return error("Invalid program footer. Expected ONLY ONE 'OFF' at the end of the program");
            end
            root_node:append(token) -- Prioritize the program header to the root node before moving to the instructions
            if token == "ON" then
                current_node = root_node:append("<instructions>")
                statement_list_node = current_node
            end
            self.index = self.index + 1
            goto continue
        end

        -- Line separators --
        if token == "-" then
            -- Check token ahead --
            local ahead = self.scanning_device[self.index + 1]:getValue()
            if ahead == "-" then
                ParserErrors.CharacterError(Input, "-", self.index,
                    "[WW]: Syntax warning. Expected a built-in function after '-'")
            end
            if statement_list_node == nil then
                return error("Syntax error. Expected a built-in function after the program header");
            end
            -- Current node should start again at index 1 --
            current_node = statement_list_node
            current_node:append(token)
            statement_list_node = current_node:append("<instructions>")
            current_node = statement_list_node
            self.index = self.index + 1
            goto continue
        end

        if self.index == 2 and token ~= "tri" and token ~= "sqr" then
            return error(
                "There must be a built-in function after the program header. Built-in functions must be either 'tri' or 'sqr'");
        end

        if self.index > 2 and token == "tri" or self.index > 2 and token == "sqr" then
            local behind = self.scanning_device[self.index - 1]:getValue();
            if behind ~= '-' then
                return error("Syntax error. Expected '-' before built-in function.");
            end
        end

        -- Program built-in functions --
        if token == "tri" or token == "sqr" then
            current_node = current_node:append("<line>")
            local hooked_node = current_node
            current_node = current_node:append(token)
            self.index = self.index + 1
            local loop_count = token == "tri" and 3 or 2
            for i = 1, loop_count do
                current_node = hooked_node
                local token = self.scanning_device[self.index + i - 1]
                -- Check if token is nil --
                if not token then
                    return ParserErrors.CharacterError(Input, self.scanning_device[self.index - 1]:getValue(), self
                        .index,
                        "[EE]: Syntax error. Expected an additional coordinate after built-in function.\nAdditionally, an EOF was unexpectedly reached.")
                end
                if token.__index ~= xy then -- If token is not a coordinate
                    return ParserErrors.CharacterError(Input, self.scanning_device[self.index - 1]:getValue(), self
                        .index,
                        "[EE]: Syntax error. Expected an additional coordinate after built-in function")
                end
                -- Handle other cases (which can only be coordinates and alphanumeric characters) --
                local x = token:getX()
                local y = token:getY()
                current_node = current_node:append("<xy>")
                local last_node = current_node
                current_node = current_node:append("<x>")
                current_node:append(x)
                current_node = last_node:append("<y>")
                current_node:append(y)
            end
            self.index = self.index + 1
        end
        self.index = self.index + 1
    end
    return ast
end

return Parser
