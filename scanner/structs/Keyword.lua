-- 'Keyword' class

Keyword = {}
Keyword.__index = Keyword

-- Allowed keywords
local allowed_keywords = {
    ON = true,
    OFF = true
}

-- Constructor
function Keyword:new(value)
    assert(allowed_keywords[value], "Invalid keyword")
    local self = setmetatable({}, Keyword)
    self.value = value
    return self
end

-- Method to get the keyword value
function Keyword:getValue()
    return self.value
end

return Keyword
