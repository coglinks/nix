## Error

### Using the commit 7db33bcd "hyprtasking config"

The following error was observed despite following the instruction provided by both the official hyprland docs and hyprtasking docs (which held more priority)

```
$ sudo nixos-rebuild switch --flake /st/nix#loq --upgrade

building the system configuration...
error: builder for '/nix/store/3j5h2vmh805pz9678a1b3bsynqyg4b6q-aquamarine-0.5.1+date=2024-12-16_8e77618.drv' failed with exit code 1;
       last 25 log lines:
       > -- Detecting C compiler ABI info
       > -- Detecting C compiler ABI info - done
       > -- Check for working C compiler: /nix/store/wn1cys4zrd3cgwilnrr2ilq27xi8jvzc-gcc-wrapper-13.3.0/bin/gcc - skipped
       > -- Detecting C compile features
       > -- Detecting C compile features - done
       > -- Detecting CXX compiler ABI info
       > -- Detecting CXX compiler ABI info - done
       > -- Check for working CXX compiler: /nix/store/wn1cys4zrd3cgwilnrr2ilq27xi8jvzc-gcc-wrapper-13.3.0/bin/g++ - skipped
       > -- Detecting CXX compile features
       > -- Detecting CXX compile features - done
       > -- Found PkgConfig: /nix/store/bbp56ai8w43xkfisar83h37imjdlcx6r-pkg-config-wrapper-0.29.2/bin/pkg-config (found version "0.29.2")
       > -- Found OpenGL: /nix/store/sq50878z0rdxwdyjw3fvbgf6wkpcnpcp-libglvnd-1.7.0/lib/libOpenGL.so  found components: GLES2
       > -- Checking for modules 'libseat>=0.8.0;libinput>=1.26.0;wayland-client;wayland-protocols;hyprutils>=0.2.3;pixman-1;libdrm;gbm;libudev;libdisplay-info;hwdata'
       > --   No package 'gbm' found
       > CMake Error at /nix/store/ad4c8nx2lkjs4zq0sj9jdpn7w45v9ccs-cmake-3.31.6/share/cmake-3.31/Modules/FindPkgConfig.cmake:645 (message):
       >   The following required packages were not found:
       >
       >    - gbm
       >
       > Call Stack (most recent call first):
       >   /nix/store/ad4c8nx2lkjs4zq0sj9jdpn7w45v9ccs-cmake-3.31.6/share/cmake-3.31/Modules/FindPkgConfig.cmake:873 (_pkg_check_modules_internal)
       >   CMakeLists.txt:24 (pkg_check_modules)
       >
       > 
       > -- Configuring incomplete, errors occurred!
       For full logs, run:
         nix log /nix/store/3j5h2vmh805pz9678a1b3bsynqyg4b6q-aquamarine-0.5.1+date=2024-12-16_8e77618.drv
error: 1 dependencies of derivation '/nix/store/jjk7h1j5977in6id3sd48565i86vpnm6-hyprtasking-0.1.drv' failed to build
error: 1 dependencies of derivation '/nix/store/z104ivwrqsyz6kwj301sawaj75pcwyzf-hm_hyprhyprland.conf.drv' failed to build
error: 1 dependencies of derivation '/nix/store/fw5a11pdkvhn3ij0dgv5ihlkp0x8xjbi-home-manager-files.drv' failed to build
error: 1 dependencies of derivation '/nix/store/hrvcg7xqw2qpaqp0rvwg195fndkcskra-home-manager-generation.drv' failed to build
error: 1 dependencies of derivation '/nix/store/iwd8kjdg09nv0cy6xak5kfzac6cs3h52-unit-home-manager-incogshift.service.drv' failed to build
error: 1 dependencies of derivation '/nix/store/5hjyjj71593619dprq2bd0g1bsdx8v92-system-units.drv' failed to build
error: 1 dependencies of derivation '/nix/store/0ijjlmdjp0w8xma21ypsmdbmr0hrj8wr-etc.drv' failed to build
error: 1 dependencies of derivation '/nix/store/zi699z5qw2yjmljlv8iy2z6l2aq25j5s-nixos-system-nixos-25.05.20250429.46e634b.drv' failed to build
```

## File structure

- `./modules/global`: contains common modules made to be used by many systems
- `./modules/<hostname>`: contains modules made to be used by specific hosts

## Issues

- hibernate
- hyprland plugins
- missing modules
    - `cpufreq_stats`
- tex
   - fix reverse hyperlinks. [have a look at this](https://tex.stackexchange.com/questions/198969/linking-the-section-titles-to-toc-using-only-hyperref)
- Errors logged in "non-nix/logs" dir

## To do

Learn how to use utilise papirus-icon-theme
