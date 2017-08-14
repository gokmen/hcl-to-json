debug = (require 'debug') 'hcltojson:utils'

module.exports = utils = {

  getHereDoc: (input, token) ->

    debug 'getHereDoc', input, token

    reg = ///<<\s?(.+?)\s((?:.|\n)*)#{token}///gi
    res = reg.exec input

    debug 'getHereDoc.res', res

    [..., context] = res

    return context.trimRight '\n'


  doConversions: (part) ->

    debug 'doConversions', part

    # remove, escape quotes
    part = part
      .replace /^\"/, ''
      .replace /\"$/, ''
      .replace /\"/g, '\"'

    debug 'doConversions.quotes.processed', part

    # boolean conversions
    part = false  if part is 'false'
    part = true   if part is 'true'

    debug 'doConversions.boolean.processed', part

    if part is ''
      return part

    # numeric conversion
    part = +part  unless isNaN "#{part}"

    debug 'doConversions.numerics.processed', part

    return part

}
