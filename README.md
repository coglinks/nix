## Error

### Using commit b1cca439 "hyprexpo config"

It took a lot of tries as I kept recieving a `gbm` missing dependency error, but mysteriously at some point the system was built.

But then the following error was observed. Restarting did not autoload the plugin

```
$ hyprctl plugin load /nix/store/vjvsrgyfvypj1q9cncb976z5ayrk1bi6-hyprexpo-0.1/lib/libhyprexpo.so

error in loading plugin, last error: Plugin /nix/store/vjvsrgyfvypj1q9cncb976z5ayrk1bi6-hyprexpo-0.1/lib/libhyprexpo.so could not be loaded: /nix/store/vjvsrgyfvypj1q9cncb976z5ayrk1bi6-hyprexpo-0.1/lib/libhyprexpo.so: undefined symbol: _ZN4Time9steadyNowEv
```

## File structure

- `./modules/global`: contains common modules made to be used by many systems
- `./modules/<hostname>`: contains modules made to be used by specific hosts