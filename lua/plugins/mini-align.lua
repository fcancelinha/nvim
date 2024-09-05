return {
    'echasnovski/mini.align',
    version = '*',
    config = function()
        require('mini.align').setup()
        -- mappings = {
        --    start = 'ga',
        --    start_with_preview = 'gA',
        --  },
        --
        --  -- Modifiers changing alignment steps and/or options
        --  modifiers = {
        --    -- Main option modifiers
        --    ['s'] = --<function: enter split pattern>,
        --    ['j'] = --<function: choose justify side>,
        --    ['m'] = --<function: enter merge delimiter>,
        --
        --    -- Modifiers adding pre-steps
        --    ['f'] = --<function: filter parts by entering Lua expression>,
        --    ['i'] = --<function: ignore some split matches>,
        --    ['p'] = --<function: pair parts>,
        --    ['t'] = --<function: trim parts>,
        --
        --    -- Delete some last pre-step
        --    ['<BS>'] = --<function: delete some last pre-step>,
        --
        --    -- Special configurations for common splits
        --    ['='] = --<function: enhanced setup for '='>,
        --    [','] = --<function: enhanced setup for ','>,
        --    [' '] = --<function: enhanced setup for ' '>,
        --  },
    end
}
