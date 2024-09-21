-- Define the Subprogram class
Subprogram = {}
Subprogram.__index = Subprogram

-- Constructor
function Subprogram:new(value)
    assert(value == "sqr" or value == "tri", "Invalid value for Subprogram. Must be 'sqr' or 'tri'.")
    local instance = {
        value = value
    }
    setmetatable(instance, Subprogram)
    return instance
end

-- Method to get the value
function Subprogram:getValue()
    return self.value
end

-- Method to set the value
function Subprogram:setValue(value)
    assert(value == "sqr" or value == "tri", "Invalid value for Subprogram. Must be 'sqr' or 'tri'.")
    self.value = value
end

return Subprogram