local grammar = require("grammar")

local function isValidExpression(input)
    -- Logic for checking if input is valid according to BNF grammar
    return input ~= ""
end

local function rightmostDerivation(input)
    -- Logic for performing the rightmost derivation
    -- Following the derivation steps we discussed earlier
end

return {
    isValidExpression = isValidExpression,
    rightmostDerivation = rightmostDerivation
}
