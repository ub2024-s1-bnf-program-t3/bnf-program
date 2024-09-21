ScannerErrors = {}

function ScannerErrors.CharacterError(input, nextChar, error)
    print(input)
    -- Get the index of nextChar
    local nextCharIndex = input:find(nextChar, i)
    local spaces = string.rep(" ", nextCharIndex - 1) -- Get the spaces before the nextChar
    print(spaces .. "^ Invalid " .. error .. " found: " .. nextChar)
    return -1
end

return ScannerErrors
