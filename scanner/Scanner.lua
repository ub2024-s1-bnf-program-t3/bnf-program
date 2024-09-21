local SyntaxTree = require("scanner.structs.SyntaxTree")
local Keyword = require("scanner.structs.Keyword")
local xy = require("scanner.structs.xy")    -- Import the xy class

Scanner = {}

function Scanner:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Scanner:scan(input)
    -- Scan the input and return the SyntaxTree
    local validChars = {
        A = true,
        B = true,
        C = true,
        D = true,
        E = true,
        F = true,
        ["1"] = true,
        ["2"] = true,
        ["3"] = true,
        ["4"] = true,
        ["5"] = true,
        ["6"] = true
    }

    local i = 1
    while i <= #input do
        ::continue_loop::
        print("Current character: " .. input:sub(i, i))
        print("Current index: " .. i)
        -- Is this the end of the input?
        if i >= #input then
            print("End of input reached")
            break
        end
        local char = input:sub(i, i)

        if char == " " then
            print("Space skipped over")
            i = i + 1
            goto continue_loop
        elseif char == "A" or char == "B" or char == "C" or char == "D" or char == "E" or char == "F" then
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
                else
                    print(input)
                    -- Get the index of nextChar
                    local nextCharIndex = input:find(nextChar, i)
                    local spaces = string.rep(" ", nextCharIndex - 1) -- Get the spaces before the nextChar
                    print(spaces .. "^ [TK]: Invalid token: " .. nextChar)
                    break
                end
            end
        elseif char == "S" or char == "T" then
            if i < #input then
                local nextChar = input:sub(i + 1, i + 1)
                local nextCharCheck = {
                    -- S = isSQR,
                    -- T = isTRI
                }
                local func = nextCharCheck[nextChar]
                if func then
                    print("Next character is S, or T")
                    func()
                else
                    print(input)
                    -- Get the index of nextChar
                    local nextCharIndex = input:find(nextChar, i)
                    local spaces = string.rep(" ", nextCharIndex - 1) -- Get the spaces before the nextChar
                    print(spaces .. "^ [ST]: Invalid character found: " .. nextChar)
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
                        print(input)
                        -- Get the index of nextChar
                        local nextCharIndex = input:find(nextChar, i)
                        local spaces = string.rep(" ", nextCharIndex - 1) -- Get the spaces before the nextChar
                        print(spaces .. "^ [ON/OFF]: Invalid character found: " .. nextChar)
                        return -1
                    end
                end
            }
            local func = nextCharCheck[nextChar]
            if func then
                local retVal = func(i)
                print(retVal == -1 and "Scan failed" or "Keyword: " .. retVal:getValue())
                if retVal == -1 then
                    break
                end
            else
                print(input)
                -- Get the index of nextChar
                local nextCharIndex = input:find(nextChar, i)
                local spaces = string.rep(" ", nextCharIndex - 1) -- Get the spaces before the nextChar
                print(spaces .. "^ [ON/OFF]: Invalid character found: " .. nextChar)
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
end

return Scanner
