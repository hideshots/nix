vim.filetype.add({
  extension = {
    qml = "qml",
    qmltypes = "qml",
  },
  filename = {
    qmldir = "qml",
  },
})

vim.treesitter.language.register("qmljs", { "qml" })
