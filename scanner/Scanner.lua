local Keyword = require("scanner.structs.Keyword")
local xy = require("scanner.structs.xy")                 -- Import the xy class
local Subprogram = require("scanner.structs.Subprogram") -- Import the Subprogram class
local Separator = require("scanner.structs.Separator")   -- Import the Separator class
local ScannerErrors = require("scanner.errors.ScannerErrors")

Scanner = {}

function Scanner:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Scanner:scan(input)
    -- Array for storing the scanner output
    local output = {}
    
    -- Scan the input and return the SyntaxTree
    local i = 1
    while i <= #input do
        ::continue_loop::
        -- print("Current character: " .. input:sub(i, i))
        -- print("Current index: " .. i)
        -- Is this the end of the input?
        if i >= #input then
            -- print("End of input reached")
            break
        end
        local char = input:sub(i, i)

        -- Check if the character is a '-'
        if char == "-" then
            -- print("Separator sign found")
            -- Append to the scanner output
            table.insert(output, Separator:new(char))
            i = i + 1
            goto continue_loop
        end

        -- Check if the character is a space
        if char == " " or char == "," then
            -- print("Space skipped over")
            i = i + 1
            goto continue_loop
        elseif char == "a" or char == "b" or char == "c" or char == "d" or char == "e" or char == "f" then
            if i < #input then
                local nextChar = input:sub(i + 1, i + 1)
                local nextCharCheck = {
                    ["1"] = function()
                        i = i + 2 -- Skip the space
                        return xy:new(char, 1)
                    end,
                    ["2"] = function()
                        i = i + 2 -- Skip the space
                        return xy:new(char, 2)
                    end,
                    ["3"] = function()
                        i = i + 2 -- Skip the space
                        return xy:new(char, 3)
                    end,
                    ["4"] = function()
                        i = i + 2 -- Skip the space
                        return xy:new(char, 4)
                    end,
                    ["5"] = function()
                        i = i + 2 -- Skip the space
                        return xy:new(char, 5)
                    end,
                    ["6"] = function()
                        i = i + 2 -- Skip the space
                        return xy:new(char, 6)
                    end
                }
                local func = nextCharCheck[nextChar]
                if func then
                    local retVal = func(i)
                    print("Token: " .. retVal:getValue())
                    -- Append to the scanner output
                    table.insert(output, retVal)
                    -- return retVal -- Bubble upwards
                else
                    ScannerErrors.CharacterError(input, nextChar, i, "token")
                    break
                end
            end
        elseif char == "s" or char == "t" then
            if i < #input then
                local nextChar = input:sub(i + 1, i + 1)
                local nextCharCheck = {
                    q = function()
                        -- Check if the character after q is r
                        local afterChar = input:sub(i + 2, i + 2)
                        if afterChar == "r" then
                            i = i + 3 -- Skip the space
                            return Subprogram:new("sqr")
                        else
                            return -1
                        end
                    end,
                    r = function()
                        -- Check if the character after r is i
                        local afterChar = input:sub(i + 2, i + 2)
                        if afterChar == "i" then
                            i = i + 3 -- Skip the space
                            return Subprogram:new("tri")
                        else
                            return -1
                        end
                    end
                }
                local func = nextCharCheck[nextChar]
                if not func then
                    ScannerErrors.CharacterError(input, nextChar, i, "character")
                    break
                end
                local func_val = func()
                if func_val ~= -1 then
                    print("Next character is S, or T")
                    -- Append to the scanner output
                    table.insert(output, func_val)
                    -- return func_val -- Bubble upwards   
                else
                    ScannerErrors.CharacterError(input, nextChar, i, "character")
                    break
                end
            end
            -- print("Space skipped over")
            -- elseif not validChars[char] then
            --     -- Just log the error
            --     return print("[SQR/TRI]: Invalid character found: " .. char)
            --     -- end
        elseif char == "O" then
            local nextChar = input:sub(i + 1, i + 1)
            local nextCharCheck = {
                N = function()
                    i = i + 2 -- Skip the space
                    return Keyword:new("ON")
                end,
                F = function()
                    -- Check if character after F is F
                    local afterChar = input:sub(i + 2, i + 2)
                    if afterChar == "F" then
                        i = i + 3 -- Skip the space
                        return Keyword:new("OFF")
                    else
                        ScannerErrors.CharacterError(input, nextChar, i, "character")
                        return -1
                    end
                end
            }
            local func = nextCharCheck[nextChar]
            if func then
                local retVal = func(i)
                -- print(retVal == -1 and "Scan failed" or "Keyword: " .. retVal:getValue())
                if retVal == -1 then
                    break
                else
                    -- Append to the scanner output
                    table.insert(output, retVal)
                    -- return retVal -- Bubble upwards
                end
            else
                ScannerErrors.CharacterError(input, nextChar, i, "character")
                break
            end
        else
            print(input)
            -- Get the index of nextChar
            local nextCharIndex = input:find(char, i)
            local spaces = string.rep(" ", nextCharIndex - 1) -- Get the spaces before the nextChar
            print(spaces .. "^ [SCANNER]: Invalid character found: " .. char)
            break
        end
        -- Assuming the SyntaxTree class is defined elsewhere
        -- return SyntaxTree:new()
    end
    return output
end

return Scanner
