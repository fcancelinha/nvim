local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end


local lanuage_server = {
	function()
		local buf_ft = vim.bo.filetype
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"toggleterm",
			"TelescopePrompt",
			"lspinfo",
			"lsp-installer",
			"",
		}

		if contains(ui_filetypes, buf_ft) then
			if M.language_servers == nil then
				return ""
			else
				return M.language_servers
			end
		end

		local clients = vim.lsp.buf_get_clients()
		local client_names = {}

		-- add client
		for _, client in pairs(clients) do
			if  client.name ~= "null-ls" then
				table.insert(client_names, client.name)
			end
		end

		-- add formatter
		local s = require "null-ls.sources"
		local available_sources = s.get_available(buf_ft)
		local registered = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end

		local formatter = registered["NULL_LS_FORMATTING"]
		local linter = registered["NULL_LS_DIAGNOSTICS"]
		if formatter ~= nil then
			vim.list_extend(client_names, formatter)
		end
		if linter ~= nil then
			vim.list_extend(client_names, linter)
		end

		-- join client names with commas
		local client_names_str = table.concat(client_names, ", ")

		-- check client_names_str if empty
		local language_servers = ""
		local client_names_str_len = #client_names_str
		if client_names_str_len ~= 0 then
			language_servers = hl_str("", "SLSep") .. hl_str(client_names_str, "SLSeparator") .. hl_str("", "SLSep")
		end
		if client_names_str_len == 0 and not copilot_active then
			return ""
		else
			M.language_servers = language_servers
			return language_servers:gsub(", anonymous source", "")
		end
	end,
	padding = 0,
	cond = hide_in_width,
	-- separator = "%#SLSeparator#" .. " │" .. "%*",
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = true,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
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
    lualine_x = { diff, filename, "enconding" },
    lualine_y = { filetype },
    lualine_z = { "location" },
  },
}
