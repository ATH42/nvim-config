vim.cmd [[
try
  set termguicolors
  colorscheme NeoSolarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
