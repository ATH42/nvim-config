vim.g.copilot_filetypes = {xml= false}



vim.g.copilot_no_tab_map = true
vim.cmd[[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
-- vim.keymap.set.keymap("i", "<C-a>", ":copilot#Accept('\\<CR>')<CR>", {silent = true})


vim.cmd[[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]


