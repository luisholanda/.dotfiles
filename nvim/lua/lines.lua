local messages = require('lsp-status/messaging').messages

local cache

do
  local function same_sep(left_label, right_label)
    return string.format("%%#Crystalline%s#%%#CrystallineTab#)%%#Crystalline%s#", left_label, right_label)
  end

  local function crystalline_right_sep(left_label, right_label)
    return vim.fn["crystalline#right_sep"](left_label, right_label)
  end

  local function crystalline_left_sep(left_label, right_label)
    return vim.fn["crystalline#left_sep"](left_label, right_label)
  end

  local labels = {
    curr = "TabSel",
    last = "Tab",
    unshown = "Tab",
    fill = "TabFill"
  }

  cache = {
    -- 0 - unshown, 2 - current, 3 - fill, 4 - last
    __status_cache = {
      ['00'] = same_sep(labels.unshown, labels.unshown),
      ['02'] = crystalline_right_sep(labels.unshown, labels.curr),
      ['03'] = crystalline_right_sep(labels.unshown, labels.fill),
      ['04'] = same_sep(labels.unshown, labels.last),

      ['20'] = crystalline_right_sep(labels.curr, labels.unshown),
      ['23'] = crystalline_right_sep(labels.curr, labels.fill),
      ['24'] = crystalline_right_sep(labels.curr, labels.last),

      ['40'] = same_sep(labels.last, labels.unshown),
      ['42'] = crystalline_right_sep(labels.last, labels.curr),
      ['43'] = crystalline_right_sep(labels.last, labels.fill),
    },
    __modes_cache = {},
    __files_cache = {},
    right_sep = crystalline_right_sep('', 'Fill'),
    left_sep = crystalline_left_sep('', 'Fill'),
    lsp_msgs_right_sep = crystalline_right_sep('LspMsgs', 'Fill'),
    lsp_msgs_left_sep = crystalline_left_sep('LspMsgs', 'Fill'),
    tab_right_sep = crystalline_right_sep('Tab', 'TabFill'),
    tab_left_sep = crystalline_left_sep('Tab', 'TabFill'),
  }
end

local function make_pill(text)
  return string.format("%s %s %s", cache.left_sep, text, cache.right_sep)
end

local function make_pill_trim(text)
  return string.format("%s%s%s", cache.left_sep, text, cache.right_sep)
end

local function status_sep(last_status, curr_status)
  return cache.__status_cache[string.format('%d%d', last_status, curr_status)]
end

-- Required vim functions
local crystalline_left_mode_sep = vim.fn["crystalline#left_mode_sep"]
local crystalline_right_mode_sep = vim.fn["crystalline#right_mode_sep"]
local crystalline_mode_label = vim.fn["crystalline#mode_label"]
local bufnr = vim.fn.bufnr
local fnamemodify = vim.fn.fnamemodify
local getcwd = vim.fn.getcwd
local mode = vim.fn.mode
local pathshorten = vim.fn.pathshorten
local system = vim.fn.system
local winwidth = vim.fn.winwidth
local nvim_buf_get_name = vim.api.nvim_buf_get_name
local nvim_buf_get_option = vim.api.nvim_buf_get_option
local nvim_get_current_buf = vim.api.nvim_get_current_buf
local nvim_list_bufs = vim.api.nvim_list_bufs
local lsp_buf_diagnostics_count = vim.lsp.util.buf_diagnostics_count

local function std_filename(name)
  name = fnamemodify(name, ":p:~:.")
  if #name > math.min(40, math.floor(0.18 * winwidth(0))) then
    return pathshorten(name)
  else
    return name
  end
end

-- components

-- mode pill component.
--
-- A pill containing the mode name, the background color changes
-- when the mode changes.
local function mode_label(mode)
  local label = cache.__modes_cache[mode]
  if label == nil then
    local left_sep = crystalline_left_mode_sep('Fill')
    local right_sep = crystalline_right_mode_sep('Fill')
    local mode_lbl = crystalline_mode_label()

    label = string.format("%s %s %s", left_sep, vim.trim(mode_lbl), right_sep)
    cache.__modes_cache[mode] = label
  end

  return label
end

-- file name pill component.
--
-- A pill containing the current buffer name.
local function file_name(buf)
  local name = nvim_buf_get_name(buf)

  local s = ''

  if name == nil or #name == 0 then
    s = 'No Name'
  else
    local w = winwidth(0)
    if cache.__files_cache[name] == nil then
      cache.__files_cache[name] = {}
    end
    if cache.__files_cache[name][w] == nil then
      local name_with_icon = std_filename(name)
      name_with_icon = system('devicon-lookup', name_with_icon):sub(1, -2)
      cache.__files_cache[name][w] = name_with_icon
    end

    s = cache.__files_cache[name][w]
  end

  if nvim_buf_get_option(buf, 'modified') then
    s = s .. ' ●'
  end

  return s
end

-- git stats pill component.
--
-- A pill containing git statistics about the current buffer.
local function git_stats()
  local s = '%#CrystallineGitAdd# %{sl#gitstatus_hunks(0)}'
    .. ' %#CrystallineGitChng# %{sl#gitstatus_hunks(1)}'
    .. ' %#CrystallineGitDel# %{sl#gitstatus_hunks(2)}'

  return make_pill(s)
end

-- project directory pill component.
--
-- A pill containing the current project directory.
local function project_dir()
  if vim.b.project_dir == nil then
    vim.b.project_dir = make_pill_trim('  ' .. fnamemodify(getcwd(), ':~'))
  end

  return vim.b.project_dir
end

-- git branch pill component.
--
-- A pill containing the current git branch.
local function git_branch()
  if vim.b.git_branch == nil then
    local branch = system("git branch --show-current")
    if vim.v.shell_error == 0 then
      vim.b.git_branch = make_pill_trim(' ' .. branch:sub(1, -2))
    else
      vim.b.git_branch = make_pill_trim("NOT VERSIONED")
    end
  end

  return vim.b.git_branch
end

-- buffer list pill component.
--
-- A pill containing the list of open buffers.
local function list_buffers()
    local bufs = nvim_list_bufs()

    local curr_buf = nvim_get_current_buf()
    local last_buf = bufnr('#')

    local s = {cache.left_sep, 'ﯟ '}
    local last_buf_status = 0

    for idx = 1, #bufs do
      local buf = bufs[idx]
      if nvim_buf_get_option(buf, 'buflisted') then
        local buf_status = 0
        if buf == curr_buf then
          buf_status = 2
        elseif buf == last_buf then
          buf_status = 4
        end

        table.insert(s, status_sep(last_buf_status, buf_status))
        table.insert(s, ' ')
        table.insert(s, file_name(buf))

        last_buf_status = buf_status
      end
    end

    table.insert(s, status_sep(last_buf_status, 3))

    return table.concat(s)
end

-- LSP diagnostics pill component.
--
-- A pill containing a count of the diagnostics in the buffer.
local function lsp_diagnostics()
  return make_pill_trim('%#CrystallineDiagHint#!%{sl#diagnostic(0)}'
    .. '%#CrystallineDiagWarn#  %{sl#diagnostic(1)}'
    .. '%#CrystallineDiagError# %{sl#diagnostic(2)}')
end

-- Current function pill component.
--
-- A pill containing the current function in scope as said by the LSP server.
local function lsp_current_function()
  return make_pill('%{has_key(b:, "lsp_current_function") && b:lsp_current_function != "" ? " " . b:lsp_current_function : "not in function"}')
end

local aliases = {
  ["rust-analyzer"] = "RA",
  pyls_ms = "MPLS"
}

local function lsp_messages()
  local buf_messages = messages()
  if #buf_messages == 0 then
    return vim.t.last_lsp_message
  end

  local msg = buf_messages[1]
  local content = {'[', aliases[msg.name] or msg.name, '] '}

  if msg.progress then
    if msg.spinner then
      table.insert(content, vim.g.spinner_frames[(msg.spinner % #vim.g.spinner_frames) + 1])
      table.insert(content, ' ')
    end
    table.insert(content, msg.title)
    if msg.message then
      table.insert(content, ' ')
      table.insert(content, msg.message)
    end
    if msg.percentage then
      table.insert(content, ' (')
      table.insert(content, msg.percentage)
      table.insert(content, ')')
    end
  elseif msg.status then
    if msg.uri then
      local filename = std_filename(vim.uri_to_fname(msg.uri))
      table.insert(content, '(')
      table.insert(content, filename)
      table.insert(content, ') ')
    end
    table.insert(content, msg.content)
  else
    table.insert(content, msg.content)
  end

  vim.t.last_lsp_message = string.format("%s%s%s", cache.lsp_msgs_left_sep, table.concat(content), cache.lsp_msgs_right_sep)
  return vim.t.last_lsp_message
end

vim.t.last_lsp_message = string.format('%sno messages yet%s', cache.lsp_msgs_left_sep, cache.lsp_msgs_right_sep)

return {
  -- statusline:
  --
  -- left:
  --    - mode (circle mode)
  --    - file name (relative to project dir, compressed)
  --    - git stats
  -- right:
  --    - current function
  --    - diagnostics stats
  --    - position
  --
  statusline = function(curr, _)
    local ps = vim.b.statusline
    local lw = vim.w.last_width
    local w = winwidth(0)
    if ps == nil or w ~= lw then
      if w < 80 then
        ps = string.format(
          "%s %s%%=%s %s%%#CrystallineFill#",
          make_pill("%{sl#filename()}"),
          git_stats(),
          lsp_diagnostics(),
          make_pill('%l, %c'))
      else
        ps = string.format(
          "%s %s%%=%s %s %s%%#CrystallineFill#",
          make_pill("%{sl#filename()}"),
          git_stats(),
          lsp_current_function(),
          lsp_diagnostics(),
          make_pill('%l, %c'))
      end

      vim.w.last_width = w
      vim.b.statusline = ps
    end

    local s = {'%#CrystallineFill#'}
    if curr == 1 then
      table.insert(s, mode_label(mode()))
      table.insert(s, ' ')
    end
    table.insert(s, ps)

    return table.concat(s)
  end,
  -- tabline;
  --
  -- left:
  --    -- project directory
  --    -- list of buffers
  -- right:
  --    -- LSP server messages (TODO)
  --    -- git branch
  tabline = function()
    return string.format(
      " %s %s %s%%=%s",
      project_dir(),
      git_branch(),
      list_buffers(),
      lsp_messages())
  end,
  components = {
    buffer_filename = function()
      return file_name(0)
    end,
    buffer_diagnostics = function(d)
      if #vim.lsp.buf_get_clients() == 0 then
        return 0
      end

      if d == 0 then
        return lsp_buf_diagnostics_count('Hint') or 0
      elseif d == 1 then
        return lsp_buf_diagnostics_count('Warning') or 0
      elseif d == 2 then
        return lsp_buf_diagnostics_count('Error') or 0
      else
        return 0
      end
    end
  }
}
