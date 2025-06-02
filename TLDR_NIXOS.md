# TLDR NIXOS

## Open VSCode With Nix Env

### From Shell

```shell
# option #1 after load nix shell environment
$ cd ~/Development/Rust/@Tauri/Tauri2xSvelteKitStarterNixOsEnv
direnv: loading ~/Development/Rust/@Tauri/Tauri2xSvelteKitStarterNixOsEnv/.envrc
direnv: using nix
info: component 'rust-std' for target 'aarch64-linux-android' is up to date
info: component 'rust-std' for target 'armv7-linux-androideabi' is up to date
info: component 'rust-std' for target 'i686-linux-android' is up to date
info: component 'rust-std' for target 'x86_64-linux-android' is up to date
[✔] Debug tools available:
  - GDB: /nix/store/j87n5xqfj6c03633g7l95lfjq5ynml13-gdb-16.2/bin/gdb
[✔] Rust and Android targets set up
[✔] Android SDK: /home/mario/Android/Sdk
[✔] Android NDK: /home/mario/Android/Sdk/ndk/29.0.13113456
[✔] NIX_LD configured for Android NDK compatibility
[✔] NIX_LD: /nix/store/cg9s562sa33k78m63njfn1rw47dp9z0i-glibc-2.40-66/lib/ld-linux-x86-64.so.2
[✔] NIX_LD_LIBRARY_PATH configured
[✔] xdg-open available at: /nix/store/gwvwba438v6z5wwl6s3wdzm2jvi9ma60-xdg-utils-1.2.1/bin/xdg-open
direnv: export +ANDROID_HOME +APPIMAGE_EXTRACT_AND_RUN +AR +AS +CC +CONFIG_SHELL +CXX +DETERMINISTIC_BUILD +GETTEXTDATADIRS +GSETTINGS_SCHEMAS_PATH +HOST_PATH +IN_NIX_SHELL +LD +LIBGL_ALWAYS_SOFTWARE +NDK_HOME +NIX_BINTOOLS +NIX_BINTOOLS_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu +NIX_BUILD_CORES +NIX_BUILD_TOP +NIX_CC +NIX_CC_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu +NIX_CFLAGS_COMPILE +NIX_ENFORCE_NO_NATIVE +NIX_HARDENING_ENABLE +NIX_LDFLAGS +NIX_PKG_CONFIG_WRAPPER_TARGET_TARGET_x86_64_unknown_linux_gnu +NIX_STORE +NM +NODE_PATH +OBJCOPY +OBJDUMP +PKG_CONFIG_FOR_TARGET +PKG_CONFIG_PATH_FOR_TARGET +PYTHONHASHSEED +PYTHONPATH +RANLIB +READELF +SIZE +SOURCE_DATE_EPOCH +STRINGS +STRIP +TAURI_BUNDLE_LINUXDEPLOY_BIN +TEMP +TEMPDIR +TMP +TMPDIR +WEBKIT_DISABLE_COMPOSITING_MODE +_PYTHON_HOST_PLATFORM +_PYTHON_SYSCONFIGDATA_NAME +__structuredAttrs +buildInputs +buildPhase +builder +cmakeFlags +configureFlags +depsBuildBuild +depsBuildBuildPropagated +depsBuildTarget +depsBuildTargetPropagated +depsHostHost +depsHostHostPropagated +depsTargetTarget +depsTargetTargetPropagated +doCheck +doInstallCheck +mesonFlags +name +nativeBuildInputs +out +outputs +patches +phases +preferLocalBuild +propagatedBuildInputs +propagatedNativeBuildInputs +shell +shellHook +stdenv +strictDeps +system ~JAVA_HOME ~NIX_LD ~NIX_LD_LIBRARY_PATH ~PATH ~PYTHONNOUSERSITE ~XDG_DATA_DIRS

$ code .

# option #2 launch vscode and let it open nix shell environment from `.envrc`
$ code ~/Development/Rust/@Tauri/Tauri2xSvelteKitStarterNixOsEnv
```

### Build Tauri App before Launch Debugger

```shell
# TODO:
$ nix-hell
$ npm run tauri:dev
```

### Launch With Debugger

1. select config **Debug Tauri (GDB)** and launch Debugger

> to see backend logs, change to tab "debug console" on vscode

### Launch Frontend Debug

> in lunux we must debug from a external window

1. select config **Lauch Tauri in Browser** and launch Debugger
