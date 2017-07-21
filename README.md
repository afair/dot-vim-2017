# Allen's Alternate .vim Configuration

This repo was Built as a new dot-vim directory and .vimrc file.
To keep it separate from the working configuration this was built
with a technique to manage multiple vim configurations.

## Installation

This repo uses submodules (sorry) to manage the plugins.

    cd
    git clone --recursive git@github.com:afair/dot-vim-2017.git .vim2

### Making this your primary configuration

Instead, clone into ~/.vim and create symlinks for the .\*rc files:

    cd
    git clone --recursive git@github.com:afair/dot-vim-2017.git .vim
    ln -s .vim/vimrc .vimrc
    ln -s .vim/gvimrc .gvimrc
    vim .vim/vimrc

The vim startup will throw an error, but that's what we're going to fix.
Hit enter to clear messages and edit the file.
Comment out this line near the top by inserting a double-quote at the
beginning of the line like so:

    " let &rtp = substitute(&rtp, '\.vim\>', '.vim2', 'g')

That line tells vim where to load pathogen and plugins. Save and restart
vim. Things should be normal. (Alternatively, you can create a symlink
from .vim to .vim2 as a workaround.)

## Manage multiple dot-vim configurations

This technique is useful to:

* Refresh your vim configuration but keep using the old one until ready to cut over.
* Give another user (pair programmer) thier own vim configuration on your account
* Have an alternate configuration for a special purpose

Create a new .vim2 directory for your configuration

    cd
    mkdir .vim2
    cd .vim2
    mkdir bundle autoload
    curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim  > autoload/pathogen.vim
    git init
    vim ~/.vim2/vimrc ~/.vim2/gvimrc

Set up your new vimrc with a line to change your trtp (run time path/dir) to your new dot-vim repo and load pathogen
or your package manager of choice:

    let &rtp = substitute(&rtp, '\.vim\>', '.vim2', 'g')
    set nocompatible
    execute pathogen#infect()
    syntax on
    filetype plugin indent on
    " Add your configurations below this...

Note that ".vim2" refers to the new configuration directory.
If you are using an alternate name, change it in the `substitute()` function.
The new .vimrc and .gvimrc files live in the directory instead of your home directory.

You will need a gvimrc of you use the GUI editor, otherwise the .gvimrc may still be loaded. Minimally, I use:

    set guifont=Monaco:h14
    set guioptions-=T               " Turn off toolbar
    set vb                          " Visual Bell

Add your pluigins of choice. [Vim Awesome](http://vimawesome.com/) is a great place to find curated plugins.
Use git submodules, repo clones, or extracts.

    cd ~/.vim2/bundle
    git submodule add https://github.com/vim-syntastic/syntastic.git
    # ... etc.

As you add plugins, check the README for configuration options and set them in your ~/.vim2/vimrc file.

To set up the alternate configuration, create some alias' for vim and your gvim of choice.
I placed these in my ~/.bashrc or ~/.zshrc file.

    alias vim2='vim -u ~/.vim2/vimrc'
    alias mvim2='mvim -u ~/.vim2/vimrc -U ~/.vim2/gvimrc'

Then, cross your fingers and try it out. (Of course, I tried it out after each step to check for errors.)

    vim2 myfile
    mvim2 myotherfile

Once satisfied, Save the repo to one you just created on github.

    cd ~/.vim2
    git commit -a
    git remote add origin git@github.com:xxxxx/dot-vim.git
    git push -u origin master

### Extra Credit

Write a "vim configuration switcher" script that will swap links for .vim, .vimrc, and .gvimrc to .vim-$VERSION, .vim-$VERSION/vimrc, and .vim-$VERSION/gvimrc respectively. Until then, the above alias' are sufficient.

Enjoy!



