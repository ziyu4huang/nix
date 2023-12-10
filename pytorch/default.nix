# http://ghedam.at/15978/an-introduction-to-nix-shell
with (import <nixpkgs> {});

let
  my-python-packages = python-packages: with python-packages; [
    pip
    jupyterlab
    pandas
    requests
    # other python packages you want
  ];
  python-with-my-packages = python310.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    python-with-my-packages
    lunarvim
  ];
  shellHook = ''
    alias ll="ls -l"
    export FOO=bar
  '';
}
