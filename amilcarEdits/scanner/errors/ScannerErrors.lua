ScannerErrors = {}

function ScannerErrors.CharacterError(input, nextChar, i, error)
    print(input)
    -- Get the index of nextChar
    local nextCharIndex = input:find(nextChar, i)
    local spaces = string.rep(" ", nextCharIndex - 1) -- Get the spaces before the nextChar
    print(spaces .. "^ SyntaxError: Invalid " .. error .. " found: '" .. nextChar .. "'")
    return -1
end

return ScannerErrors
