# NOTES

## Links

- [Just a moment...](https://claude.ai/chat/da75c4ad-8e76-44a7-ae23-fd156fee59be)

- [Just a moment...](https://chatgpt.com/c/682f53af-a5c4-8004-834c-42370c490630)

- [Just a moment...](https://claude.ai/chat/fe69970c-0119-463c-a8af-c5b2cb3338bd)

- [What is Tauri?](https://tauri.app/start/)
- [Android ndk for cargo-tauri package](https://discourse.nixos.org/t/android-ndk-for-cargo-tauri-package/59356)
- [Just a moment...](https://stackoverflow.com/questions/39159357/how-to-set-android-ndk-home-so-that-android-studio-does-not-ask-for-ndk-location)

## Botstrap Project

add `"tauri:dev": "npm run tauri dev"` to scripts

in shell window

```shell
$ export ANDROID_HOME=/home/mario/Android
$ export NDK_HOME=/home/mario/Android/Sdk/ndk/29.0.13113456

$ npm create tauri-20-starter-app@latest
name: tauri-20-starter-app

$ cd tauri-starter-2.0
$ npm i

$ npm run tauri android init
Generating Android Studio project...
        Info "/tmp/tauri-20-starter-app/src-tauri" relative to "/tmp/tauri-20-starter-app/src-tauri/gen/android/tauri_app" is "../../../"
victory: Project generated successfully!
    Make cool apps! 🌻 🐕 🎉

### Add Required NixOS Tweaks

- [Just a moment...](https://chatgpt.com/c/682f53af-a5c4-8004-834c-42370c490630)

#### Option 2: Include hardware.opengl via nix-shell + nixos-configuration

- create `shell.nix`
- create `.envrc` with `use nix`

instal, extension `Nix Extension Pack:v3.0.0`

now open vscode with `code`, it will open with Nix Shelll Environment

add a new `"tauri:dev": "tauri:dev"` script

add to cargo.toml

```toml
[profile.dev]
debug = true
```

launch script `npm run tauri:dev`, to build Tauri app for the first Time

### Debugger

- `launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Tauri (GDB)",
      "type": "gdb", 
      "request": "launch",
      // always replace executable filename with correct one, else debugger will not launch, check with `ls -la src-tauri/target/debug/`
      "target": "${workspaceFolder}/src-tauri/target/debug/tauri-20-starter-app",
      "cwd": "${workspaceFolder}",
      "valuesFormatting": "parseText",
      "env": {
        "LIBGL_ALWAYS_SOFTWARE": "1",
        "WEBKIT_DISABLE_COMPOSITING_MODE": "1",
        "TAURI_DEBUG": "1"
      },
      // Remove preLaunchTask - if we want to start `tauri:dev` manually  before launch this config
      // else if we already have launched `npm run tauri:dev` we get a error `Error: Port 1420 is already in use`
      // because bellow "preLaunchTask" task will try to launch frontend again
      "preLaunchTask": "ui:dev"
    },
    {
      "name": "Launch Tauri in Browser",
      "type": "chrome",
      "request": "launch", 
      "url": "http://localhost:1420",
      "webRoot": "${workspaceFolder}/src",
      "linux": {
        "runtimeExecutable": "/nix/store/nbkvpkaljqviparblsi6kx259pn3bchb-user-environment/bin/brave"
      }
    }
  ]
}
```

### Tasks

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "ui:dev",
      "type": "shell",
      "isBackground": true,
      "command": "nix-shell",
      "args": [
        "--run",
        "pnpm dev"
      ],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "problemMatcher": {
        "owner": "typescript",
        "source": "ts",
        "applyTo": "closedDocuments",
        "fileLocation": [
          "relative",
          "${workspaceRoot}"
        ],
        "pattern": {
          "regexp": "^([^\\s].*)\\((\\d+|\\d+,\\d+|\\d+,\\d+,\\d+,\\d+)\\):\\s+(error|warning|info)\\s+(TS\\d+)\\s*:\\s*(.*)$",
          "file": 1,
          "location": 2,
          "severity": 3,
          "code": 4,
          "message": 5
        },
        "background": {
          "activeOnStart": true,
          "beginsPattern": ".*starting.*|.*build.*",
          "endsPattern": ".*Local:.*http://localhost:\\d+.*|.*ready in.*|.*compiled successfully.*|.*Local.*localhost.*"
        }
      }
    },
    {
      "label": "build-debug-tauri",
      "type": "shell",
      "command": "nix-shell",
      "args": [
        "--run",
        "cargo build --manifest-path=./src-tauri/Cargo.toml --no-default-features"
      ],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always"
      },
      "problemMatcher": "$rustc"
    },
    {
      "label": "build-debug-tauri-with-symbols",
      "type": "shell", 
      "command": "nix-shell",
      "args": [
        "--run",
        "cargo build --manifest-path=./src-tauri/Cargo.toml --no-default-features"
      ],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always"
      },
      "problemMatcher": "$rustc",
      "options": {
        "env": {
          "CARGO_PROFILE_DEV_DEBUG": "true"
        }
      }
    },
    {
      "label": "start-frontend-dev",
      "type": "shell",
      "isBackground": true,
      "command": "nix-shell",
      "args": [
        "--run",
        "pnpm dev"
      ],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "problemMatcher": {
        "owner": "typescript",
        "source": "ts",
        "applyTo": "closedDocuments",
        "fileLocation": [
          "relative",
          "${workspaceRoot}"
        ],
        "pattern": {
          "regexp": "^([^\\s].*)\\((\\d+|\\d+,\\d+|\\d+,\\d+,\\d+,\\d+)\\):\\s+(error|warning|info)\\s+(TS\\d+)\\s*:\\s*(.*)$",
          "file": 1,
          "location": 2,
          "severity": 3,
          "code": 4,
          "message": 5
        },
        "background": {
          "activeOnStart": true,
          "beginsPattern": ".*starting.*|.*build.*",
          "endsPattern": ".*Local:.*http://localhost:\\d+.*|.*ready in.*|.*compiled successfully.*|.*Local.*localhost.*"
        }
      }
    },
    {
      "label": "tauri:dev",
      "type": "shell",
      "isBackground": true,
      "command": "nix-shell",
      "args": [
        "--run",
        "TAURI_DEBUG=1 npx tauri dev"
      ],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "problemMatcher": [
        "$rustc",
        {
          "owner": "tauri",
          "source": "tauri",
          "fileLocation": "relative",
          "pattern": {
            "regexp": "^(.*)$",
            "file": 1
          },
          "background": {
            "activeOnStart": true,
            "beginsPattern": ".*Compiling.*|.*Building.*",
            "endsPattern": ".*Finished.*|.*webview window opened.*|.*App listening.*"
          }
        }
      ]
    }
  ]
}
```

## Build Android: WIP

```shell
$ npm run tauri:android:build

   Compiling ident_case v1.0.1
error[E0463]: can't find crate for `std`
  |
  = note: the `aarch64-linux-android` target may not be installed
  = help: consider downloading the target with `rustup target add aarch64-linux-android`

$ rustup target add aarch64-linux-android  
```

### Temp

🧩 1. Use nix-ld to patch dynamic linker support
You can enable a Nix feature called nix-ld to allow loading external dynamic binaries:

Step 1: Enable nix-ld in your system:
In your configuration.nix:

```nix
{
  programs.nix-ld.enable = true;
}
```

Then rebuild your system:

```shell
$ sudo nixos-rebuild switch
```

Step 2: Install glibc compatibility loader:

Install with:

```shell
$ nix-shell -p nix-ld
```

This provides dynamic linker fallback and lets foreign dynamically linked binaries run.




```shell
$ nix-shell --run "npm run tauri android init"
$ nix-shell --run "npm run tauri:android:build"
...
> tauri-20-starter-app@0.1.0 tauri
> tauri android android-studio-script --release --target x86_64

        Info connection; remote_addr=127.0.0.1:58486 conn_id=7
   Compiling tauri-20-starter-app v0.1.0 (/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri)
    Finished `release` profile [optimized] target(s) in 15.90s
        Info symlinking lib "/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/target/x86_64-linux-android/release/libtauri_app_lib.so" in jniLibs dir "/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/gen/android/app/src/main/jniLibs/x86_64"
        Info "/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/target/x86_64-linux-android/release/libtauri_app_lib.so" requires shared lib "libandroid.so"
        Info "/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/target/x86_64-linux-android/release/libtauri_app_lib.so" requires shared lib "libdl.so"
        Info "/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/target/x86_64-linux-android/release/libtauri_app_lib.so" requires shared lib "liblog.so"
        Info "/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/target/x86_64-linux-android/release/libtauri_app_lib.so" requires shared lib "libm.so"
        Info "/home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/target/x86_64-linux-android/release/libtauri_app_lib.so" requires shared lib "libc.so"
    Finished 1 APK at:
        /home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/gen/android/app/build/outputs/apk/universal/release/app-universal-release-unsigned.apk

    Finished 1 AAB at:
        /home/mario/Development/Rust/@Tauri/tauri-app-2.0/src-tauri/gen/android/app/build/outputs/bundle/universalRelease/app-universal-release.aab
```
