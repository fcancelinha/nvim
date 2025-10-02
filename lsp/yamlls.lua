local schemas = {
    -- GitLab CI/CD
    ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = {
        '.gitlab-ci.yml',
        '*.gitlab-ci.yml',
        '.gitlab-ci.yaml',
        '*.gitlab-ci.yaml',
    },
    -- Docker Compose
    ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
        'docker-compose.yml',
        'docker-compose.yaml',
        'docker-compose.*.yml',
        'docker-compose.*.yaml',
        'compose.yml',
        'compose.yaml',
    },
    -- Kubernetes
    ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0/all.json'] = {
        'k8s/**/*.yml',
        'k8s/**/*.yaml',
        'kubernetes/**/*.yml',
        'kubernetes/**/*.yaml',
        'kube/**/*.yml',
        'kube/**/*.yaml',
        '**/k8s/**/*.yml',
        '**/k8s/**/*.yaml',
    },
    -- Helm Charts
    ['https://json.schemastore.org/helmfile.json'] = {
        'helmfile.yml',
        'helmfile.yaml',
        '**/helmfile.yml',
        '**/helmfile.yaml',
    },
    -- Prometheus
    ['https://json.schemastore.org/prometheus.json'] = {
        'prometheus.yml',
        'prometheus.yaml',
        '**/prometheus/*.yml',
        '**/prometheus/*.yaml',
    },
    -- Grafana Dashboard
    ['https://json.schemastore.org/grafana-dashboard.json'] = {
        '**/grafana/**/*.json',
        '**/dashboards/*.json',
    },
    -- Swagger/OpenAPI
    ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json'] = {
        'openapi.yml',
        'openapi.yaml',
        'swagger.yml',
        'swagger.yaml',
        '**/openapi/*.yml',
        '**/openapi/*.yaml',
        '**/swagger/*.yml',
        '**/swagger/*.yaml',
    },
}

return {
    cmd = {
        'yaml-language-server',
        '--stdio',
    },
    filetypes = {
        'yaml',
        'yaml.docker-compose',
        'yaml.gitlab',
        'yaml.helm-values',
    },
    root_markers = {
        '.git',
    },
    settings = {
        redhat = {
            telemetry = {
                enabled = false,
            }
        },
        yaml = {
            validate = true,
            hover = true,
            completion = true,
            format = {
                enable = true,
                singleQuote = false,
                bracketSpacing = true,
                printWidth = 150,
                proseWrap = 'preserve',
            },
            schemas = schemas,
            schemaStore = {
                enable = true,
                url = 'https://www.schemastore.org/api/json/catalog.json',
            },
            customTags = {
                -- GitLab CI custom tags
                '!reference sequence',
                '!reference',
                -- Kubernetes custom tags
                '!vault',
                '!secret',
            },
            keyOrdering = false,
            disableAdditionalProperties = false,
            maxItemsComputed = 5000,
        },
    }
}
