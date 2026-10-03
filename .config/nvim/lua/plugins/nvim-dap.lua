return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            {
                'theHamsta/nvim-dap-virtual-text',
                opts = {
                    virt_text_pos = 'eol',
                },
            },
            { 'leoluz/nvim-dap-go', opts = {} },
            'mfussenegger/nvim-dap-python',
        },
        keys = {
            {
                '<leader>db',
                function()
                    require('dap').toggle_breakpoint()
                end,
                desc = 'Toggle Breakpoint',
            },
        },
        config = function()
            require('dap-python').setup 'debugpy-adapter'
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        keys = {},
        opts = {},
        config = function(_, opts)
            local dap = require 'dap'
            local dapui = require 'dapui'
            dapui.setup(opts)
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open {}
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close {}
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close {}
            end
        end,
    },
}
