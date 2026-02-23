require('jdtls').start_or_attach({
    cmd = {'/opt/homebrew/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find(
        {'gradlew', '.git', 'mvnw'},
        { upward = true }
    )[1]),
})
