0;0o0## File structure

- `./modules/global`: contains common modules made to be used by many systems
- `./modules/<hostname>`: contains modules made to be used by specific hosts

## Issues

- missing modules
    - `cpufreq_stats`
- tex
   - fix reverse hyperlinks. [have a look at this](https://tex.stackexchange.com/questions/198969/linking-the-section-titles-to-toc-using-only-hyperref)
- Errors logged in "non-nix/logs" dir
- I changed the default location of the `hardware configuration.nix`. But I didn't setup a method for nix to recognise the file as `hardware configuration.nix`.

## To do

- Learn how to use utilise papirus-icon-theme
- nvim doesn't beep when i press esc repeatedly in normal mode

## Common setups and fixes

### Luks and tpm2

- Cmd to set partition to unlock at boot:

```bash
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1px
```

- When above setup breaks:
  - The corresponding luks keyslot and token become useless and have to be deleted
  - The above cmd has to be executed again

Here's how to cleanup the broken parts:

Extract info on the device to check which token and which key it uses:

```bash
sudo cryptsetup luksDump /dev/nvme0n1px
```

For the keyslot:

```bash
sudo cryptsetup luksKillSlot /dev/nvme0n1px <keyslotNo>
```

For the token:

```bash
sudo cryptsetup token remove --token-id <tokenNo> /dev/nvme0n1px
```
