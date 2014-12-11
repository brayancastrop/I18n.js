root = exports ? this

class I18n

  instance = null

  constructor: ->
    instance ?= new I18nSingleton(arguments)
    return instance

  class I18nSingleton

    defaultLanguage = "es"
    languages = {}

    constructor: ->
      @setLanguage()
      @

    # private
    byString = (o, s) ->
      s = s.replace(/\[(\w+)\]/g, '.$1') # convert indexes to properties
      s = s.replace(/^\./, '')           # strip a leading dot
      a = s.split('.')
      while a.length
        n = a.shift()
        if n in o
          o = o[n]
        else
          return
      return o

    # public
    setLanguage: (language) ->
      @language = if language? then language else defaultLanguage

    getLanguage: ->
      @language

    addLanguage: (key, value) ->
      languages[key] = value

    removeLanguage: (key) ->
      delete languages[key]

    getLanguages: ->
      languages

    t: (key, _default) ->
      value = byString(languages[@language], key);
      if value?
        value
      else
        if _default? and _default isnt ""
           _default
        else
           key

root.I18n = I18n
