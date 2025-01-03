return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "folke/neodev.nvim",
    "theHamsta/nvim-dap-virtual-text", -- Inline Variables values
    "leoluz/nvim-dap-go",            -- GO DAP debugger
    "mfussenegger/nvim-dap-python",  -- PYTHON DAP debugger
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local neodev = require("neodev")
    local virtualText = require("nvim-dap-virtual-text")

    -- setup DAB-UI
    require("dapui").setup()

    -- Setup Debbuggers
    -- Go
    require("dap-go").setup()

    -- C++
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.expand('~/.bin/cpptools/extension/debugAdapters/bin/OpenDebugAD7'),
    }

    -- python
    local pythonPath = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(pythonPath)
    table.insert(require('dap').configurations.python,1, {
      type = 'python',
      request = 'launch',
      name = 'Launch Specific File',
      program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
      console = 'integratedTerminal',
    })
    --C++ Configure
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
        setupCommands = {
          {
            text = "-enable-pretty-printing",
            description = "enable pretty printing",
            ignoreFailures = false,
          },
        },
      },
      {
        name = "Attach to gdbserver :1234",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb",
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
      },
    }

    -- Setup NeoDev for icons and stuff
    neodev.setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })

    -- DAP UI
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

    -- Key bindings
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<F5>", dap.continue, {})
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set({'n','v'}, '<leader>de', function() dapui.eval() end)
    vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, {})
    -- Setup Virtual Text
    virtualText.setup({
      enabled = true,                  -- enable this plugin (the default)
      enabled_commands = true,         -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true,         -- show stop reason when stopped for exceptions
      commented = false,               -- prefix virtual text with comment string
      only_first_definition = true,    -- only show virtual text at first definition (if there are multiple)
      all_references = false,          -- show virtual text on all all references of the variable (not only definitions)
      clear_on_continue = false,       -- clear virtual text on "continue" (might cause flickering when stepping)
      --- A callback that determines how a variable is displayed or whether it should be omitted
      --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
      --- @param buf number
      --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
      --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
      --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
      --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
      display_callback = function(variable, buf, stackframe, node, options)
        -- by default, strip out new line characters
        if options.virt_text_pos == "inline" then
          return " = " .. variable.value:gsub("%s+", " ")
        else
          return variable.name .. " = " .. variable.value:gsub("%s+", " ")
        end
      end,
      -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
      virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

      -- experimental feat<ures:
      all_frames = false,   -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false,   -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    })
  end,
}
