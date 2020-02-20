" reminder
" in search :s/\v turn on very magic and you don't need to write a lot of \
"           .{-} is the none greedy mode for .*?
" in replace :s/(some regex)/\1/ \1 refer to the first selected regex parttern
set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
"Plug 'ervandew/supertab'
Plug 'valloric/youcompleteme'
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" File explorer
Plug 'scrooloose/nerdtree'
" Git integration
Plug 'tpope/vim-fugitive'
" Easy comment
Plug 'preservim/nerdcommenter'
" Easy change and add surroundings
Plug 'tpope/vim-surround'
" Tag list
Plug 'majutsushi/tagbar'
" Move around
Plug 'easymotion/vim-easymotion'
" Show git diff on col
Plug 'airblade/vim-gitgutter'
" Tag file auto generation
Plug 'ludovicchabant/vim-gutentags'
" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Undo tree
Plug 'sjl/gundo.vim'
call plug#end()            " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500
set noshowmode
" Enable filetype plugins
filetype plugin on
filetype indent on

" Remove auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Set to auto read when a file is changed from the outside
set autoread

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
" Minimal number of screen lines to keep above and below the cursor.
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set space to search
"nnoremap <Space> /
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Show cmd in status line
set showcmd

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" Add a bit extra margin to the left
set foldcolumn=1

" show only menu when complete
 set completeopt=menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

colorscheme molokai
let g:rehash256 = 1

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 100 characters
set lbr
set tw=100

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Some useful mappings
""""""""""""""""""""""""""""""
" 0 jump to non-blank character
nnoremap 0 ^
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let maplocalleader = ","

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <leader>wq :wq!<cr>
nnoremap <leader>qq :q!<cr>

" Change case for the word before 
inoremap <c-u> <esc>vb~ea

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Easy switch between buffers and tabs
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bb :bp<cr>
nnoremap <leader>tn :tabnext<cr>
nnoremap <leader>tb :tabprevious<cr>
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Shortcuts to modify vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Save to mac's clipboard
nnoremap <leader>cp :%w !pbcopy

" Disable highlight when <leader><cr> is pressed
nnoremap <silent> <leader><cr> :noh<cr>

" Autocomplete { , useful in C family language
inoremap {<CR>  {<CR>}<Esc>O
inoremap {}     {}

" Add quotes on selected area
vnoremap <leader>" <esc>`<<esc>i"<esc>`>a"<esc>
vnoremap <leader>' <esc>`<<esc>i'<esc>`>a'<esc>

" Add quotes to word on normal mode
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" Escape in insert mode
inoremap jk <esc>
" Force me to abandon escape key on stupid touchbar
"inoremap <esc> <nop>
" Open the last buffer on the right
nnoremap <leader>lb :execute "rightbelow vsplit " . bufname("#")<cr>

"""""""""""""""""""""""""""""""
" => Move around
"""""""""""""""""""""""""""""""
" jump to the previous function
nnoremap <silent> [f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
" jump to the next function
nnoremap <silent> ]f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>

" use j k to move in visual lines
nnoremap j gj
nnoremap k gk

"""""""""""""""""""""""""""""""
" => Operator-Pending Mappings
"""""""""""""""""""""""""""""""
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
"""""""""""""""""""""""""""""""
" => Abbreviations
"""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""
" => Personal Plugin
"""""""""""""""""""""""""""""""

" ============ grep code =====================
function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>


"""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""

" ============NERDTree=============
nnoremap <leader>nt :NERDTreeToggle<CR>
let g:NERDTreeMapJumpParent='-'
let g:NERDTreeMapPreview='p'
" Close vim when only NERDTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ============netrw=============
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 20
" ============ycm=============
let g:ycm_key_invoke_completion = '<c-k>'
let g:ycm_semantic_triggers =  {
    \ 'c': ['re!\w{2}'],
    \}
let g:ycm_python_interpreter_path = '/usr/local/bin/python3'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf="/Users/zhaohuaiyi/.vim/plugged/youcompleteme/third_party/ycmd/.ycm_extra_conf.py"
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" ============airline=============
let g:airline#extensions#tabline#enabled = 1
" ============Ultisnips=============
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" ============Nerdcommenter=============
" <leader>cc comment 
" <leader>cu uncoment
" <leader>c<space> toggle
" ============surroundings=============
" ys<motion><target>
" cs<target-a><target-b>
" ds<target>
" <visual>S<target>
" yss<target> operates on current line
" ============TagBar=============
nmap <leader>tt :TagbarToggle<CR>
let g:tagbar_autofocus = 0
let g:tagbar_sort = 0
" ============EasyMotion=============
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" notice below can't use noremap because of <Plug>
nmap <leader>s <Plug>(easymotion-overwin-f2)
nmap <leader>l <Plug>(easymotion-lineforward)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
nmap <leader>h <Plug>(easymotion-linebackward)
nmap <leader>/ <Plug>(easymotion-sn)
" ============gitgutter=============
set updatetime=200
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" <leader>hs to stage a hunk
" <leader>hu to undo a hunk
" <leader>hp to preview a hunk (useful when deleted)
" ============CtrlP=============
" Change default mode to save time when invoking from a large directory 
let g:ctrlp_cmd = 'CtrlPMRU' 
" ============Gundo=============
let g:gundo_prefer_python3=1
nnoremap <leader>ud :GundoToggle<CR>
