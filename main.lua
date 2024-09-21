local Scanner = require("scanner.Scanner")

local scanner = Scanner:new()

local function getInput()
    io.write("Enter input to scan: ")
    return io.read()
end

while true do
    local input = getInput()
    local scanning_device = scanner:scan(input)
    -- print(scanning_device)
    -- Go through the array array and print the values
    print("--- Scanning device values ---")
    for i = 1, #scanning_device do
        print(scanning_device[i]:getValue())    
    end
    print("--- End of scanning device values ---")
end
