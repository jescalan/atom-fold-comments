module.exports = FoldComments =
  activate: (state) ->
    atom.commands.add "atom-workspace", "fold-comments:toggle": => @toggle()
    atom.commands.add "atom-workspace", "fold-comments:fold-all": => @fold()
    atom.commands.add "atom-workspace", "fold-comments:unfold-all": => @unfold()

  toggle: -> @foldAs('toggle')

  fold: -> @foldAs('fold')

  unfold: -> @foldAs('unfold')

  foldAs: (mode, editor) ->
    editor ||= atom.workspace.getActiveTextEditor()

    eachFoldable = (f) ->
      for row in [0..editor.getLastBufferRow()]
        f(row) if editor.isFoldableAtBufferRow(row) && editor.isBufferRowCommented(row)

    switch mode
      when 'toggle' then eachFoldable (row) -> editor.toggleFoldAtBufferRow(row)
      when 'fold' then eachFoldable (row) -> editor.foldBufferRow(row)
      when 'unfold' then eachFoldable (row) -> editor.unfoldBufferRow(row)
