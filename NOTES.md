# NOTES

## Links

- [Just a moment...](https://claude.ai/chat/da75c4ad-8e76-44a7-ae23-fd156fee59be)
- [Just a moment...](https://chatgpt.com/c/682f53af-a5c4-8004-834c-42370c490630)

- [What is Tauri?](https://tauri.app/start/)
- [Android ndk for cargo-tauri package](https://discourse.nixos.org/t/android-ndk-for-cargo-tauri-package/59356)
- [Just a moment...](https://stackoverflow.com/questions/39159357/how-to-set-android-ndk-home-so-that-android-studio-does-not-ask-for-ndk-location)

## Botstrap Project

add `"tauri:dev": "npm run tauri dev"` to scripts

```shell
$ ANDROID_HOME=/home/mario/Android
$ NDK_HOME=/home/mario/Android/Sdk/ndk/29.0.13113456

$ npm create tauri-app@latest

$ npm run tauri android init
Generating Android Studio project...
        Info "/tmp/tauri-app/src-tauri" relative to "/tmp/tauri-app/src-tauri/gen/android/tauri_app" is "../../../"
victory: Project generated successfully!
    Make cool apps! 🌻 🐕 🎉

$ rustup update

# now run 
$ npm run tauri:dev
```

### Add Required NixOS Tweaks

- [Just a moment...](https://chatgpt.com/c/682f53af-a5c4-8004-834c-42370c490630)

#### Option 2: Include hardware.opengl via nix-shell + nixos-configuration

If you want actual GPU support (e.g. for performance):

Ensure your configuration.nix includes:

```nix
  # optional fix for tauri apps have access to GPU
  # https://chatgpt.com/c/682f53af-a5c4-8004-834c-42370c490630
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
```

And in your shell, add:

```shell
# TODO:
```

```shell
$ nix-shell
[✔] /dev/dri available — GPU drivers should work
$ echo $DISPLAY
:0
# You should see something like :0. If it's empty, you're not in a graphical session.

$ npm run tauri:dev

  VITE v6.3.5  ready in 1054 ms

  ➜  Local:   http://localhost:1420/
     Running DevCommand (`cargo  run --no-default-features --color always --`)
        Info Watching /home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri for changes...
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.63s
     Running `target/debug/tauri-app`
MESA-LOADER: failed to open dri: /run/opengl-driver/lib/gbm/dri_gbm.so: cannot open shared object file: No such file or directory (search paths /run/opengl-driver/lib/gbm, suffix _gbm)
Failed to create GBM device for DRM node: /dev/dri/renderD128: No such file or directory
```
