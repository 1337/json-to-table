###*
 * jsonTable.coffee v0.1
 *
 * 1337@github
 *
 * MIT
 *
###
objKeys = (obj) ->
    keys = []
    for own key of obj
        keys.push key
    keys


objsKeys = (objs) ->
    # get all keys in all objects
    keys = []
    for obj in objs
        for key in objKeys(obj)
            if keys.indexOf(key) is -1
                keys.push key
    keys


jsonTable = (json, opts={}) ->
    frag = document.createDocumentFragment()
    table = document.createElement('table')

    # header row
    keys = opts.keys or objsKeys(json)
    console.log "keys: #{keys}"

    thead = document.createElement('thead')
    row = document.createElement('tr')
    for key in keys
        cell = document.createElement('th')
        cell.textContent = key
        row.appendChild(cell)
    thead.appendChild(row)

    # other rows
    for entry in json
        row = document.createElement('tr')
        for key in keys
            cell = document.createElement('td')
            cellValue = entry[key] or opts.emptyValue
            if typeof cellValue == 'object'

                # objects are just 'lists of one'
                if not (cellValue instanceof Array)
                    cellValue = [cellValue]

                # auto recurse for objects
                console.log "sub-table"
                subTable = jsonTable(cellValue, opts)
                cell.appendChild(subTable)
                row.appendChild(cell)
            else
                # ordinary value
                cell.textContent = cellValue
                row.appendChild(cell)
        table.appendChild(row)

    # output
    table.appendChild(thead)
    frag.appendChild(table)
    frag


# create namespace
window.ca ?= {}
window.ca.ohai ?= {}
window.ca.ohai.jsonTable = jsonTable