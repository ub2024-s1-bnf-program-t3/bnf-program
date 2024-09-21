Seperator = {}
Seperator.__index = Seperator

function Seperator:new(value)
    local instance = setmetatable({}, Seperator)
    -- Must be a '-'
    assert(value == "-", "Invalid value for 'Seperator'")
    instance.value = value
    return instance
end

function Seperator:getValue()
    return self.value
end

return Seperator
