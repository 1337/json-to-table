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
  contents: undefined

  toString: =>
    return @contents


class TableElement extends HTMLElement
  tagName: 'table'


class TableHead extends HTMLElement
  tagName: 'thead'


class TableBody extends HTMLElement
  tagName: 'thead'


class TableData extends HTMLElement
  tagName: 'td'


class TableRow extends HTMLElement
  tagName: 'tr'
  data: []  # get with @data

  add: (tableData) ->
    @data.push(tableData)


class TableHeader extends TableData
  tagName: 'th'


