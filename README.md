What Is This?
=============

I keep all my vim plugins either directly in here or as submodules recognized by pathogen in the bundle directory.  My .vimrc is here and can be symlinked from wherever your system wants it.  You'll see I assume different behavior in GUI vs non-GUI modes.  I change this all the time and it's not meant to be universal, just my preferences.

    git clone git://github.com/milimetric/vim-config.git ~/.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim
    run :PluginInstall in vim
