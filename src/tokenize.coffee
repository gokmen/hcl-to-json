debug  = (require 'debug') 'hcltojson:tokenize'
TOKENS = require './tokens'

CHARS = [
  [','  , TOKENS.COMMA    ]
  [':'  , TOKENS.COLON    ]
  ['='  , TOKENS.ASSIGN   ]
  ['{'  , TOKENS.LBRACE   ]
  ['}'  , TOKENS.RBRACE   ]
  ['['  , TOKENS.LBRACKET ]
  [']'  , TOKENS.RBRACKET ]
  ['<<' , TOKENS.HEREDOC  ]
]

clearQuotes = (m) -> if m?[0] is '"' then m else ''

module.exports = tokenize = (input) ->

  debug 'input', input

  # remove comments
  input = input.replace ///
    ".+?"|\#[\s\S]*?.*
  ///igm, clearQuotes

  input = input.replace ///
    ".+?"|\/\*[\s\S]*?\*\/|\/\/.*
  ///gm, clearQuotes

  debug 'comments.removed', input

  # tokenize input
  for [char, token] in CHARS
    char = "\\#{char}"
    regex = ///".+?"|(#{char})///g
    input = input.replace regex, (match, group) ->
      unless group then match else " #{token} "

  debug 'tokenized', input

  # mark spaces
  input = input.replace ///
    \s+(?=([^"]*"[^"]*")*[^"]*$)
  ///gm, TOKENS.SPACE

  debug 'spaces.marked', input

  return input
