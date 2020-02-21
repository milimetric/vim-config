" Initialize Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle
Bundle 'VundleVim/Vundle.vim'

Bundle 'mileszs/ack.vim'

Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
"Bundle 'scrooloose/syntastic'
Plugin 'neomake/neomake'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'

Bundle 'godlygeek/tabular'

Bundle 'altercation/vim-colors-solarized'
Plugin 'luochen1990/rainbow'

" Language specific bundles
" Bundle 'marijnh/tern_for_vim
" Bundle 'nvie/vim-flake8'
Bundle 'satyr/vim-coco'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'mv/mv-vim-puppet'
Plugin 'derekwyatt/vim-scala'
Plugin 'Chiel92/vim-autoformat'
Plugin 'leafgarland/typescript-vim'
Plugin 'posva/vim-vue'
Plugin 'stephenway/postcss.vim'

" Games
Plugin 'vim/killersheep'

call vundle#end()

" turn filetype back on, Vundle stuff is done
filetype on

let g:NERDMenuMode=0

" configuration for Vundles
let g:rainbow_active = 1
let g:ackprg = 'ag'
map <Leader>f :Ack!<Space>
map <Leader>F :AckAdd<Space>
" syntax checker settings
"let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_javascript_checkers = ['eslint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ['flake8']
"let g:neomake_error_sign = { 'text': 'E>', 'texthl': 'ErrorMsg', }
"let g:neomake_warning_sign = { 'text': 'W>', 'texthl': 'WarningMsg', }
augroup my_neomake_signs
    au!
    autocmd ColorScheme *
        \ hi NeomakeErrorSign ctermfg=red |
        \ hi NeomakeWarningSign ctermfg=yellow
augroup END


" prevent scala files from taking forever to save
let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['java', 'scala']}

" Autoformatter
noremap <F5> :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt'"
let g:formatters_scala = ['scalafmt']



" turn off toolbar
set guioptions-=T
" turn on incremental search
set incsearch
" set font
set guifont=Fira\ Code\ weight\=450\ 16
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

" initialize auto-make
autocmd! BufWritePost * Neomake

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
  " for .hql files
  au BufNewFile,BufRead *.hql set filetype=sql syntax=sql
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
