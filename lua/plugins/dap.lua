return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- required by nvim-dap-ui
    'theHamsta/nvim-dap-virtual-text',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim'
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('dapui').setup()
    require('nvim-dap-virtual-text').setup()
    require('mason-nvim-dap').setup({
      ensure_installed = {
        'javadbg'
      }
    })

    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })

    require('dap').set_log_level('DEBUG')

    dap.configurations.java = {
      {
        type    = 'java',
        request = 'attach',
        name    = 'Attach to JVM',
        hostName = 'localhost',
        port    = function()
          return tonumber(vim.fn.input('Debug port: ', 5005))
        end,
      },
    }

    -- If I want to add a port that is loaded from the project
    -- folder itself I should do it as follows.
    -- 
    -- ${project-root-url}/.nvim.lua
    -- local dap = require('dap')
    -- table.insert(dap.configurations.java, 1, {
    --   type     = 'java',
    --   request  = 'attach',
    --   name     = 'configurator-api-service (5005)',
    --   hostName = 'localhost',
    --   port     = 5005,
    -- })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end
}
