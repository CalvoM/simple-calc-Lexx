from ply import lex,yacc

tokens = ("NUMBER","PIPE","AND","PLUS","MINUS","TIMES","DIVIDE","PERCENT","LPAREN","RPAREN")
precedence = (
    ('left','PIPE'),
    ('left','AND'),
    ('left','PLUS','MINUS'),
    ('left','TIMES','DIVIDE','PERCENT'),
    ('left','LPAREN','RPAREN')
)
t_PIPE = r'\|' 
t_AND = r'\&'
t_PLUS = r'\+'
t_MINUS = r'-'
t_TIMES = r'\*'
t_DIVIDE = r'/'
t_PERCENT = r'%'
t_LPAREN = r'\('
t_RPAREN = r'\)'

def t_NUMBER(t: lex.LexToken):
    r'\d+'
    t.value = int(t.value)
    return t

t_ignore = ' \t'

def t_error(t):
    print(f"Illegal character {t.value[0]}")
    t.lexer.skip(1)

lex.lex()
def p_expr(p: yacc.YaccProduction):
    '''expr : expr PLUS expr
            | expr MINUS expr
            | expr TIMES expr
            | expr DIVIDE expr
            | expr PERCENT expr
            | LPAREN expr RPAREN
            | expr AND expr
            | expr PIPE expr'''

    if p[2] == '+':
        p[0] = p[1] + p[3]
    elif p[2] == '-':
        p[0] = p[1] - p[3]
    elif p[2] == '*':
        p[0] = p[1] * p[3]
    elif p[2] == '/':
        p[0] = p[1]/p[3]
    elif p[2] == '%':
        p[0] = p[1] % p[3]
    elif p[2] == '&':
        p[0] = p[1] & p[3]
    elif p[2] == '|':
        p[0] = p[1] | p[3]
    elif p[1] == '(' and p[3] == ')':
        p[0] = p[2]

def p_expr_number(p: yacc.YaccProduction):
    '''expr : NUMBER'''
    p[0] = p[1]
    

def p_error(p: yacc.YaccProduction):
    print("Syntax error in input")

yacc.yacc()
print(yacc.parse("5*(6+7)"))
