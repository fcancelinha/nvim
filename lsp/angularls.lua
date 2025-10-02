-- local project_library_path = '/path/to/project/lib'
-- local cmd = { 'ngserver', '--stdio', '--tsProbeLocations', project_library_path, '--ngProbeLocations',
--     project_library_path }

return {
    cmd = { 'ngserver', '--stdio', '--tsProbeLocations', '../..,?/node_modules', '--ngProbeLocations', '../../@angular/language-server/node_modules,?/node_modules/@angular/language-server/node_modules', '--angularCoreVersion', '' },
    filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
    root_markers = { 'angular.json', 'nx.json' }
}
