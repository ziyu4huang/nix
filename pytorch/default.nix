# http://ghedam.at/15978/an-introduction-to-nix-shell
with (import <nixpkgs> {});

let
  my-python-packages = python-packages: with python-packages; [
    pip
    jupyterlab
    pandas
    requests
    mpmath
    # other python packages you want
    #
  ];
  python-with-my-packages = python311.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    python-with-my-packages
  ];

  shellHook = ''
# allow pip to install wheels 
unset SOURCE_DATE_EPOCH 
    alias ll="ls -l"
    export FOO=bar
  '';
}
