return {
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
        config = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function()
                    local cmd = {
                        'java',
                        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                        '-Dosgi.bundles.defaultStartLevel=4',
                        '-Declipse.product=org.eclipse.jdt.ls.core.product',
                        '-Dlog.protocol=true',
                        '-Dlog.level=ALL',
                        '-Xmx1g',
                        '--add-modules=ALL-SYSTEM',
                        '--add-opens',
                        'java.base/java.util=ALL-UNNAMED',
                        '--add-opens',
                        'java.base/java.lang=ALL-UNNAMED',
                        '-javaagent:'
                            .. vim.fn.glob(vim.env.HOME .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
                        '-jar',
                        vim.fn.glob(
                            vim.env.HOME
                                .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'
                        ),
                        '-configuration',
                        vim.env.HOME .. '/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
                    }

                    local root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', '.git' })
                    local project_name = root_dir and vim.fs.basename(root_dir)
                    if project_name then
                        vim.list_extend(cmd, {
                            '-data',
                            vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/workspace',
                        })
                    end

                    require('jdtls').start_or_attach {
                        cmd = cmd,
                        root_dir = root_dir,
                        settings = {
                            java = {
                                inlayHints = {
                                    parameterNames = { enabled = 'all' },
                                },
                            },
                        },
                    }
                end,
            })
        end,
    },
}
