
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    gcc
  ];
  shellHook = ''
    alias ll="ls -l"
    export FOO=bar
  '';
}

