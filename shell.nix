{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Rust toolchain
    rust-analyzer
    rustup

    # Debug tools for VS Code
    gdb

    # Optional: CodeLLDB extension dependencies
    python3

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

    # Additional tools
    nodejs
    yarn
    nodePackages_latest.pnpm

    # Linux bundling dependencies
    xdg-utils # Provides xdg-open and other xdg utilities to build Appimage
    dpkg # For .deb package creation
    rpm # For .rpm package creation
    appimage-run # For AppImage support    

    # Android development
    openjdk17 # Required for Android Gradle Plugin

    # NIX_LD dependencies for running unpatched binaries
    nix-ld
    stdenv.cc.cc.lib
    zlib
    ncurses5

    fuse
  ];

  ANDROID_HOME = "/home/mario/Android/Sdk";
  NDK_HOME = "/home/mario/Android/Sdk/ndk/29.0.13113456";
  JAVA_HOME = "${pkgs.openjdk17}";

  # GPU-related env variables
  WEBKIT_DISABLE_COMPOSITING_MODE = "1";
  LIBGL_ALWAYS_SOFTWARE = "1";

  # NIX_LD configuration for running unpatched binaries (Android NDK tools)
  NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.glibc
    pkgs.ncurses5
    pkgs.nix-ld
    pkgs.stdenv.cc.cc
    pkgs.zlib
    pkgs.fuse
    pkgs.libpulseaudio
  ];  
  NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";

  shellHook = ''
        # Use rustup's rust instead of Nix's
        export PATH="$HOME/.cargo/bin:$PATH"

        # Add Android tools to PATH
        export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$PATH"
        export PATH="$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"

        # Linuxdeploy setup (AppImage)
        export TAURI_BUNDLE_LINUXDEPLOY_BIN="$HOME/.local/bin/linuxdeploy"

        if [ ! -f "$TAURI_BUNDLE_LINUXDEPLOY_BIN" ]; then
          echo "[✔] Downloading linuxdeploy..."
          mkdir -p ~/.local/bin
          curl -L https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage -o "$TAURI_BUNDLE_LINUXDEPLOY_BIN"
          chmod +x "$TAURI_BUNDLE_LINUXDEPLOY_BIN"
          echo "[✔] linuxdeploy downloaded to $TAURI_BUNDLE_LINUXDEPLOY_BIN"
        fi

        # Allow AppImage to extract instead of mount (helps on NixOS)
        export APPIMAGE_EXTRACT_AND_RUN=1

        # Make sure it's in your PATH
        export PATH="$HOME/.local/bin:$PATH"

        # Ensure the correct Rust targets are available
        rustup target add aarch64-linux-android || true
        rustup target add armv7-linux-androideabi || true
        rustup target add i686-linux-android || true
        rustup target add x86_64-linux-android || true

        # Create cargo config if it doesn't exist
        mkdir -p ~/.cargo
        if [ ! -f ~/.cargo/config.toml ]; then
          cat > ~/.cargo/config.toml << 'EOF'
    [target.aarch64-linux-android]
    linker = "/home/mario/Android/Sdk/ndk/29.0.13113456/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang"

    [target.armv7-linux-androideabi]
    linker = "/home/mario/Android/Sdk/ndk/29.0.13113456/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi30-clang"

    [target.i686-linux-android]
    linker = "/home/mario/Android/Sdk/ndk/29.0.13113456/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android30-clang"

    [target.x86_64-linux-android]
    linker = "/home/mario/Android/Sdk/ndk/29.0.13113456/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android30-clang"
    EOF
          echo "[✔] Created ~/.cargo/config.toml with Android linkers"
        fi

        # Verify debug tools are available
        echo "[✔] Debug tools available:"
        echo "  - GDB: $(which gdb || echo 'not found')"
        
        echo "[✔] Rust and Android targets set up"
        echo "[✔] Android SDK: $ANDROID_HOME"
        echo "[✔] Android NDK: $NDK_HOME"
        echo "[✔] NIX_LD configured for Android NDK compatibility"
        
        # Verify NIX_LD setup
        echo "[✔] NIX_LD: $NIX_LD"
        echo "[✔] NIX_LD_LIBRARY_PATH configured"
        echo "[✔] xdg-open available at: $(which xdg-open)"
  '';
}
