local function setup()
  if hl.plugin.darkwindow ~= nil then
    hl.plugin.darkwindow.load_shader("blackKey", {
      from = "chromakey",
      args = "bkg=[0 0 0] similarity=0.001 amount=1.4 targetOpacity=0.8",
      introduces_transparency = true,
    })
  end
end

return {
  setup = setup,
}
