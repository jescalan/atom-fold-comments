# https://gist.github.com/felixrabe/db88674566e14e413c6f
String::startsWith ?= (s) -> @slice(0, s.length) == s
String::endsWith   ?= (s) -> s == '' or @slice(-s.length) == s

module.exports =
  toggle_fold: ->
    editor = atom.workspace.activePaneItem
    nrows  = editor.getLastBufferRow()

    # I wanted this to do the following:
    # ... 1. fold everything
    # ... 2. unfold outer level blocks of comments, only
    # If you want that too, just uncomment the next line:
    # editor.foldAllAtIndentLevel(0)

    for row in [0..nrows]
      folding = editor.isFoldableAtBufferRow(row)
      comment = editor.isBufferRowCommented(row)

      if folding and comment
          line = editor.lineTextForBufferRow(row)
          if line.startsWith( '//' ) then editor.toggleFoldAtBufferRow(row)

  activate: ->
    editor = atom.workspace.activePaneItem
    atom.workspaceView.command  "fold-comments:toggle", => @toggle_fold()


