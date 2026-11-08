# dotfiles

Stow-managed dotfiles for Arch Linux.

## Layout

Each top-level directory is a GNU Stow package that mirrors `$HOME`:

| Package    | Installs                                      |
| ---------- | --------------------------------------------- |
| `git`      | `~/.gitconfig` (includes `~/.gitconfig.local`) |
| `zsh`      | `~/.zshrc`                                    |
| `bash`     | `~/.bashrc`                                   |
| `starship` | `~/.config/starship.toml`                     |
| `kitty`    | `~/.config/kitty/kitty.conf`                  |
| `niri`     | `~/.config/niri/`                             |

## Fresh machine

The z0x.org installer does this automatically when the `shell` component is
selected and `DOTFILES_REPO` points at this repository:

```sh
DOTFILES_REPO=https://github.com/Tschoepel/dotfiles.git \
  curl -fsSL https://z0x.org/i.sh | bash -s -- --with shell
```

Manual equivalent:

```sh
sudo pacman -S --needed stow git zsh
git clone https://github.com/Tschoepel/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --no-folding -t ~ git zsh bash starship kitty niri
```

If a target already exists, Stow refuses to overwrite it. Back the file up and
retry:

```sh
mv ~/.zshrc ~/.zshrc.bak
cd ~/dotfiles && stow --no-folding -t ~ zsh
```

## Git identity

`~/.gitconfig` is shared and public-safe. Personal identity belongs in
`~/.gitconfig.local`, which is ignored by this repo:

```sh
git config --file ~/.gitconfig.local user.name "Your Name"
git config --file ~/.gitconfig.local user.email "you@example.com"
```

## Secrets

`~/.env` is machine-wide and never committed here. It is installed by the
z0x.org installer (`--only env`) from the `keys.z0x.org` vault as an
age-encrypted `env.age`. `zsh/.zshrc` sources it with `set -a`, so its
variables are exported to interactive shells.

`GIT_NAME` and `GIT_EMAIL` can live there too; the installer copies them into
`~/.gitconfig.local` so a fresh machine gets the right identity automatically.

To back it up again after editing:

```sh
age -p -o env.age ~/.env
npx wrangler r2 object put <bucket>/env.age --file=env.age \
  --content-type=application/octet-stream --cache-control='no-store'
```

## Updating

```sh
cd ~/dotfiles
git pull --ff-only
stow --restow --no-folding -t ~ git zsh bash starship kitty niri
```

## Adding a dotfile

Create the package path under the repo, move the file in, then restow:

```sh
mkdir -p ~/dotfiles/foo/.config/foo
mv ~/.config/foo/foo.conf ~/dotfiles/foo/.config/foo/
cd ~/dotfiles && stow --no-folding --restow -t ~ foo
```
