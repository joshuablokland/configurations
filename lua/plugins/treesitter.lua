return { 
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        'html',
        'javascript',
        'json',
        'jsx',
        'lua',
        'tsx',
        'typescript'
      },
      highlight = {
        enabled = true
      },
      indent = {
        enabled = true
      }
    })

    vim.g.tsx_ext_required = 0
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    })
  end
}
