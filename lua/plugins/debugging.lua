return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "folke/neodev.nvim",
    "leoluz/nvim-dap-go",         -- GO DAP debugger
    "mfussenegger/nvim-dap-python", -- PYTHON DAP debugger
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local neodev = require("neodev")

    -- setup DAB-UI
    require("dapui").setup()

    -- Setup Debbuggers
    -- Go
    require("dap-go").setup()

    -- C++
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "~/.bin/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    }

    -- python
    local pythonPath = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(pythonPath)

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
    vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<F5>", dap.continue, {})
  end,
}
