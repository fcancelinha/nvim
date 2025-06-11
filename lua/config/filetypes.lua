vim.filetype.add({
    pattern = {
        ['.*%.gitlab%-ci.*%.yml'] = 'yaml.gitlab-ci',
        ['.*%.gitlab%-ci.*%.yaml'] = 'yaml.gitlab-ci',
    },
})
