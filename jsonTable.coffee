###*
 * jsonTable.coffee v0.1
 *
 * 1337@github
 *
 * MIT
 *
 * Written in CoffeeScript because I want actual classes. Sue me.
###
"use strict"

class HTMLElement
  ###*
   * Manipulatable, self-closing "element" object.
  ###
  tagName: 'div'
  className: ''
  style: ''

  childElementClass: undefined # HTMLElement

  children: []  # children elements

  constructor: (params) ->
    # the (@thing) parameter syntax auto-fills it
    if params
      for thing in params
        if @childElementClass
          console.log "adding child class to #{@.constructor.name}"
          @add new @childElementClass(thing)
        else
          console.log "no child class in #{@.constructor.name}"
          @add thing

  # add whatever
  add: (child) ->
    @children.push child

  toString: ->
    childrenStr = ''
    for child in @children
      if child instanceof HTMLElement
        childrenStr += child.toString()
      else
        childrenStr += child

    """
      <#{@tagName} class="#{@className}" style="#{@style}">
        #{childrenStr}
      </#{@tagName}>
    """


class TableElement extends HTMLElement
  tagName: 'table'

  constructor: ->
    @childElementClass = TableRow
    super


class TableHead extends HTMLElement
  tagName: 'thead'

  constructor: ->
    @childElementClass = TableHeader
    super


class TableBody extends HTMLElement
  tagName: 'tbody'

  constructor: ->
    @childElementClass = TableRow
    super


class TableData extends HTMLElement
  tagName: 'td'

  constructor: (@key, @val) ->
    console.log "creating td with #{@val}"
    # super
    # children is text, right? and text is array, right?

  toString: ->
    """
      <#{@tagName} alt="#{@key}">#{@val}</#{@tagName}>
    """


class TableRow extends HTMLElement
  # so, a "record"
  tagName: 'tr'

  constructor: (fields, isHeader=false) ->
    console.log "creating tr"
    @childElementClass = TableData

    for k, v of fields
      cellObj = null  # coffee is retarded
      if isHeader
        cellObj = new TableHeader(k, v)
      else
        cellObj = new TableData(k, v)

      @add cellObj


class TableHeader extends TableData
  tagName: 'th'

  constructor: (k, v) ->
    super


unique = (arr) ->
  # I think I translated it correctly: stackoverflow.com/a/1961068/1558430
  [u, a] = [{}, []]

  for i in [0..arr.length]
    if u.hasOwnProperty arr[i]
      continue

    a.push arr[i]
    u[arr[i]] = 1
  a[0...-1]  # removes the dangling undefined at its tail


# create namespace
window.ca ?= {}
window.ca.ohai ?= {}
window.ca.ohai.jsonTable = (json) ->
  new TableElement(json).toString()