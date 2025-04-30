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

### Using the commit 379268b7 "hyprtasking config with latest hyprland source"

```
$ sudo nixos-rebuild switch --flake /st/nix#loq --upgrade

building the system configuration...
error: builder for '/nix/store/x19ind7mhvyf0lp9mjvvzw5csd7jh5w1-hyprtasking-0.1.drv' failed with exit code 1;
       last 25 log lines:
       > ../src/layout/linear.cpp:349:13: error: 'class CWorkspace' has no member named 'm_bVisible'; did you mean 'm_visible'?
       >   349 |     big_ws->m_bVisible = false;
       >       |             ^~~~~~~~~~
       >       |             m_visible
       > ../src/layout/linear.cpp:394:24: error: 'class CWorkspace' has no member named 'm_bVisible'; did you mean 'm_visible'?
       >   394 |             workspace->m_bVisible = true;
       >       |                        ^~~~~~~~~~
       >       |                        m_visible
       > ../src/layout/linear.cpp:405:24: error: 'class CWorkspace' has no member named 'm_bVisible'; did you mean 'm_visible'?
       >   405 |             workspace->m_bVisible = false;
       >       |                        ^~~~~~~~~~
       >       |                        m_visible
       > ../src/layout/linear.cpp:420:22: error: 'class CWorkspace' has no member named 'm_bVisible'; did you mean 'm_visible'?
       >   420 |     start_workspace->m_bVisible = true;
       >       |                      ^~~~~~~~~~
       >       |                      m_visible
       > [9/10] Compiling C++ object libhyprtasking.so.p/src_main.cpp.o
       > FAILED: libhyprtasking.so.p/src_main.cpp.o
       > g++ -Ilibhyprtasking.so.p -I. -I.. -I/nix/store/76khkhc5gwxihxy15y2i9bf0dnmlma6j-pixman-0.44.2/include/pixman-1 -I/nix/store/pyqfp2c9kd4axg5y3rs46plb559j9ff2-libdrm-2.4.124-dev/include -I/nix/store/pyqfp2c9kd4axg5y3rs46plb559j9ff2-libdrm-2.4.124-dev/include/libdrm -I/nix/store/8r8dhwxhpz5g7y7hc62ha7v3wgxmgjnf-cairo-1.18.2-dev/include/cairo -I/nix/store/71wylr6y7386imqjch2pr1p8d5ipr0hf-freetype-2.13.3-dev/include/freetype2 -I/nix/store/71wylr6y7386imqjch2pr1p8d5ipr0hf-freetype-2.13.3-dev/include -I/nix/store/gdq1i8iwvxjznbfnmg83lg5sgy35qp8i-glib-2.82.5-dev/include -I/nix/store/gdq1i8iwvxjznbfnmg83lg5sgy35qp8i-glib-2.82.5-dev/include/glib-2.0 -I/nix/store/yxyncg0y2b39kjgi4c52w74c4w1za7pg-glib-2.82.5/lib/glib-2.0/include -I/nix/store/8s41s33dgy5iy4a6ylfv600id9ff2ay9-pango-1.56.2-dev/include/pango-1.0 -I/nix/store/xf741shka5arzz4827rxzxwkqshllc6v-harfbuzz-10.2.0-dev/include/harfbuzz -I/nix/store/ma47ac312qyghc2k5xjk8qm5hl38dc34-libinput-1.27.1-dev/include -I/nix/store/2pf230zdrc6ig5pabs9rknby7jfjxvym-systemd-minimal-libs-257.3-dev/include -I/nix/store/1gp36aay74yndg9a4rcvhg0wwgirc45z-wayland-1.23.1-dev/include -I/nix/store/zldzwf43whjgc9hsq0m55lpsnxjgbg7x-libxkbcommon-1.8.1-dev/include -I/nix/store/qn3cw0925d5g6lrzl6m37hgzzzhysb19-hyprland-0.48.0+date=2025-04-30_2ee5118-dev/include -I/nix/store/qn3cw0925d5g6lrzl6m37hgzzzhysb19-hyprland-0.48.0+date=2025-04-30_2ee5118-dev/include/hyprland/protocols -I/nix/store/qn3cw0925d5g6lrzl6m37hgzzzhysb19-hyprland-0.48.0+date=2025-04-30_2ee5118-dev/include/hyprland -fdiagnostics-color=always -D_GLIBCXX_ASSERTIONS=1 -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wno-narrowing -shared -fPIC --no-gnu-unique -std=c++23 -fPIC -MD -MQ libhyprtasking.so.p/src_main.cpp.o -MF libhyprtasking.so.p/src_main.cpp.o.d -o libhyprtasking.so.p/src_main.cpp.o -c ../src/main.cpp
       > ../src/main.cpp: In function 'void register_monitors()':
       > ../src/main.cpp:179:53: error: 'class CCompositor' has no member named 'm_vMonitors'; did you mean 'm_monitors'?
       >   179 |     for (const PHLMONITOR& monitor : g_pCompositor->m_vMonitors) {
       >       |                                                     ^~~~~~~~~~~
       >       |                                                     m_monitors
       > ninja: build stopped: subcommand failed.
       For full logs, run:
         nix log /nix/store/x19ind7mhvyf0lp9mjvvzw5csd7jh5w1-hyprtasking-0.1.drv
error: 1 dependencies of derivation '/nix/store/0gn07q728584cgr5c2k6bbzvgm8d410x-hm_hyprhyprland.conf.drv' failed to build
error: 1 dependencies of derivation '/nix/store/h5ap0gxrl7fcz0wq24raz221cvzc65ly-home-manager-files.drv' failed to build
error: 1 dependencies of derivation '/nix/store/zr7lc90jqr4d2ghk41dvsz5vq0s2jv2n-home-manager-generation.drv' failed to build
error: 1 dependencies of derivation '/nix/store/l272nfck359wgwr8izy0cs80rqbrdz8j-unit-home-manager-incogshift.service.drv' failed to build
error: 1 dependencies of derivation '/nix/store/addnw24jzqrgm8n2afwhimz4srchbiyw-system-units.drv' failed to build
error: 1 dependencies of derivation '/nix/store/ffi12xp77fq3w76y7q5mp8syqywb9651-etc.drv' failed to build
error: 1 dependencies of derivation '/nix/store/96288qyj4l2p6w3c0jhy4dmhjfixv2iq-nixos-system-nixos-25.05.20250429.46e634b.drv' failed to build
```

## File structure

- `./modules/global`: contains common modules made to be used by many systems
- `./modules/<hostname>`: contains modules made to be used by specific hosts