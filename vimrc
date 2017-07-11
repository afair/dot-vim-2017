"===============================================================================
" VIM Configuration v2 - .vimrc file
" See https://gist.github.com/afair/8df4ddd5645fd4adc536fb3947561a15
" Invoke alternate configuration via these alias' in your .bashrc/.zshrc
"     alias v2='vim -u ~/.vim2/vimrc'
"     alias mv2='mvim -u ~/.vim2/vimrc -U ~/.vim2/gvimrc'
"-------------------------------------------------------------------------------
" Use the following line only when using an alternate repo!
let &rtp = substitute(&rtp, '\.vim\>', '.vim2', 'g')
"-------------------------------------------------------------------------------
set nocompatible
execute pathogen#infect()
"===============================================================================

syntax on
filetype plugin indent on
colorscheme vibrantink

" This function hack runs AFTER load, so we can correct mappings by plugins, etc.
autocmd VimEnter * call RunAfterLoad()
function RunAfterLoad()
	set number
	set textwidth=0
	set formatoptions-=t            " Turn off auto-wrap text
	set nolist                      " Turn off trailing whitespace indicators
	set noerrorbells                " no beep
	set mouse=a                     " Mouse: n=normal v=visuali=insert c=cmdline a=all
	set nowrap
	set hlsearch
	setglobal complete-=i           " Without included files
	set autoindent                  " Auto: autoindent, noautoindent
	set smartindent                 " For C-style languages: nosmartindent

	" Search Controls
	set hlsearch                    " Highlights search terms: hls, nohls
	set ignorecase                  " Ignore Case on search: ignorecase, noignorecase
	set smartcase                   " When searching with uppercase, turns off ignorecase
	set incsearch                   " Incremental search while you are typing
	noremap <CR> :nohlsearch<CR>:set nolist<CR>j^

	" Abbreviations: common typing error corrections
	ab teh the
	ab cofirm confirm
	ab subscibe subscribe
	ab subsciber subscriber
	ab subsc subscriber
	ab privl privlege_level
	ab yeild yield
	ab inless unless

	" Basics Keys: \m mouseOff, \M mouseOn, \N tabnew, \p paste, \w wrap, \W killTrailingSpace, jk ESC, \p reflow-para
	noremap <Leader>m :set mouse=<CR>
	noremap <Leader>M :set mouse=a<CR>
	noremap <Leader>W :%s/\s\+$//<CR>
	noremap <Leader>w :set invwrap<CR>
	noremap <Leader>N :tabnew
	noremap <Leader>p :set invpaste<CR>
	noremap <Leader>G :GitGutterToggle<CR>
	inoremap jk <Esc>
	inoremap <Leader>p gqap
	noremap <Leader>\ :wincmd w<CR>
	noremap c_ ct_
	noremap _ f_<Right>

	" More: \V reloadVimrc, \gw grepWord, \cf nextConflict, \a AckWord, \" Dup
	"nnoremap <leader>sv :source ~/.vimrc<CR>
	nnoremap <leader>V :source ~/.vimrc<CR>
	nnoremap <silent> <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
	nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>
	nnoremap <leader>a *<C-O>:AckFromSearch!<CR>
	" Duplicate: line/vblock
	noremap <Leader>" Yp
	vnoremap <Leader>" yPgv
	vnoremap <Leader>= :Align=<CR>

	" Reselect visual block after shift, Duplicate Line/Block
	vnoremap < <gv
	vnoremap > >gv

	" Saving: \s Save, \S SaveAll, Q Quit,
	nnoremap Q :q<CR>
	nnoremap W :w<CR>
	nnoremap <leader>s :w<CR>
	"inoremap <leader>s <Esc>:w<CR>
	nnoremap <leader>S :wall<CR>
	nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
	inoremap <silent> <C-S> <Esc>:if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

	" Window/Tab Navigation: Ctrl-<hjkl>, \' NextWindow, \[ PrevTab, \] NextTab,
	noremap <Leader>[ :tabprev<CR>
	noremap <Leader>] :tabnext<CR>

	" Command line editing
	cnoremap <C-a> <Home>
	cnoremap <C-e> <End>

	" Tabstops
	set tabstop=2
	set ai sw=2 sts=2 et smartindent
	augroup myfiletypes
		" Clear old autocmds in group
		autocmd!
		autocmd BufNewFile,BufRead *.html,*.tpl setf html
		" autoindent with two spaces, always expand tabs
		autocmd FileType ruby,eruby,yaml,rhtml,erb,haml set ai sw=2 sts=2 et
		autocmd FileType php,tpl,html set tabstop=2
		autocmd FileType perl,php set ai sw=2 sts=2 et smartindent
		autocmd FileType ruby,eruby,yaml,erb,rhtml set tabstop=2 smartindent
		autocmd FileType tpl,html set ai sw=2 sts=2 et smartindent tabstop=2
		autocmd FileType css set smartindent tabstop=2
		autocmd FileType c,h set smartindent tabstop=8
		" Poor Man's Macros: def<cr> expands to full Ruby method definition
		" "autocmd FileType ruby iab def def<cr>end<esc>-A
	augroup END


	"===============================================================================
	" Plugins & Configurations
	"===============================================================================
	" fugitive
	" nerdtree
	noremap <Leader>f :NERDTreeToggle<CR>
	noremap <Leader>F :NERDTreeFind<CR>
	" syntastic
	let g:syntastic_perl_checkers=['perl']
	let g:syntastic_php_checkers=['php']
	let g:syntastic_enable_perl_checker = 1
	let g:syntastic_javascript_checkers = ['eslint'] " https://jaxbot.me/articles/setting-up-vim-for-react-js-jsx-02-03-2015
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
	" surround
	" ctrlp
	noremap <Leader>o :CtrlP<CR>
	noremap <Leader>t :tabnew<CR>:CtrlP<CR>
	noremap <Leader>i :split<CR><C-w>j:CtrlP<CR>
	noremap <Leader>v :vsplit<CR><C-w>l:CtrlP<CR>
	"inoremap <Leader>t <Esc>:tabnew<CR>:CtrlP<CR>
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip
	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
	" vim-airline - Statusbar
	"let g:airline_powerline_fonts = 1
	" nerdcommenter
	noremap <D-/> <plug>NERDCommenterToggle<CR>
	" vim-gitgutter
	" easymotion
	" supertab
	" repeat
	" Align
	" snippets
	" trailing-whitespace
	" Ack - for silver searcher
	if executable('ag')
		let g:ackprg = 'ag --vimgrep'
	endif
	" buffergator
	noremap <Leader>T :BuffergatorTabsToggle<CR>
	" tablular
	" matchit

	"===============================================================================
	" Environment Plugins & Configurations
	"===============================================================================
	" vim-tmux-navigator
	" vimux

	"===============================================================================
	" Language / Framework Plugins & Configurations
	"===============================================================================
	" # Ruby/Rails -----------------------------------------------------------------
	" rails
	" Rails: \rm Model, \rc Controller, \rv View, \rr Related, \ra Alternative
	noremap <Leader>rm :Rmodel<CR>
	noremap <Leader>rc :Rcontroller<CR>
	noremap <Leader>rv :Rview<CR>
	noremap <Leader>rr :R<CR>
	noremap <Leader>ra :A<CR>
	" vim-ruby
	" rspec
	" vim-rspec
	" vim-haml
	" bundler.vim
	" endwise
	" minitest
	" # Javascript -----------------------------------------------------------------
	" vim-coffee-script
	" vim-javascript
	" vim-jsx
	" typescript-vim
	" vim-javascript-syntax
	" node
	" vim-es6
	" # Web ------------------------------------------------------------------------
	" html5
	" vim-markdown
	" json-vim
	" # Other ----------------------------------------------------------------------
	" php
	" vim-go
	" vim-elixir
	" rust
	" elm
	" c.vim

endfunction

"===============================================================================
" My Functions
"===============================================================================

" Disable/Enable the Arrow Keys...
noremap <Leader><Right> :call DisableArrows()<CR>
function EnableArrows()
	noremap <Up> <Up>
	noremap <Down> <Down>
	noremap <Left> <Left>
	noremap <Right> <Right>
	noremap <Leader><Right> :call DisableArrows()<CR>
endfunction
function DisableArrows()
	noremap <Up> <NOP>
	noremap <Down> <NOP>
	noremap <Left> <NOP>
	noremap <Right> <NOP>
	noremap <Leader><Right> :call EnableArrows()<CR>
endfunction

" RotateNumber: \n LineNumber-RelativeNumber-Off
function RotateNumber()
	if &l:relativenumber
		let &l:number=0
		let &l:relativenumber=0
		echom "No Line Numbers"
	elseif &l:number
		let &l:number=1
		let &l:relativenumber=1
		echom "Relative Line Numbers"
	else
		let &l:relativenumber=0
		let &l:number=1
		echom "Line Numbers"
	endif
endfunction
noremap <Leader>n :call RotateNumber()<CR>

"===============================================================================
" Epilogue: Source .vimrc.local if exists
"===============================================================================

if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif
