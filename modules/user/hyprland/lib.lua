local M = {}

function M.exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

function M.bind(keys, dispatcher, opts)
  return hl.bind(keys, dispatcher, opts)
end

function M.bind_all(items)
  for _, item in ipairs(items) do
    hl.bind(item[1], item[2], item[3])
  end
end

return M
