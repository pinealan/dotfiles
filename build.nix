with import <nixpkgs> {};
{
  buildInputs = [
    neovim
    python37.withPackages (ps: with ps; [ pynvim ])
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
  ]
}
