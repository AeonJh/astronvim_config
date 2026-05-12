-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local function tmpl_host_language(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr):match "^(.*)%.tmpl$"
  if not filename then return end

  local filetype = vim.filetype.match { filename = filename }
  if not filetype then return end

  return vim.treesitter.language.get_lang(filetype) or filetype
end

vim.treesitter.query.add_directive("inject-tmpl-host!", function(_, _, bufnr, _, metadata)
  local language = tmpl_host_language(bufnr)
  if language then metadata["injection.language"] = language end
end, { force = true })
