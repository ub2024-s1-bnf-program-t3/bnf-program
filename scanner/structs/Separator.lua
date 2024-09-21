Separator = {}
Separator.__index = Separator

function Separator:new(value)
    local instance = setmetatable({}, Separator)
    -- Must be a '-'
    assert(value == "-", "Invalid value for 'Separator'")
    instance.value = value
    return instance
end

function Separator:getValue()
    return self.value
end

return Separator
