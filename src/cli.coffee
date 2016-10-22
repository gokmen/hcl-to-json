#!/usr/bin/env coffee

readInput = (filename, callback) ->

  fs = require 'fs'

  readFile = ->

    fs.readFile filename, 'utf8', (err, text) ->
      if err
        console.error "Couldn't read file #{filename}"
        console.error err.message

      callback err, text


  readStdin = ->

    text  = ''
    stdin = process.stdin

    stdin.resume()

    stdin.on 'data', (chunk) ->
      text += chunk

    stdin.on 'end', ->
      callback null, text


  if filename
  then do readFile
  else do readStdin

usage = ->

  console.warn 'Usages:'
  console.warn 'hcltojson example.tf'
  console.warn 'cat example.tf | hcltojson'


handleInput = (err, hclinput) ->

  return usage()  if err

  hcltojson = require '../lib'
  data = hcltojson hclinput
  console.log JSON.stringify data, ' ', 4

do ->

  filename = process.argv[2]
  readInput filename, handleInput
