# Put each file where it needs to be in the user's home directory
#
# WARNING: will overwrite existing files
# TODO: Change to single expanding rule
# TODO: Recipe to use symlinks instead of copying


.PHONY: install
all: $$HOME/.tmux.conf
all: $$HOME/.vimrc
all: $$HOME/.bashrc
all: $$HOME/.bash_pathlist
all: $$HOME/.bash_aliases
all: $$HOME/.bash_profile


$$HOME/.tmux.conf : tmux.conf Makefile
	cp tmux.conf $@;
 
$$HOME/.vimrc : vimrc Makefile
	cp vimrc $@;

$$HOME/.bashrc : bashrc Makefile
	cp bashrc $@;

$$HOME/.bash_pathlist : bash_pathlist Makefile
	cp bash_pathlist $@;

$$HOME/.bash_aliases : bash_aliases Makefile
	cp bash_aliases $@;
 
$$HOME/.bash_profile : bash_profile Makefile
	cp bash_profile $@

