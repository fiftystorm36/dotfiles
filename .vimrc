set encoding=utf-8 
scriptencoding utf-8

" vi compatible off
set nocompatible

" standard plugins
runtime macros/matchit.vim

" plugins bundled by Vundle plugin
""""" start Vundle setting """""
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " Vundle itself ':PluginInstall'

Plugin 'tpope/vim-surround'
    " ys{motion}" surround
    " yss" surround current line
    " ds" delete
    " dst delete tag <a>a</a> -> a
    " cs}) change
    " cst<p> change tag <a>a</a> -> <y>a</y> 
    " {range specification}S 
    " b, B, r, a = ), }, ], >
Plugin 'scrooloose/nerdtree' 
Plugin 'severin-lemaignan/vim-minimap'
    " :MinimapToggle 
Plugin 'altercation/vim-colors-solarized'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-unimpaired'
    " [a, ]a list transition
    " [b, ]b buffer
    " [q, ]q quickfix
    " [l, ]l location
    " [t, ]t tag
Plugin 'vim-scripts/camelcasemotion'
Plugin 'tpope/vim-commentary' 
    " gc{motion} comment out <-> uncomment
    "
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
    " :FormatLines to format a range of lines
    " :FormatCode to format the entiree buffer
Plugin 'google/vim-glaive'

Plugin 'vim-python/python-syntax' " python highlighit
Plugin 'davidhalter/jedi-vim' " python completion
Plugin 'othree/yajs.vim' " js es6 highlight
Plugin 'othree/html5.vim' " html5 support
Plugin 'mattn/emmet-vim' " html shortcut
Plugin 'kvdp/ejs-syntax' "ejs highlight
Plugin 'elzr/vim-json'
call vundle#end()
filetype plugin indent on
""""" end Vundle setting """""

" settings about plugins
""""" start plugin settings """""
" vim-colors-solarized
set background=dark
colorscheme solarized

" python-syntax
let g:python_highlight_all = 1

" NERDTree
"" show hidden files
let NERDTreeShowHidden = 1
"" toggle ctrl + n
map <C-n> :NERDTreeToggle<CR> 

" vim-minimap
let g:minimap_highlight='Visual' " highlight style shown in the window
" autocmd VimEnter * Minimap " auto show minimap when start vim

" indentLine
let g:indentLine_color_term=239
let g:indentLine_char='¦'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'

""""" end plugin settings """""

" indent setting
set tabstop=4
set shiftwidth=4
set expandtab " soft tab enable
set smartindent
set autoindent

" cursor setting
set whichwrap=b,s,h,l,<,>,[,],~ " left and right navigation across lines
set number " show line numbers on the sidebar
set cursorline
set backspace=indent,eol,start

" search setting
set incsearch " incremental search
set ignorecase 
set smartcase 
set hlsearch " highlight search result
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>


" command mode setting
set history=200 " expand command history
set wildmenu

" history scroll 
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" hide buffers instead of asking if to save them.
set hidden

" the cursor briefly jump to the matching ({[ when you insert )}]
set showmatch
set matchtime=1

" execute ctags
nnoremap <f5> :!ctags -R<CR>
" autocmd BufWritePost * call system(" ctags -R")

syntax on

" spell check
set spell
set spelllang=en_us,cjk

" show double quote in json
let g:vim_json_syntax_conceal = 0

" expand %% to path of current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" enable mouse navigation
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" indent setting when paste from clipboard
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"
    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" complement setting
set infercase
"" show complement shortcut hint
let s:compl_key_dict = {
            \ char2nr("\<C-l>"): "\<C-x>\<C-l>",
            \ char2nr("\<C-n>"): "\<C-x>\<C-n>",
            \ char2nr("\<C-p>"): "\<C-x>\<C-p>",
            \ char2nr("\<C-k>"): "\<C-x>\<C-k>",
            \ char2nr("\<C-t>"): "\<C-x>\<C-t>",
            \ char2nr("\<C-i>"): "\<C-x>\<C-i>",
            \ char2nr("\<C-]>"): "\<C-x>\<C-]>",
            \ char2nr("\<C-f>"): "\<C-x>\<C-f>",
            \ char2nr("\<C-d>"): "\<C-x>\<C-d>",
            \ char2nr("\<C-v>"): "\<C-x>\<C-v>",
            \ char2nr("\<C-u>"): "\<C-x>\<C-u>",
            \ char2nr("\<C-o>"): "\<C-x>\<C-o>",
            \ char2nr('s'): "\<C-x>s",
            \ char2nr("\<C-s>"): "\<C-x>s"
            \}
let s:hint_i_ctrl_x_msg = join([
            \ '<C-l>: While lines',
            \ '<C-n>: keywords in the current file',
            \ "<C-k>: keywords in 'dictionary'",
            \ "<C-t>: keywords in 'thesaurus'",
            \ '<C-i>: keywords in the current and included files',
            \ '<C-]>: tags',
            \ '<C-f>: file names',
            \ '<C-d>: definitions or macros',
            \ '<C-v>: Vim command-line',
            \ "<C-u>: User defined completion ('completefunc')",
            \ "<C-o>: omni completion ('omnifunc')",
            \ "s: Spelling suggestions ('spell')"
            \], "\n")
function! s:hint_i_ctrl_x() abort
    echo s:hint_i_ctrl_x_msg
    let c = getchar()
    return get(s:compl_key_dict, c, nr2char(c))
endfunction
inoremap <expr> <C-x>  <SID>hint_i_ctrl_x()
