createTd = (arg) ->
  result = document.createElement('td')
  result.innerHTML = arg
  return result

createTr = (args...) ->
  result = document.createElement('tr')
  for arg in args
    result.appendChild(createTd(arg))
  return result

table =
  generate: (items) ->
    result = document.createElement('table')
    result.setAttribute('class', 'gpp')
    info = createTr('Type', 'File', 'Description', 'Place')
    info.setAttribute('class', 'info')
    result.appendChild(info)
    for item in items
      if item.where.col isnt ''
        place = item.where.col + ':' + item.where.row
      else
        place = ''
      result.appendChild(createTr(item.type, item.file, item.desc, place))
    return result

module.exports = table
