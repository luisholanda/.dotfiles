local saga = require("lspsaga")

local M = {}

function M.setup()
  saga.init_lsp_saga {
    border_style = 2
  }
end

return M
