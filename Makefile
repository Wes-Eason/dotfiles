# Put each file where it needs to be in the user's home directory
#
# WARNING: will overwrite existing files
# TODO: Change to single expanding rule
# TODO: Recipe to use symlinks instead of copying

INSTALL := install -o "$(shell whoami)" -m 0544

.PHONY: install
all: $$HOME/.tmux.conf
all: $$HOME/.vimrc
all: $$HOME/.bashrc
all: $$HOME/.bash_pathlist
all: $$HOME/.bash_aliases
all: $$HOME/.bash_profile
all: $$HOME/Makefile


$$HOME/.tmux.conf : tmux.conf Makefile
	$(INSTALL) tmux.conf $@;
 
$$HOME/.vimrc : vimrc Makefile
	[ -d ~/.vimbackup ] || mkdir ~/.vimbackup
	$(INSTALL) vimrc $@;

$$HOME/.bashrc : bashrc Makefile
	$(INSTALL) bashrc $@;

$$HOME/.bash_pathlist : bash_pathlist Makefile
	$(INSTALL) bash_pathlist $@;

$$HOME/.bash_aliases : bash_aliases Makefile
	$(INSTALL) bash_aliases $@;
 
$$HOME/.bash_profile : bash_profile Makefile
	$(INSTALL) bash_profile $@;

$$HOME/Makefile : _Makefile Makefile
	$(INSTALL) _Makefile $@;
	
