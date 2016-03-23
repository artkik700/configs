" execute pathogen#infect()
syntax on
let g:indentLine_enabled = 1
filetype plugin indent on
au BufNewFile,BufRead *.riot setlocal ft=javascript

" let g:syntastic_javascript_checkers = ['standard']

noremap <silent> <F4> :let @+=expand("%:p")<CR>

nnoremap <silent> <Leader>y :Start! sh ~/.copy.sh <CR>
nnoremap <Leader>t :%y+<CR>
nnoremap <silent> <Leader>p :CtrlPMRUFiles<CR>
nnoremap <Leader>q :q<CR>
map <leader>s :execute "noautocmd vimgrep /\\<" . expand("<cword>") . "\\>/gj **/*." .  expand("%:e") <Bar> cw<CR>
nmap <F3> :vimgrep //g %<left><left><left><left>
nmap <Leader><F3> :vimgrep // *<left><left><left>
nmap <Leader>f :vimgrep /<C-R><C-W>/g %<CR>
set showmode

let g:system_copy#copy_command='xsel -sel clipboard'

let g:neomake_javascript_enabled_makers = ['standard']
autocmd! BufWritePost * Neomake
autocmd BufNew * execute ":tabmove99"

let mapleader = ","
let g:mapleader = ","

" let g:python3_host_prog = '/usr/bin/python3'
" let g:loaded_python_provider = 1

let g:deoplete#enable_at_startup = 1

let g:ackprg = 'ag --vimgrep'

" Powerline (Fancy thingy at bottom stuff)
let g:Powerline_symbols = 'fancy'

" autocmd cursorhold * set nohlsearch
" autocmd cursormoved * set hlsearch

let g:session_autoload = 'no'

" I don't want to pull up these folders/files when calling CtrlP
set wildignore+=*/vendor/**
set wildignore+=*/public/**

" Remove search results
set noswapfile
" set nobackup
set backup
set writebackup
au BufWritePre * let &backupext = '%' . substitute(expand("%:p:h"), "/" , "%" , "g") . "%" . strftime("%Y.%m.%d.%H.%M.%S")
au VimLeave * !cp % ~/.vim_backups/$(echo %:p | sed 's/\(.*\/\)\(.*\)/\2\/\1/g' | sed 's/\//\%/g')$(date +\%Y.\%m.\%d.\%H.\%M.\%S).wq
set backupdir=~/.vim/backups/

" move tabs to the end for new, single buffers (exclude splits)
autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif

" :autocmd InsertEnter * set cul
" :autocmd InsertLeave * set nocul
map <Leader>r :so ~/.vimrc<CR>
map <C-p> :CtrlP<CR>
map <silent> <Leader>b :NERDTreeTabsToggle<CR>
map <silent> <Leader>, :NERDTreeTabsFind<CR>
map <silent> <C-p> :CtrlP<CR>
" map <silent> <Leader>r :NERDTreeFocusToggle<CR>
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Search for the selected text
vmap X y/<C-R>"<CR>
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Go to tab by number
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> :tablast<CR>

" Go to last active tab

let g:lasttab = 1
map <C-l> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Fast saves
nmap <leader>w :w!<cr>

nmap " O<Esc>
nmap ' o<Esc>
nmap <Leader>n :tabnew<CR>
nmap <F8> :tabp<CR>
nmap <F9> :tabn<CR>
    
:imap jj <Esc>
imap <A-h> <left>
imap <A-j> <down>
imap <A-k> <up>
imap <A-l> <right>

"Load the current buffer in Chrome
nmap ,c :!open -a Google\ Chrome<cr>

"Show (partial) command in the status line
set showcmd

highlight Search cterm=underline

" Swap files out of the project root
" set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" load plugins from vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let vundle manage vundle
Plugin 'gmarik/vundle'

" utilities
Plugin 'kien/ctrlp.vim' " fuzzy find files
Plugin 'scrooloose/nerdtree' " file drawer, open with :NERDTreeToggle
Plugin 'benmills/vimux'
Plugin 'tpope/vim-fugitive' " the ultimate git helper
Plugin 'tpope/vim-commentary' " comment/uncomment lines with gcc or gc in visual mode
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'
Plugin 'rking/ag.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sjl/gundo.vim'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'godlygeek/tabular'
Plugin 'mileszs/ack.vim'
" Plugin 'christoomey/vim-system-copy'
Plugin 'tpope/vim-unimpaired'
Plugin 'svermeulen/vim-easyclip'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-dispatch'
" Plugin 'rstacruz/vim-node-import'
" Plugin 'airblade/vim-gitgutter' 
Plugin 'heavenshell/vim-jsdoc'
" Plugin 'Yggdroot/indentLine'
Plugin 'mhinz/vim-signify'

Plugin 'Shougo/deoplete.nvim'
Plugin 'benekastah/neomake'
" Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'editorconfig/editorconfig-vim'
" Plugin 'dkprice/vim-easygrep'
Plugin 'nelstrom/vim-visual-star-search'

" colorschemes
Plugin 'chriskempson/base16-vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'marciomazza/vim-brogrammer-theme'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-scripts/xterm16.vim'

" JavaScript plugins
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'

" HTML plugins
Plugin 'rstacruz/sparkup'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
" Plugin 'honza/vim-snippets'

call vundle#end()

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger=",,"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

filetype plugin indent on

set nocompatible " not compatible with vi
set autoread " detect when a file is changed

" make backspace behave in a sane manner
set backspace=indent,eol,start

" set a map leader for more key combos
let mapleader = ','

" Tab control
set expandtab " tabs ftw
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2 " the visible width of tabs
set softtabstop=2 " edit as if the tabs are 4 characters wide
set shiftwidth=2 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'

set clipboard=unnamed

" faster redrawing
set ttyfast
s
" code folding settings
set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

set showmatch " show matching braces

set mat=2 " how many tenths of a second to blink

" switch syntax highlighting on
syntax on

if !has('nvim')
	set encoding=utf8
endif

let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
set background=dark
" colorscheme delek
" colorscheme Monokai
" colorscheme brogrammer
" colorscheme xterm16
" colorscheme jellybeans

set number

set autoindent " automatically set indent of new line
set smartindent

set laststatus=2 " show the satus line all the time

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>ev :e! ~/.vimrc<cr>
map <leader>wc :wincmd q<cr>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk


" helpers for dealing with other people's code
nmap \t :set ts=4 sts=4 sw=4 noet<cr>
nmap \s :set ts=4 sts=4 sw=4 et<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nmap <C-h> :call WinMove('h')<cr>
" nmap <C-j> :call WinMove('j')<cr>
" nmap <C-k> :call WinMove('k')<cr>
" nmap <C-l> :call WinMove('l')<cr>


nmap <Leader>h :vertical resize -10<cr>
nmap <Leader>k :resize +10<cr>
nmap <Leader>j :resize -10<cr>
nmap <Leader>l :vertical resize +10<cr>



" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitGutter
set updatetime=250

" airline
let g:airline_theme='murmur'

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" Toggle NERDTree
" nmap <silent> <leader>k :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
" nmap <silent> <leader>y :NERDTreeFind<cr>

" map fuzzyfinder (CtrlP) plugin
" nmap <silent> <leader>t :CtrlP<cr>
" nmap <silent> <leader>p :CtrlPBuffer<cr>
let g:ctrlp_map='<leader>p'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'

" CtrlP ignore patterns
let g:ctrlp_custom_ignore = {
            \ 'dir': '\.git$\|node_modules$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$'
            \ }

" search the nearest ancestor that contains .git, .hg, .svn
let g:ctrlp_working_path_mode = 2

" deoplete for nvim
" ---

" autocmd MyAutoCmd CompleteDone * pclose!

set completeopt+=noinsert,noselect

let g:deoplete#auto_completion_start_length = 2
"let g:deoplete#enable_refresh_always = 1

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'

let g:deoplete#sources#go = 'vim-go'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.python = ''

call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
"call deoplete#custom#set('_', 'converters', ['remove_overlap'])

call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])

" Movement within 'ins-completion-menu'
imap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
imap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"

" Scroll pages in menu
inoremap <expr><C-f> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<Left>"
imap     <expr><C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
imap     <expr><C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Undo completion
inoremap <expr><C-g> deoplete#mappings#undo_completion()

" Redraw candidates
inoremap <expr><C-l> deoplete#mappings#refresh()

" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"

" <CR>: If popup menu visible, expand snippet or close popup with selection,
"       Otherwise, check if within empty pair and use delimitMate.
" imap <silent><expr><CR> pumvisible() ?
	" \ (neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<C-y>")
		" \ : (delimitMate#WithinEmptyPair() ? "\<Plug>delimitMateCR" : "\<CR>")

" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
	\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
	\ : (<SID>is_whitespace() ? "\<Tab>"
	\ : deoplete#mappings#manual_complete()))

smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
	\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
	\ : (<SID>is_whitespace() ? "\<Tab>"
	\ : deoplete#mappings#manual_complete()))

inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:is_whitespace() "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~? '\s'
endfunction "}}}

" vim: set ts=2 sw=2 tw=80 noet :
