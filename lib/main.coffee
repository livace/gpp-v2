panel = require './panel'

panel.open()

module.exports =
  commandDisposable: null
  activate: (state) ->
    @commandDisposable = atom.commands.add 'atom-workspace', 'gpp-v2:toggle': ->
      panel.open()
