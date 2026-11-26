local function git_root()
  local file = vim.api.nvim_buf_get_name(0)
  if vim.bo.buftype ~= "" or file == "" then
    return nil
  end
  return Snacks.git.get_root(vim.fs.dirname(file))
end

return {
  "MagicDuck/grug-far.nvim",
  opts = {
    engines = { ripgrep = { extraArgs = "--glob=!.git/" } },
  },
  keys = {
    {
      "<leader>sr",
      function()
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        local root = git_root()
        require("grug-far").open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            paths = root and root:gsub(" ", "\\ ") or nil,
          },
        })
      end,
      mode = { "n", "x" },
      desc = "Search and Replace (Git Root)",
    },
  },
}
