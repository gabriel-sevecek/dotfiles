augroup Format
    autocmd! * <buffer>
    autocmd BufWritePre,FileWritePre <buffer> lua vim.lsp.buf.formatting()
augroup END
