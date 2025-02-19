return {
    filetypes = { 'yaml.gitlab-ci', 'yaml', 'yml' },
    settings = {
        redhat = {
            telemetry = {
                enable = false,
            },
        },
        yaml = {
            schemaStore = {
                enable = true,
            },
            customTags = {
                '!reference sequence',
            },
            schemas = {
                kubernetes = '/*.k8s.yaml',
                ['http://json.schemastore.org/github-workflow'] = '/.github/workflows/*',
                ['http://json.schemastore.org/github-action'] = '/.github/action.{yml,yaml}',
                ['http://json.schemastore.org/drone'] = '/.drone.{yml,yaml}',
                ['http://json.schemastore.org/chart'] = '/Chart.{yml,yaml}',
                ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = {
                    '.gitlab-ci.yml',
                    '.gitlab-ci.yaml',
                    'gitlab/*.yml',
                    'ci/**/*.yml',
                },
            },
            validate = true,
            completion = true,
            hover = true,
            keyOrdering = false,
        }
    }

}
