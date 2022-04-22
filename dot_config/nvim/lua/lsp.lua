local nvim_lsp = require('lspconfig')
local lspconfigs = require('lspconfig/configs')
local wk = require("which-key")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  wk.register({
    l = {
        name = 'LSP',
        r = 'Rename',
        q = 'Diagnostic Location List',
        a = 'Code Action'
    }
  }, { prefix = '<leader>'})

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  if client.name == 'tsserver' then
      _G.lsp_organize_imports = function()
          local params = {
              command = "_typescript.organizeImports",
              arguments = {vim.api.nvim_buf_get_name(0)},
              title = ""
          }
          vim.lsp.buf.execute_command(params)
      end
      vim.cmd("command! LspOrganize lua lsp_organize_imports()")
      buf_set_keymap('n', '<leader>loi', '<cmd>lua lsp_organize_imports()', opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "elmls", "hls", "svelte", "clangd", "vuels" }
local init_options = {
    tsserver = {
        preferences = {
            importModuleSpecifierPreference = "non-relative",
        },
    }
}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = init_options[lsp] or {},
  }
end

local prettier = {
    formatCommand = "./node_modules/.bin/prettier",
}

local black = {
    formatCommand = "black -",
    formatStdin = true
}

local pgformat = {
    formatCommand = "pg_format --function-case 1 --keyword-case 2 --spaces 2 --no-extra-line",
}

-- local on_efm_attach = function(client)
    -- if client.resolved_capabilities.document_formatting then
        -- vim.api.nvim_command [[augroup Format]]
        -- vim.api.nvim_command [[autocmd! * <buffer>]]
        -- vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        -- vim.api.nvim_command [[augroup END]]
    -- end
-- end

nvim_lsp.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    -- root_dir = nvim_lsp.util.root_pattern(".git", "package.json", ".vim"),
    root_dir = function(fname)
        -- My SQL editing is always from the pg_cli on temp files
        -- so root dir on those does not really make any sense
        if fname:sub(-3) == "sql" then
            return "/tmp";
        end
        return nvim_lsp.util.find_git_ancestor(fname)
    end,
    settings = {
        languages = {
            typescript = {prettier},
            javascript = {prettier},
            typescriptreact = {prettier},
            javascriptreact = {prettier},
            python = {black},
            sql = {pgformat},
        }
    },
    filetypes = {"typescript.tsx", "python", "sql"}
}
