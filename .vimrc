" give pathogen access
call pathogen#infect()

" turn off toolbar
set guioptions-=T
" turn on incremental search
set incsearch
" set font
set guifont=Ubuntu\ Mono\ 14
" show invisible whitespace
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" fix grep TODO : this is still far from ideal, turn into a plugin
set grepprg=grep\ -r\ -i\ -s\ -I\ -o\ -T
" map <Leader>r :grep! 
map <Leader>f :SearchAll 
map <Leader>F :SearchAll

" map <Leader>buffers to write all open buffers into a file: TODO: there has
" Got to be a simpler way
noremap <silent> <leader>buffers :call writefile( map(filter(range(0,bufnr('$')), 'buflisted(v:val)'), 'fnamemodify(bufname(v:val), ":p")'), '/home/dan/temp.txt' )<CR>

" ******** HACKS
" hacks to make blank lines stay indented
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
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
endfunction

function! MaximizeWindow()
  set lines=999
  set columns=999
endfunction

if has("gui_running")
    set expandtab
    
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
