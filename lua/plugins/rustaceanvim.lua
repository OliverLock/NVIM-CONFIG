return { 'mrcjkb/rustaceanvim',
 version = '^6', -- Recommended
 lazy = false, -- This plugin is already lazy
 require('dap').continue()
}

-- return {
--     'mrcjkb/rustaceanvim',
--     version = '^6', -- Recommended
--     lazy = false, -- This plugin is already lazy
--     ft = "rust",
--     config = function ()
--       codelldb_path = "~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb"
--       liblldb_path = "~/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
--       local cfg = require('rustaceanvim.config')
--       
--       vim.g.rustaceanvim = {
--         dap = {
--           adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
--         },
--       }
--     end
--   }
--
