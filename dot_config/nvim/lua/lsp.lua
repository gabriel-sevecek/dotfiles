local nvim_lsp = require("lspconfig")
local wk = require("which-key")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap=true, silent=true }

  wk.register({
    l = {
        name = "LSP",
        r = "Rename",
        q = "Diagnostic Location List",
        a = "Code Action"
    }
  }, { prefix = "<leader>"})

  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

  if client.name == "tsserver" then
      vim.keymap.set("n", "<leader>lio", function()
          vim.lsp.buf.execute_command({
              command = "_typescript.organizeImports",
              arguments = {vim.api.nvim_buf_get_name(0)},
              title = ""
          })
      end, { noremap=true, silent=true, buffer=true, })
      wk.register({
        l = {
            name = "LSP",
            i = {
                name = "Imports",
                o = "Organize",
            },
        },
      }, { prefix = "<leader>"})
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "elmls", "hls", "svelte", "clangd", "vuels", "eslint" }
local init_options = {
    tsserver = {
        preferences = {
            importModuleSpecifierPreference = "non-relative",
        },
    }
}
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = init_options[lsp] or {},
  }
end
