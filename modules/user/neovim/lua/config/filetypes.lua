vim.filetype.add({
  extension = {
    qml = "qml",
    qmltypes = "qml",
    ron = "ron",
  },
  filename = {
    qmldir = "qml",
  },
})

vim.treesitter.language.register("qmljs", { "qml" })
