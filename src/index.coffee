debug    = (require 'debug') 'hcltojson:main'

get      = require 'lodash.get'
set      = require 'lodash.set'

TOKENS   = require './tokens'
tokenize = require './tokenize'
utils    = require './utils'


module.exports = hcltojson = (hclInput) ->

  debug 'input', hclInput

  return {}  if not hclInput?.trim?()

  # take a copy of hclInput
  input = "#{hclInput}"

  # tokenize
  input = tokenize input

  # output json object
  json         = {}

  # path stack
  stack        = []

  # inline counters
  inBlock      = 0
  inList       = 0
  itemInList   = 0

  # state flags
  assignment   = no
  hereDocAhead = no

  # hereDoc statements
  hereDocPart  = ''
  hereDocToken = null

  # loop on parts splitted with spaces
  for part in input.split TOKENS.SPACE

    continue  unless part
    continue  if part is TOKENS.COMMA

    debug 'json', JSON.stringify json

    # create stack for active path
    path = stack.join '.'

    debug 'path', path

    # remove any quotes on keys
    part = part.replace /\"/g, ''  unless assignment

    # get hereDoc token from part
    if hereDocAhead

      hereDocToken = part
      hereDocAhead = no
      hereDocPart  = utils.getHereDoc hclInput, hereDocToken

      debug 'heredoc', part, hereDocPart

      continue

    # assign hereDocPart to part
    if hereDocToken
      if part is hereDocToken
        part = hereDocPart

        # reset hereDoc
        hereDocToken = null
        hereDocPart  = ''

        # so we can assign it to part on next step
        assignment = yes

      else
        # continue until hereDocToken found
        continue

    # assignment '=' operations
    if assignment
      debug 'assignment', part

      switch part

        when TOKENS.LBRACKET
          set json, path, []
          inList++

        when TOKENS.LBRACE
          inBlock++

        when TOKENS.RBRACE
          inBlock--
          stack = []  if inBlock <= 0

        when TOKENS.HEREDOC
          hereDocAhead = yes

        else
          part = utils.doConversions part
          set json, path, part

          stack.pop()
          stack = []  if inBlock <= 0

      assignment = no
      continue

    # token handler
    switch part

      when TOKENS.LBRACE
        inBlock++

      when TOKENS.RBRACE
        stack.pop()
        inBlock--

        if itemInList > 0
          stack.pop()
          itemInList--

        stack = []  if inBlock <= 0

      when TOKENS.RBRACKET
        stack.pop()
        inList--

      when TOKENS.ASSIGN
        assignment = true

      else

        if inList > 0
          list = get json, path
          list.push part

          set json, path, list

        else
          if stack.length > 2 and part is stack[stack.length - 1]
            stack.pop()

          stack.push part
          path = stack.join '.'

          debug 'path end', path

          if stack.length > 2 and cur = get json, path
            itemInList++

            if Array.isArray cur
              cur.push {}
              set json, path, cur
              stack.push "#{cur.length - 1}"

            else
              cur = [cur, {}]
              set json, path, cur
              stack.push "#{itemInList}"

          else
            continue  if get json, path
            set json, path, {}


  return json
