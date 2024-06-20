# dotfiles

`coc-clangd` `coc-zig` `coc-rust-analyzer` `coc-go` `coc-json` `coc-floaterm`


        require("dapui").setup()
        require("nvim-dap-virtual-text").setup()
        local dap, dapui = require("dap"), require("dapui")
        dap.adapters.lldb = {
          type = 'executable',
          command = '/data/data/com.termux/files/usr/bin/lldb-dap',
          name = 'lldb'
        }
        dap.configurations.cpp = {
          {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
              local args = vim.fn.input('Args: ', '', 'file')
              local words = {}
              for v in args:gmatch('%S+') do
                table.insert(words, v)
              end
              if #words == 0 then
                return {}
              end
              return words
            end,
          },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = {
          {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
              local args = vim.fn.input('Args: ', '', 'file')
              local words = {}
              for v in args:gmatch('%S+') do
                table.insert(words, v)
              end
              if #words == 0 then
                return {}
              end
              return words
            end,
            initCommands = function()
              local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))
        
              local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
              local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
        
              local commands = {}
              local file = io.open(commands_file, 'r')
              if file then
                for line in file:lines() do
                  table.insert(commands, line)
                end
                file:close()
              end
              table.insert(commands, 1, script_import)
        
              return commands
            end,
          },
        }
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
          vim.cmd'set signcolumn=yes'
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
          vim.cmd'set signcolumn=yes'
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
          vim.cmd'set signcolumn=no'
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
          vim.cmd'set signcolumn=no'
        end
        vim.keymap.set('n', '<leader>D', function() require('dapui').close() end, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
        vim.keymap.set('n', '<leader>dj', function() require('dap').step_over() end)
        vim.keymap.set('n', '<leader>dk', function() require('dap').step_into() end)
        vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)
        vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
        vim.keymap.set('n', '<Leader>B', function()
          require('dap').list_breakpoints()
          vim.cmd('copen')
        end)
        vim.keymap.set('n', '<Leader>c', function()
          require('dap').clear_breakpoints()
          vim.cmd('copen')
        end)
        vim.keymap.set('n', '<Leader>dt', function() require('dap').run_to_cursor() end)
        vim.keymap.set('n', '<Leader><Up>', function() require('dap').up() end)
        vim.keymap.set('n', '<Leader><Down>', function() require('dap').down() end)
        vim.keymap.set('n', '<Leader>L',
          function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
        vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
        vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
        vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
        vim.keymap.set('n', '<Leader>df', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set('n', '<Leader>ds', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end)
