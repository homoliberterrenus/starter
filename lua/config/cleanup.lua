local M = {}

local WIDTH = 2

-- indentation is significant, or has a fixed convention other than 2 spaces
local keep_indent = {
  diff = true,
  go = true,
  gomod = true,
  make = true,
  markdown = true,
  python = true,
  tsv = true,
}

local function detect_unit(lines)
  local counts, prev = {}, 0
  for _, line in ipairs(lines) do
    local indent = line:match("^ *")
    if line:find("^ *[^%s]") then
      local delta = #indent - prev
      if delta >= 2 and delta <= 8 then
        counts[delta] = (counts[delta] or 0) + 1
      end
      prev = #indent
    end
  end

  local unit, best = WIDTH, 0
  for delta = 2, 8 do
    if (counts[delta] or 0) > best then
      unit, best = delta, counts[delta]
    end
  end
  return unit
end

local function reindent(line, unit)
  local indent, rest = line:match("^([ \t]*)(.*)$")
  local col = 0
  for char in indent:gmatch(".") do
    col = char == "\t" and (math.floor(col / unit) + 1) * unit or col + 1
  end
  return (" "):rep(math.floor(col / unit) * WIDTH + math.min(col % unit, WIDTH - 1)) .. rest
end

local function clean_line(line)
  line = line:gsub("\194\160", " ") -- non-breaking space
  line = line:gsub("\226\128\139", "") -- zero-width space
  line = line:gsub("\239\187\191", "") -- BOM
  return (line:gsub("%s+$", ""))
end

function M.run()
  if not vim.bo.modifiable or vim.bo.readonly or vim.bo.binary then
    return vim.notify("Buffer can't be modified", vim.log.levels.WARN, { title = "Cleanup" })
  end

  local ft = vim.bo.filetype
  local ec = vim.b.editorconfig or {}
  local lines = vim.tbl_map(clean_line, vim.api.nvim_buf_get_lines(0, 0, -1, false))

  while #lines > 1 and lines[#lines] == "" do
    table.remove(lines)
  end

  if not keep_indent[ft] and not ec.indent_style and not ec.indent_size then
    local unit = detect_unit(lines)
    lines = vim.tbl_map(function(line)
      return reindent(line, unit)
    end, lines)
    vim.bo.expandtab = true
    vim.bo.shiftwidth = WIDTH
    vim.bo.softtabstop = WIDTH
    vim.bo.tabstop = WIDTH
  end

  if not ec.end_of_line and ft ~= "dosbatch" then
    vim.bo.fileformat = "unix"
  end
  vim.bo.bomb = false
  vim.bo.endofline = true
  vim.bo.fixendofline = true

  local view = vim.fn.winsaveview()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.fn.winrestview(view)
end

return M
