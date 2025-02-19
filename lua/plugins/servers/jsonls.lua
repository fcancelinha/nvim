return {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json'
        },
        {
          fileMatch = { 'tsconfig*.json' },
          url = 'https://json.schemastore.org/tsconfig.json'
        },
        {
          fileMatch = { '.eslintrc.json', '.eslintrc' },
          url = 'https://json.schemastore.org/eslintrc.json'
        },
        {
          fileMatch = { 'prettierrc.json', 'prettier.config.json' },
          url = 'https://json.schemastore.org/prettierrc.json'
        }
      },
    },
    validate = {
      enable = true
    }
  },
}
