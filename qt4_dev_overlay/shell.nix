{ pkgs ? import <nixpkgs-23.05> {} }:

pkgs.mkShell {
  buildInputs = [
    (import ./qt48 { inherit (pkgs) stdenv lib fetchurl 
      substituteAll coreutils perl zlib which libcxx icu fetchpatch
      libXrender libXinerama libXcursor libXv libXext
      libXrandr libSM freetype fontconfig libjpeg libpng
      libmng libGLU openssl dbus cups pkg-config
      libtiff glib libmysqlclient postgresql sqlite libXi
      libobjc ApplicationServices OpenGL Cocoa AGL
      gtk2 gdk-pixbuf
      libgnomeui GConf gnome_vfs
    ; })
    # ... other packages
  ];
}
