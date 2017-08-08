item =
  element: document.createElement('div')
  getTitle: -> 'My Fabulous Div'
  getDefaultLocation: -> 'bottom'

task = undefined

pane = undefined

dock = undefined

updateDock = ->
  dock = undefined
  if atom.workspace.getBottomDock().getPaneItems().indexOf(item) isnt -1
    dock = atom.workspace.getBottomDock()
  else if atom.workspace.getLeftDock().getPaneItems().indexOf(item) isnt -1
    dock = atom.workspace.getLeftDock()
  else if atom.workspace.getRightDock().getPaneItems().indexOf(item) isnt -1
    dock = atom.workspace.getRightDock()

updatePane = ->
  pane = atom.workspace.paneForItem(item)
  updateDock()

panel =
  create: ->
    visible = dock?.isVisible()
    task = atom.workspace.open(item)
    task.then(->
      if dock
        dock.hide() unless visible
      updatePane()
    )
  open: ->
    updatePane()
    console.log pane
    console.log dock
    console.log task
    if not task or not pane # or (not pane and task?.state isnt
      this.create()
    task.then(->
      visible = dock?.isVisible()
      if dock
        dock.show() unless visible
      pane?.activate() unless pane?.isActive()
    )
module.exports = panel
