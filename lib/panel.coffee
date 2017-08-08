item =
  element: document.createElement('div')
  getTitle: -> 'g++'
  getDefaultLocation: -> 'bottom'

task = undefined

pane = undefined

dock = undefined

updateDock = ->
  dock = undefined
  if not pane
    return
  if atom.workspace.getBottomDock().getPaneItems().indexOf(item) isnt -1
    dock = atom.workspace.getBottomDock()
  else if atom.workspace.getLeftDock().getPaneItems().indexOf(item) isnt -1
    dock = atom.workspace.getLeftDock()
  else if atom.workspace.getRightDock().getPaneItems().indexOf(item) isnt -1
    dock = atom.workspace.getRightDock()

updatePane = ->
  pane = atom.workspace.paneForItem(item)
  updateDock()

create = ->
  atom.workspace.itemOpened(item)
  switch item.getDefaultLocation()
    when 'bottom' then dock = atom.workspace.getBottomDock()
    when 'right' then dock = atom.workspace.getRightDock()
    when 'left' then dock = atom.workspace.getLeftDock()
    else dock = undefined
  visible = dock?.isVisible()
  task = atom.workspace.open(item)
  task.then(->
    if dock
      dock.hide() unless visible
    updatePane()
  )

panel =
  open: ->
    updatePane()
    if not pane
      task = undefined
      create()
    task.then(->
      visible = dock?.isVisible()
      dock?.show() unless visible
      pane?.activate() unless pane?.isActive()
    )
  update: (table) ->
    item.element = document.createElement('div')
    if table
      item.element.appendChild(table)

module.exports = panel
