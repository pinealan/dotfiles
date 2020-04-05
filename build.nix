with import <nixpkgs> {};
{
    buildInputs = [
        neovim
        python37.withPackages (ps: with ps; [ pynvim ])

        # Sys
        htop stow

        # Search and View
        bat fd fzf ranger ripgrep

        # Data processing
        jq yq

        # Dev environment
        direnv entr tmux

        # Benchmarking
        hyperfine wrk

        # Language
        clojure go rust nodejs yarn
    ]

}
