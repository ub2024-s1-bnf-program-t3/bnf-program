-- Class for 'x' --
local x = {}
x.__index = x

local valid_values_x = {a = true, b = true, c = true, d = true, e = true, f = true}

-- Constructor for 'x' --
function x:new(value)
    assert(valid_values_x[value], "Invalid value for 'x'")
    local instance = setmetatable({}, x)
    instance.value = value
    return instance
end

function x:getValue()
    return self.value
end

function x:setValue(value)
    assert(valid_values_x[value], "Invalid value for 'x'")
    self.value = value
end


-- Class for 'y' --
local y = {}
y.__index = y

local valid_values_y = {1, 2, 3, 4, 5, 6}

function y:new(value)
    assert(valid_values_y[value], "Invalid value for 'y'")
    local instance = setmetatable({}, y)
    instance.value = value
    return instance
end

function y:getValue()
    return self.value
end

function y:setValue(value)
    assert(valid_values_y[value], "Invalid value for 'y'")
    self.value = value
end

-- Class for 'xy' --
local xy = {}
xy.__index = xy

function xy:new(x_value, y_value)
    local instance = setmetatable({}, xy)
    instance[1] = x:new(x_value)
    instance[2] = y:new(y_value)
    return instance
end

function xy:getValue()
    return self[1]:getValue() .. self[2]:getValue()
end

function xy:getX()
    return self[1]:getValue()
end

function xy:getY()
    return self[2]:getValue()
end

function xy:setX(value)
    self[1]:setValue(value)
end

function xy:setY(value)
    self[2]:setValue(value)
end

return xy
