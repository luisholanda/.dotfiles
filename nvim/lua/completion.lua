local snippets = require("snippets")
local comp_complete = vim.fn["compe#complete"]

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local function in_snippet()
  local _, expanded = snippets.lookup_snippet_at_cursor()
  return expanded ~ nil
end

local function tab()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif in_snippet() then
    return snippets.expand_or_advance(1)
  else
    return comp_complete()
  end
end

local function s_tab()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif in_snippet() then
    return snippets.advance_snippet(-1)
  else
    return t "<S-Tab>"
  end
end

return { tab = tab; s_tab = s_tab; }
