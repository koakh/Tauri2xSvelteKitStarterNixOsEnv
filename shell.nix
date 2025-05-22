{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { } }:

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

    # Graphics drivers: opted to LIBGL_ALWAYS_SOFTWARE to swallow warning
    # mesa
    # libGL
    # libGLU

    # Additional tools
    nodejs
    yarn
  ];

  # GPU-related env variables
  # LD_LIBRARY_PATH = "${pkgs.mesa}/lib:${pkgs.libGL}/lib:/run/opengl-driver/lib";
  # LIBGL_DRIVERS_PATH = "/run/opengl-driver/lib/dri";
  # LD_LIBRARY_PATH = "${pkgs.mesa}/lib:${pkgs.libGL}/lib:${pkgs.mesa.drivers}/lib:/run/opengl-driver/lib";
  # LIBGL_DRIVERS_PATH = "${pkgs.mesa.drivers}/lib/dri";
  WEBKIT_DISABLE_COMPOSITING_MODE = "1";
  LIBGL_ALWAYS_SOFTWARE = "1";

  # Expose system DRI and GPU paths
  # shellHook = ''
  #   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/run/opengl-driver/lib
  #   export LIBGL_DRIVERS_PATH=/run/opengl-driver/lib/dri

  #   if [ -e /dev/dri ]; then
  #     echo "[✔] /dev/dri available — GPU drivers should work"
  #   else
  #     echo "[!] /dev/dri missing — GPU acceleration may not work"
  #   fi
  # '';
}

