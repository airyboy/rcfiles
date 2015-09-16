if v:progname == 'nvim'
  let g:my_vim_dir = expand('~/.nvim')
  let g:my_vimrc = g:my_vim_dir . '/nvimrc'
else
  let g:my_vim_dir = expand('~/.vim')
  let g:my_vimrc = expand('~/.vimrc')
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/dbext.vim'
"Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-endwise'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'bling/vim-airline'
	
call vundle#end()           

let mapleader=","
"nmap <Leader>t :tabnew<CR>:NERDTree<CR>
nmap <Leader><Leader> :NERDTreeFind<CR>zz
" Write current file
nmap <Leader>w :w<CR>
" vim-rails switch to related file
nmap  <Leader>r :R<CR>
" List buffers
map <Leader>b :buffers<CR>
let g:ctrlp_map  = '<Leader>t'

set number
set showcmd
set cursorline
set tabstop=2
set expandtab
set shiftwidth=2
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
:nnoremap <Leader>f <C-^>

set statusline+=%#warningmsg#
set statusline+=%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:airline#extensions#tabline#enabled = 1

" Backups, undos, and swap files
"-----------------------------------------------------------------------------
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory(g:my_vim_dir . '/backup') == 0
  execute 'silent !mkdir -p ' . g:my_vim_dir . '/backup >/dev/null 2>&1'
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
execute 'set backupdir^=' . g:my_vim_dir . '/backup/'
set backupdir^=./.vim-backup/
set backup
" Prevent backups from overwriting each other. The naming is weird,
" since I'm using the 'backupext' variable to append the path.
" So the file '/home/docwhat/.vimrc' becomes '.vimrc%home%docwhat~'
if has('autocmd')
  autocmd BufWritePre * nested let &backupext = substitute(expand('%:p:h'), '/', '%', 'g') . '~'
endif


if has('macunix')
  set backupskip+=/private/tmp/*
endif

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory(g:my_vim_dir . '/swap') == 0
  execute 'silent !mkdir -p ' . g:my_vim_dir . '/swap >/dev/null 2>&1'
endif
set directory=./.vim-swap//
execute 'set directory+=' . g:my_vim_dir . '/swap//'
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
execute 'set viminfo+=n' . g:my_vim_dir . '/viminfo'
set viminfo^=!,h,f0,:100,/100,@100

if exists('+undofile')
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory(g:my_vim_dir . '/undo') == 0
    execute 'silent !mkdir -p ' . g:my_vim_dir . '/undo >/dev/null 2>&1'
  endif
  set undodir=./.vim-undo/
  execute 'set undodir+=' . g:my_vim_dir . '/undo/'
  set undofile
  set undolevels=1000         " maximum number of changes that can be undone
  set undoreload=10000        " maximum number lines to save for undo on a buffer reload
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers         = ['mri', 'jruby', 'rubocop']
let g:syntastic_error_symbol          = '✗✗'
let g:syntastic_warning_symbol        = '⚠⚠'
let g:syntastic_style_error_symbol    = '✗'
let g:syntastic_style_warning_symbol  = '⚠'
let g:syntastic_ruby_rubocop_args     = '--display-cop-names'

colorscheme molokai
set autoindent

syntax on
hi Visual  guifg=#000000 guibg=#FFFFFF ctermbg=239 gui=none
filetype plugin indent on
