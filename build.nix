with import <nixpkgs> {};

mkShell {
    buildInputs = [
        neovim
        (python39.withPackages (ps: with ps; [ virtualenv setuptools wheel ]))

        # Sysadmin
        htop stow lolcat

        # CLI data view / search / processing
        bat fd fzf ripgrep miller jq yq icdiff

        # Dev environment
        cloc direnv entr modd devd

        # Benchmarking
        wrk

        # Language
        clojure go rust nodejs yarn
    ];
}
