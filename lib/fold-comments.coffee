module.exports = FoldComments =
  activate: (state) ->
    atom.commands.add "atom-workspace", "fold-comments:toggle": => @toggle()
    atom.commands.add "atom-workspace", "fold-comments:fold-all": => @fold()
    atom.commands.add "atom-workspace", "fold-comments:unfold-all": => @unfold()

  foldAs: (func) ->
    editor = atom.workspace.getActiveTextEditor()

    for row in [0..editor.getLastBufferRow()]
      foldable = editor.isFoldableAtBufferRow(row)
      is_comment = editor.isBufferRowCommented(row)

      if foldable and is_comment
        if func is 'toggle'
          editor.toggleFoldAtBufferRow(row)
        else if func is 'fold'
          editor.foldBufferRow(row)
        else if func is 'unfold'
          editor.unfoldBufferRow(row)

  toggle: ->
    @foldAs('toggle')

  fold: ->
    @foldAs('fold')

  unfold: ->
    @foldAs('unfold')
