local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic", "nvim_lsp" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = "  "},
  colored = true,
	update_in_insert = true,
  always_visible = true,
	diagnostics_color = {
		warn = 'orange'
	},
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = "  ", removed = "  " }, -- changes diff symbols
  cond = hide_in_width,
}

local filename = {
  'filename',
  path = 1,
}

local filetype = {
  "filetype",
  icons_enabled = true,
}

local location = {
  "location",
  padding = 1,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "gruvbox-material",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics },
    lualine_x = { diff, "fileformat", filename },
    lualine_y = { filetype },
    lualine_z = { location },
  },
}
