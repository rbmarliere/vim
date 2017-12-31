# vim

```bash
#!/bin/bash

vim-setup() {
	rm -rf ~/.vim*
	git clone --recursive -git@github.com/zrts/vim.git ~/.vim
	mkdir -p ~/.vim/{bkp,sessions,swp}
	ln -s ~/.vim/vimrc ~/.vimrc
}

vim-update() {
	pwd=$(pwd)
	cd ~/.vim
	git pull origin master
	git submodule sync
	git submodule update --init
	cd $pwd
}
```
