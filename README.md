_Disclaimer: These dotilfes hevaily modifies each application behaviour.
Use at your own risk_

These dotfiles are managed with GNU stow. Stow manages files by creating
symlinks in one directory tree to another.

Start by setting up this repository at your home folder.

```
cd ~
git clone https://github.com/pinealan/dotfiles
```

Then, if you already have stow installed, you may start installing

```
cd dotfiles
stow bash
```

This will create symlinks named **.bash_aliases**, **.bashrc**, and **.profile** 
in your home folder, linked to the corresponding files in the bash folder.

GNU Stow [full reference](https://www.gnu.org/software/stow/manual/stow.html)
