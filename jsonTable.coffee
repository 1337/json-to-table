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
        @add thing

  # add whatever
  add: (child) ->
    @children.push(child)

  toString: =>
    """
      <#{@tagName} class="#{@className}" style="#{@style}">
        #{child.toString() for child in @children}
      </#{@tagName}>
    """


class TableElement extends HTMLElement
  tagName: 'table'
  childElementClass: TableRow


class TableHead extends HTMLElement
  tagName: 'thead'
  childElementClass: TableHeader


class TableBody extends HTMLElement
  tagName: 'tbody'
  childElementClass: TableRow


class TableData extends HTMLElement
  tagName: 'td'

  constructor: (@children) ->
    # children is text, right? and text is array, right?


class TableRow extends HTMLElement
  # so, a "record"
  tagName: 'tr'
  childElementClass: TableData

  constructor: (fields, isHeader=false) ->
    for cell of fields
      cellObj = null  # coffee is retarded
      if isHeader
        cellObj = new TableHeader(cell)
      else
        cellObj = new TableData(cell)

      @add cellObj


class TableHeader extends TableData
  tagName: 'th'


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
  table = new TableElement
  for row in json
    table.add new TableRow(row)

  table.toString()