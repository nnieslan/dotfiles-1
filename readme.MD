# BlueTufa dotfiles Private Repository
## Contents
A comprensive collection of Fish (Friendly Interactive Shell) and ZSH dotfiles which will allow a quick and easy customization of Fish on an existing system.  This configuration will generally work cross-platform betwen MacOS and Linux, although you may encounter minor bugs on either.  

### Symlinking dotfiles
You can symlink your dotfiles from this repo into the home directory by running the `link-dotfiles.sh` file at the root of this repository.  Linking your dotfiles will first attempt to make backups of any existing dotfiles before establishing the link, but it is recommended that some prep work be done - such as a full backup - to be confident that you won't lose any work.  

### Fish support
To permanently change the default shell to Fish, run the following from bash:
`chsh -s $(which fish) $(whoami)`

### ZSH support 
The ZSH support is rather bare-bones but it will automatically install oh-my-zsh and powerlevel10k.  From there, it will likely automatically run the powerlevel10k wizard, or you can run `p10k configure` at any time.  

To permanently change the default shell to ZSH, run the following from bash:
`chsh -s $(which zsh) $(whoami)`

### Neovim support
This directory includes a basic neovim configuration as well.  If you run `./link-dotfiles.sh` it will automatically symlink neovim's init.vim and install vim-plug for you.   

Or, if you prefer not to run the symlinking and still want to use the init.vim, remember to install vim-plug manually:
  `curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

Then once inside neovim, you will likely see errors until you run: `:PlugInstall`

The following are included in init.vim with customizations:
* coc.nvim 
* Nerdtree
* Airline
* Terminal support

### Backup with rsync
This repo includes a simple script that will backup to an encrypted external drive using rsync.  You may need to modify it depending on your hardware configuration and operating system.

### Example script for mounting an encrypted Luks volume
Again, this may vary based on your hardware and operating system configuration.

### Various technical README's
Mostly Arch Linux notes.
