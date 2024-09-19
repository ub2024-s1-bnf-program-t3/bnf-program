-- Define the BNF grammar
local bnf_grammar = [[
<expr> ::= <term> | <term> "+" <expr>
<term> ::= <factor> | <factor> "*" <term>
<factor> ::= <number> | "(" <expr> ")"
<number> ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
]]

-- Function to display the BNF grammar
local function display_bnf_grammar()
  print("BNF Grammar:")
  print(bnf_grammar)
end

-- Function to check if the input string is a valid expression
local function is_valid_expression(input)
  -- This is a placeholder function. You need to implement a proper parser.
  -- For simplicity, let's assume any non-empty string is valid.
  return input ~= ""
end

-- Function to draw the parse tree (placeholder)
local function draw_parse_tree(input)
  print("Parse Tree for input: " .. input)
  -- This is a placeholder. You need to implement a proper parse tree drawing.
end

-- Main loop
while true do
  display_bnf_grammar()
  
  print("Enter an input string (or 'HALT' to terminate):")
  local input = io.read()
  
  if input == "HALT" then
    break
  end
  
  if is_valid_expression(input) then
    print("Derivation successful!")
    draw_parse_tree(input)
  else
    print("Error: Invalid input string.")
  end
  
  print("Press Enter to continue...")
  io.read()
end

print("Program terminated.")