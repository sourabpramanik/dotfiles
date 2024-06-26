return{
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
  },
  config = function()
    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "tsserver",
        "svelte",
        "cssls",
        "html",
        "sqlls",
        "tailwindcss",
        "astro-language-server"
      },

      handlers = {

      function(server_name)
        require("lspconfig")[server_name].setup({})
      end
      }
    })
  end,
}
