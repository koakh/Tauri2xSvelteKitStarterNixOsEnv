{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Latest Rust toolchain from unstable
    cargo
    rustc
    rust-analyzer    
    # Tauri dependencies
    pkg-config
    webkitgtk_4_1
    gtk3
    cairo
    gdk-pixbuf
    glib
    dbus
    openssl_3
    librsvg
    libsoup_3
    atk
    pango    
    # Graphics drivers
    mesa
    libGL
    libGLU    
    # Additional tools
    nodejs
    yarn
  ];
  
  # Set environment variables
  WEBKIT_DISABLE_COMPOSITING_MODE = "1";
  PKG_CONFIG_PATH = "${pkgs.glib.dev}/lib/pkgconfig:${pkgs.libsoup_3.dev}/lib/pkgconfig:${pkgs.webkitgtk_4_1.dev}/lib/pkgconfig:${pkgs.atk}/lib/pkgconfig:${pkgs.gtk3.dev}/lib/pkgconfig:${pkgs.cairo.dev}/lib/pkgconfig";
  
  # gives: 
  # trace: evaluation warning: `mesa.drivers` is deprecated, use `mesa` instead
  # libEGL fatal: did not find extension DRI_Mesa version 1
  # Graphics environment variables - try pointing to our nix store paths
  # LD_LIBRARY_PATH = "${pkgs.mesa}/lib:${pkgs.libGL}/lib:${pkgs.mesa.drivers}/lib";
  # LIBGL_DRIVERS_PATH = "${pkgs.mesa.drivers}/lib/dri";

  LD_LIBRARY_PATH = "${pkgs.mesa}/lib:${pkgs.libGL}/lib:/run/opengl-driver/lib";
  LIBGL_DRIVERS_PATH = "/run/opengl-driver/lib/dri";

  # LIBGL_ALWAYS_SOFTWARE = "1";
}