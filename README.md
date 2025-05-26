0;0o0## File structure

- `./modules/global`: contains common modules made to be used by many systems
- `./modules/<hostname>`: contains modules made to be used by specific hosts

## Issues

- missing modules
    - `cpufreq_stats`
- tex
   - fix reverse hyperlinks. [have a look at this](https://tex.stackexchange.com/questions/198969/linking-the-section-titles-to-toc-using-only-hyperref)
- Errors logged in "non-nix/logs" dir

## To do

Learn how to use utilise papirus-icon-theme

## Common setups and fixes

### Luks and tpm2

- Cmd to set partition to unlock at boot:

```
# systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/sdax
```

- When above setup breaks:
  - The corresponding luks keyslot and token become useless and have to be deleted
  - The above cmd has to be executed again

Here's how to cleanup the broken parts:

Extract info on the device to check which token and which key it uses:
```
# cryptsetup luksDump /dev/sdax
```
For the keyslot:
```
# cryptsetup luksKillSlot /dev/sdax <keyslot no>
```
For the token:
```
# cryptsetup token remove --token-id <token no> /dev/sdax
```
