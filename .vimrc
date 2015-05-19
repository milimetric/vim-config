set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle Bundles
Bundle 'gmarik/vundle'
Bundle 'mv/mv-vim-puppet'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'satyr/vim-coco'
Bundle 'altercation/vim-colors-solarized'
Bundle 'nvie/vim-flake8'
Bundle 'digitaltoad/vim-jade'
Bundle 'vim-scripts/vim-json-bundle'
Bundle 'wavded/vim-stylus'


" give pathogen access
call pathogen#infect()

" turn off toolbar
set guioptions-=T
" turn on incremental search
set incsearch
" set font
set guifont=Ubuntu\ Mono\ 16
" show invisible whitespace
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

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
    map <A-n> :bn<CR>
    map <A-p> :bp<CR>
    let g:NERDTreeChDirMode=2
    nmap <silent> <A-Up> :wincmd k<CR>
    nmap <silent> <A-Down> :wincmd j<CR>
    nmap <silent> <A-Left> :wincmd h<CR>
    nmap <silent> <A-Right> :wincmd l<CR>

    " syntax checker settings
    let g:syntastic_python_checkers=['flake8']
    " TODO: set ignores if they're not read from setup.cfg
    " let g:syntastic_python_mri_args=""
endfunction

function! MaximizeWindow()
  set lines=999
  set columns=999
endfunction

if has("gui_running")

    " maximize
    autocmd GUIEnter * call MaximizeWindow()

    if has("unix")
        " make the un-named buffer and the OS copy/paste buffer one and the same
        set clipboard=unnamedplus
    endif

    " initialize NERDTree and buffer navigation
    autocmd VimEnter * call StartUpProject()

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
set expandtab
set tabstop=4
set shiftwidth=4
syntax on
filetype plugin indent on

" keeps undo history when switching buffers
set hidden

" Coco settings
vnoremap <C-B> :CocoCompile<CR>

if has("unix")
    " load documentations
    helptags ~/.vim/doc/
endif
if !has("unix")
    " load documentations
    exe 'helptags ' . $HOME . "\\vimfiles\\doc"
endif


" Any old plugins that don't use pathogen
augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END

" Python checking ignores
let g:flake8_ignore='E501'",E128,E225'

" Awesome shortcuts I don't want to forget
map <Leader>fix :%s/_\(.\)/\U\1/gc

" keeping window position while moving around buffers
" NOTE: this turns out to be kind of glitchy and annoying
"if v:version >= 700
  "au BufLeave * let b:winview = winsaveview()
  "au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
"endif
