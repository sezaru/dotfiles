Remove Fedora Silverblue Firefox:

``` shell
rpm-ostree override remove firefox firefox-langpacks
```

Install nix:

``` shell
curl -sL -o nix-installer https://install.determinate.systems/nix/nix-installer-x86_64-linux

chmod +x nix-installer

./nix-installer install ostree
```

Fetch this repo:

``` shell
mkdir ~/projects

git clone https://github.com/sezaru/dotfiles.git projects/dotfiles
```

Link the `home-manager` directory to `.config`:

``` shell
ln -s $HOME/projects/dotfiles/home-manager ~/.config/home-manager
```

Initialize home manager:

``` shell
nix run home-manager/release-24.05 -- --switch
```

Set shell to be managed by home manager: 

``` shell
echo $(which fish) | sudo tee -a /etc/shells

chsh -s $(which fish)
```
