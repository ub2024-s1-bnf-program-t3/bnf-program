local Scanner = require("scanner.Scanner")

local scanner = Scanner:new()

local function getInput()
    io.write("Enter input to scan: ")
    return io.read()
end

while true do
    local input = getInput()
    local scanning_device = scanner:scan(input)
    print(scanning_device:getValue())
end
