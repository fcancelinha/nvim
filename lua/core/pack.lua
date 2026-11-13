-- Plugin loader. Each module in lua/plugins/ returns a spec:
--
--   return {
--       src = 'folke/trouble.nvim',
--       deps = { 'nvim-lua/plenary.nvim' },  -- optional
--       priority = 50,                       -- optional, higher configures first
--       build = 'make',                      -- optional, run on install and update
--       config = function() ... end,         -- optional
--   }
--
-- Adding a plugin means adding one file here and nothing else.
local DEFAULT_PRIORITY = 50

--- 'owner/repo' or { 'owner/repo', version = ... } into a vim.pack spec.
local function to_pack_spec(entry)
    if type(entry) == 'string' then
        entry = { entry }
    end
    return { src = 'https://github.com/' .. entry[1], version = entry.version }
end

local function load_modules()
    local files = vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/plugins', '*.lua', false, true)
    local modules = {}

    for _, path in ipairs(files) do
        local name = vim.fn.fnamemodify(path, ':t:r')
        local ok, spec = pcall(require, 'plugins.' .. name)
        if not ok then
            vim.notify(('plugins.%s: %s'):format(name, spec), vim.log.levels.ERROR)
        elseif type(spec) ~= 'table' then
            vim.notify(('plugins.%s did not return a spec table'):format(name), vim.log.levels.ERROR)
        else
            spec.name = name
            modules[#modules + 1] = spec
        end
    end

    table.sort(modules, function(a, b)
        local pa, pb = a.priority or DEFAULT_PRIORITY, b.priority or DEFAULT_PRIORITY
        if pa ~= pb then
            return pa > pb
        end
        return a.name < b.name
    end)

    return modules
end

local modules = load_modules()

-- Deduplicated so shared libraries can be declared by every module that needs them.
local packs, seen, builds = {}, {}, {}

for _, module in ipairs(modules) do
    for _, entry in ipairs(vim.list_extend({ module.src }, module.deps or {})) do
        local pack = to_pack_spec(entry)
        if not seen[pack.src] then
            seen[pack.src] = true
            packs[#packs + 1] = pack
        end
    end
    if module.build then
        builds[vim.fn.fnamemodify(to_pack_spec(module.src).src, ':t')] = module.build
    end
end

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local cmd = builds[ev.data.spec.name]
        if cmd and (ev.data.kind == 'install' or ev.data.kind == 'update') then
            vim.system(type(cmd) == 'table' and cmd or { cmd }, { cwd = ev.data.path }):wait()
        end
    end,
})

-- One call so first-run installs happen in a single batch rather than serially.
vim.pack.add(packs)

-- Isolated so a single broken module does not abort the rest of the config.
for _, module in ipairs(modules) do
    if module.config then
        local ok, err = pcall(module.config)
        if not ok then
            vim.notify(('plugins.%s: %s'):format(module.name, err), vim.log.levels.ERROR)
        end
    end
end
