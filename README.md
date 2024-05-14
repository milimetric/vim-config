What Is This?
=============

I change this from time to time and it's not meant to be universal, just my preferences.  I develop javascript, python, C#, some Java and Scala with these settings.  Install on Debian like this:

    git clone git@github.com:milimetric/vim-config.git ~/.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    sudo apt install wmctrl
    ln -s ~/.vim/.vimrc ~/.vimrc
    sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
    sudo apt install fonts-firacode
    vim
    :VundleInstall
