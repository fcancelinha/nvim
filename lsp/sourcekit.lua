return {
    { 'sourcekit-lsp' },
    { 'swift',        'objc', 'objcpp', 'c', 'cpp' },
    textDocument = {
        diagnostic = {
            dynamicRegistration = true,
            relatedDocumentSupport = true
        }
    },
    workspace = {
        didChangeWatchedFiles = {
            dynamicRegistration = true
        }
    }
}
