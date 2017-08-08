panel = require './panel'
table = require './table'
parser = require './parser'



module.exports =
  commandDisposable: null
  activate: (state) ->
    @commandDisposable = atom.commands.add 'atom-workspace', 'gpp-v2:toggle': ->
      panel.open()
      panel.update(table.generate(parser.parse('E:\\Cpp\\Atom\\Solution2.cpp:46:15: error: \'dsad\' was not declared in this scope ')))
