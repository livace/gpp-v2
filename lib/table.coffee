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
      if item.where
        place = item.where.line + ':' + item.where.col
      else
        place = ''
      tr = createTr(item.type, item.file, item.desc, place)
      tr.addEventListener('click', (event) ->
        args =
          searchAllPanes: true
        if item.where
          args.initialLine = Number(item.where.line)
          args.initialColumn = Number(item.where.col)
        console.log args
        console.log item.file
        atom.workspace.open(item.file, args)
      )
      result.appendChild(tr)
    return result

module.exports = table
