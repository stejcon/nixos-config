vim.cmd([[
filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'zathura'
]])
vim.g.vimtex_compiler_latexmk = {
  options = {
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode'
  }
}
