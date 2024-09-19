local grammarBNF = [[
<program> ::= begin <stmt_list> end
<stmt_list> ::= <stmt> | <stmt> ; <stmt_list>
<stmt> ::= <var> = <expr>
<var> ::= A | B | C
<expr> ::= <var> + <var> | <var> - <var> | <var>
]]

return {
    grammarBNF = grammarBNF
}
