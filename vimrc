" Temp Section

:nnoremap <F3> :w !detex \| wc -w<cr>
:nnoremap <f4> :call ToggleIndent()<cr>
:nnoremap <f2> z=1<cr>
" ##########################################
" ##########################################
" Defaults
" ##########################################

" Leader
let mapleader = "\<Space>"

" - General Settings =======================
:set backupdir=~/.vimbackup

" Appearance 
:set number
:syntax on

" - Editor Behavior ========================
:set textwidth=80

" --- Tab Stops
:set tabstop=4
:set shiftwidth=4
:set softtabstop=4
:set tabstop=4

" --- Indentation
if has("autocmd")
	filetype plugin indent on
endif

" ##########################################
" Normal Mode Key Bindings
" ##########################################

" Navigation
:nnoremap <c-k> 5<c-y> 5k
:nnoremap <c-j> 5<c-e> 5j
:nnoremap J 5j
:nnoremap K 5k

:nnoremap H <home>
:nnoremap L <end>

" Macros
:nnoremap ; @

" ##########################################
" Leader Shortcut Key Bindings
" ##########################################

" Commonly Used
:nnoremap <leader>w :w<cr>
:nnoremap <leader>q :wq<cr>

" Tabs
nnoremap <leader>o gt
nnoremap <leader>w gT
	
" Indentation
:nnoremap <leader>et :set expandtab!<cr>

" Enable Spell Check
:nnoremap<leader>sp :setlocal spell! spelllang=en_us<cr>

" Vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Development
nnoremap <leader>s :shell<cr>
nnoremap <leader>m :make<cr>

" ##########################################
" Disable Annoying Features
" ##########################################

" Disable ex-mode
:nnoremap Q <nop>
