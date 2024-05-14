" Initialize Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'VundleVim/Vundle.vim'

Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'altercation/vim-colors-solarized'

Plugin 'luochen1990/rainbow'

" Language specific bundles
Bundle 'mv/mv-vim-puppet'

call vundle#end()

" turn filetype back on, Vundle stuff is done
filetype on

let g:NERDMenuMode=0

" configuration for Vundles
let g:rainbow_active = 1
let g:ackprg = 'ag'
map <Leader>f :Ack!<Space>
map <Leader>F :AckAdd<Space>


" turn off toolbar
set guioptions-=T
" turn on incremental search
set incsearch
" set font
set guifont=Fira\ Code\ Retina\ weight\=450\ 16
" show invisible whitespace
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" numbers and guides
set number
set ruler

" map <Leader>buffers to write all open buffers into a file: TODO: there has
" Got to be a simpler way
" noremap <silent> <leader>buffers :call writefile( map(filter(range(0,bufnr('$')), 'buflisted(v:val)'), 'fnamemodify(bufname(v:val), ":p")'), '/home/dan/temp.txt' )<CR>

" ******** HACKS
" hacks to make blank lines stay indented
"inoremap <CR> <CR>x<BS>
"nnoremap o ox<BS>
"nnoremap O Ox<BS>
" hacks to make paste keep what you're pasting
xnoremap p pgvy
xnoremap P Pgvy

" start the project management but only in gui mode
function! StartUpProject()
    let g:NERDTreeIgnore=['\.swp$', '\~$', '\.pyc$']
    map <F12> :NERDTreeToggle<CR>
    map <C-n> :bn<CR>
    map <C-p> :bp<CR>
    let g:NERDTreeChDirMode=2
    nmap <silent> <C-Up> :wincmd k<CR>
    nmap <silent> <C-Down> :wincmd j<CR>
    nmap <silent> <C-Left> :wincmd h<CR>
    nmap <silent> <C-Right> :wincmd l<CR>

    " TODO: set ignores if they're not read from setup.cfg
    " let g:syntastic_python_mri_args=""
endfunction

" initialize NERDTree and buffer navigation
autocmd VimEnter * call StartUpProject()

if has("gui_running")

    " maximize (depends on wmctrl)
    autocmd VimEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)

    if has("unix")
        " make the un-named buffer and the OS copy/paste buffer one and the same
        set clipboard=unnamedplus
    endif

    " Colorscheme - Solarized by Ethan Schoonover
    syntax enable
    set background=dark
    colorscheme solarized

    " persists open buffers in gui mode.  Usually it's all I need
    " TODO: doesn't work with NERDTree very well
    "fu! SaveSess()
        "execute 'mksession! ~/.vim/lastSession'
    "endfunction

    "fu! RestoreSess()
        "execute 'so ~/.vim/lastSession'
    "endfunction

    "autocmd VimLeave * call SaveSess()
    "autocmd VimEnter * call RestoreSess()
end

" developer settings
set noexpandtab
set tabstop=4
set shiftwidth=4
syntax on
filetype plugin indent on

" keeps undo history when switching buffers
set hidden

if has("unix")
    " load documentations
    helptags ~/.vim/doc/
endif
if !has("unix")
    " load documentations
    exe 'helptags ' . $HOME . "\\vimfiles\\doc"
endif


augroup filetypedetect
  " for .hql files
  au BufNewFile,BufRead *.hql set filetype=sql syntax=sql
augroup END

" Python checking ignores
let g:flake8_ignore='E501'",E128,E225'

" Awesome shortcuts I don't want to forget
map <Leader>fix :%s/_\(.\)/\U\1/gc
