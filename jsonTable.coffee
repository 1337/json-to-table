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

  children: []  # children elements

  constructor: (params) ->
    # the (@thing) parameter syntax auto-fills it
    for thing in params
      @add thing

  # add whatever
  add: (child) ->
    @children.push(child)

  toString: =>
    """
      <#{@tagName} class="#{@className}" style="#{@style}">
        #{@child.toString() for child in @children}
      </#{@tagName}>
    """


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


class TableHeader extends TableData
  tagName: 'th'


# create namespace
window.ca ?= {}
window.ca.ohai ?= {}
window.ca.ohai.jsonTable = (json) ->
  table = new TableElement
  for row in json
    table.add new TableRow(row)