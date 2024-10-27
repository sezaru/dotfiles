# Installation

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

git clone --recursive https://github.com/sezaru/dotfiles.git ~/projects/dotfiles
```

Link the `home-manager` directory to `.config`:

``` shell
ln -s $HOME/projects/dotfiles $HOME/.config/home-manager
```

Initialize home manager:

``` shell
nix run home-manager/release-24.05 -- switch
```

Set shell to be managed by home manager: 

``` shell
echo $(which fish) | sudo tee -a /etc/shells

chsh -s $(which fish)
```

Remove bash files:

``` shell
rm -rf .bash*
```

Install doom

``` shell
doom install
```

# Update

To update the dotfiles, first run:

``` shell
cd $HOME/.config/home-manager

git pull --recurse-submodules
```

If a new submodule was added and you don't have it yet, then you also need to run:

``` shell
git submodule update --init
```

And then:

``` shell
home-manager switch
```
