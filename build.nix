with import <nixpkgs> {};

mkShell {
    # Many of these tools are listed in Modern Unix
    # https://github.com/ibraheemdev/modern-unix
    buildInputs = [
        # Sysadmin
        htop stow lolcat as-tree gping duf exa

        # CLI data view / search / processing
        bat fd fzf ripgrep miller jq yq icdiff hexyl

        # Dev environment
        direnv entr modd devd delta scc
        curlie gh

        # Benchmarking
        wrk hyperfine

        # Language
        clojure go rustup nodejs yarn
        (python39.withPackages (ps: with ps; [ virtualenv setuptools wheel ]))
    ];
}
