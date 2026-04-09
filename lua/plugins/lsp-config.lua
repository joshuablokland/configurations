return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "jdlts", "lua_ls", "ts_ls", "terraformls", "pyright" },
        automatic_installation = true,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("java_language_server", {})
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          }
        }
      })

      vim.lsp.config("pyright", {})
      vim.lsp.config("ts_ls", {})
      vim.lsp.config("terraformls", {})
      vim.lsp.enable({ "java_language_server", "lua_ls", "ts_ls", "pyright" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end
      })
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local data_dir   = vim.fn.stdpath("data")
      local lombok_jar = data_dir .. "/mason/packages/jdtls/lombok.jar"
      local launcher   = vim.fn.glob(data_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
      local workspace  = vim.fn.expand("~/.cache/jdtls/") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      require("jdtls").start_or_attach({
        cmd = {
          "java",
          "-javaagent:" .. lombok_jar,  -- this is the key line
          "-jar", launcher,
          "-configuration", data_dir .. "/mason/packages/jdtls/config_mac",
          "-data", workspace,
        },
        root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", ".git" }),
        settings = {
          java = {
            configuration = { updateBuildConfiguration = "automatic" },
          },
        },
      })
    end
  }
}
