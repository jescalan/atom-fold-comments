module.exports =
  activate: (state) ->
    atom.workspaceView.command "fold-comments:toggle", => @toggle_fold()

  toggle_fold: ->
    editor = atom.workspace.activePaneItem

    for row in [0..editor.getLastBufferRow()]
      foldable = editor.isFoldableAtBufferRow(row)
      is_comment = @hasScopeForBufferRow(editor, row, 'comment.block')
      if foldable and is_comment then editor.toggleFoldAtBufferRow(row)

  hasScopeForBufferRow: (editor, row, scope) ->
    scopes = editor.scopesForBufferPosition([row, 300])
    found = false
    found = true for item in scopes when item.startsWith(scope)
    found
