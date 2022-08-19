local g = vim.g
local colorscheme = "gruvbox-material"

-- gruvbox-material @sainnhe

g.gruvbox_material_better_performance = 1
g.gruvbox_material_foreground = 'original'
g.gruvbox_material_background = 'hard'
g.gruvbox_material_cursor = 'green'
g.gruvbox_material_transparent_background = 2
g.gruvbox_material_sign_column_background = 'grey'
g.gruvbox_material_ui_contrast = 'high'


-- gruvbox-flat @eddyekofo94

g.gruvbox_flat_style = 'hard'
g.gruvbox_transparent = true
g.gruvbox_dark_float = true


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  -- vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
