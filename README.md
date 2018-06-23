These dotfiles are managed with GNU stow. Stow manages files by creating
symlinks in one directory tree to another.

Start by setting up this repository at your home folder. To install a set of
configurations, for example, run
    ```bash
    stow bash
    ```
This will create symlinks named **.bash_aliases**, **.bashrc**, and **.profile** 
in your home folder, linked to the corresponding files in the bash folder.

GNU Stow [full reference](https://www.gnu.org/software/stow/manual/stow.html)
