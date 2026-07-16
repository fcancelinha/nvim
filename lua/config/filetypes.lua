vim.filetype.add({
    extension = {
        mod = 'gomod',
        sum = 'gosum',
    },
    filename = {
        ['go.mod'] = 'gomod',
        ['go.sum'] = 'gosum',
    },
    pattern = {
        ['.*%.gitlab%-ci.*%.yml'] = 'yaml.gitlab-ci',
        ['.*%.gitlab%-ci.*%.yaml'] = 'yaml.gitlab-ci',
    },
})
