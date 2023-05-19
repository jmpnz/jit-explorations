"""
What we need :
    - Parse JS code and generate an AST
    - Compile the AST to the smallest IR we can think of
    - Compile the IR to ARM and run it
"""

from dataclasses import dataclass
from enum import Enum
from typing import Any, List

TEST_FUNCTION = R"""function add(a, b) {
  return a + b;
}
let output = add(5, 3);
let str = "Hello World !";
"""

# Tracing JIT interpreter implies two things :
# - You need a VM and a GC
# - You trace execution on the VM using contexts
# - You use traces to determine hot functions
#
# When the VM calls the hot function you indirect
# the execution to a callback function that runs
# the ARM code that was compiled previously
# storing the result in the VM results register

# We we will have a tracing JIT that transpiles a minimal IR
# the IR will then end up compiled to ARM.
# The IR will also be used to generate bytecode.
# Our IR will be in SSA Form
# Implement Peephole Optimization
# Various optimizations using the nanopass approach

EXPECTED_IR_ASM = R"""
entry:
    add.i32 r0, r4, r5
    ret
"""

"""
A more complete example would be the factorial
function :
entry:
    move.i32 r0, #1
    move.i32 r1, r4
loop:
    cmp.i32 r1, #1
    b.lt exit
    mul.i32 r0, r0, r1
    sub.i32 r1, r1, #1
    b loop
exit:
"""


class TokenType(Enum):
    LPAREN = 2
    RPAREN = 3
    LBRACE = 4
    RBRACE = 5
    COMMA = 6
    DOT = 7
    SEMICOLON = 8

    IDENT = 24
    NUMBER = 25
    STRING = 26

    PLUS = 10
    MINUS = 11
    STAR = 12
    SLASH = 13
    EQUAL = 14
    NOT_EQUAL = 15

    LET= 17
    RETURN = 18
    FUNCTION = 19
    EOF = -9999



@dataclass
class Identifier:
    class STRING:
        ident: str


@dataclass
class Token:
    token_type: TokenType
    literal: Any


def is_keyword(identifier:str) -> bool:
    keywords = ["let", "function","return"]
    if identifier in keywords:
      return True
    return False

def keyword_to_token(identifier:str) -> Token:
  keywords = {
    "function":Token(TokenType.FUNCTION,"function"),
    "let" : Token(TokenType.LET, "let"),
    "return":Token(TokenType.RETURN,"return"),
  }
  assert identifier in keywords
  tok = keywords[identifier]
  return tok

class Lexer:
    def __init__(self, source) -> None:
        self.source: str = source
        self.pos = 0
        self.ch = self.source[self.pos]

    def advance(self):
        self.pos += 1
        if self.pos >= len(self.source):
            self.ch = '\0'
        else:
            self.ch = self.source[self.pos]

    def skip_whitespace(self):
        while  self.ch.isspace():
            self.advance()

    def scan_number(self):
        result = ""
        while  self.ch.isdigit():
            result += self.ch
            self.advance()
        return int(result)

    def scan_identifier(self):
        result = ""
        while self.ch.isalpha():
            result += self.ch
            self.advance()
        return result

    def scan_string(self):
        result = ""
        while self.ch != "\"":
            result += self.ch
            self.advance()
        return result

    def scan_token(self):
        match self.ch:
            case  "+":
                self.advance()
                return Token(TokenType.PLUS, "+")

            case  "-":
                self.advance()
                return Token(TokenType.MINUS, "-")

            case "*":
                self.advance()
                return Token(TokenType.STAR, "*")

            case  "/":
                self.advance()
                return Token(TokenType.SLASH, "/")
            case "{":
                   self.advance()
                   return Token(TokenType.LBRACE, "{")

            case "}":
                   self.advance()
                   return Token(TokenType.RBRACE, "}")
            case "(":
                   self.advance()
                   return Token(TokenType.LPAREN, "(")
            case ")":
                   self.advance()
                   return Token(TokenType.RPAREN, ")")
            case ",":
                  self.advance()
                  return Token(TokenType.COMMA,",")
            case "=":
                  self.advance()
                  return Token(TokenType.EQUAL,"=")
            case "\"":
                  self.advance()
                  if self.ch.isalpha():
                    return Token(TokenType.STRING, self.scan_string())
            case _ :
                if self.ch.isdigit():
                  return Token(TokenType.NUMBER, self.scan_number())
                if self.ch.isalpha():
                  ident = self.scan_identifier()
                  if is_keyword(ident):
                    return keyword_to_token(ident)
                  return Token(TokenType.IDENT, ident)
                if self.ch.isspace():
                  self.skip_whitespace()
                else:
                  self.advance()

def debug_tokens(tokens: List[Token]):
    for tok in tokens:
        print(tok)

def lex(source: str) -> List[Token]:
    tokens: List[Token] = []
    lexer: Lexer = Lexer(source)
    while lexer.ch != '\0':
        tok = lexer.scan_token()
        if tok is not None:
          tokens.append(tok)
    debug_tokens(tokens)
    return tokens

print(TEST_FUNCTION)
lex(TEST_FUNCTION)
# lex2(TEST_FUNCTION)
