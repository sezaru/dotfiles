# Usage

To import a template, run:

``` shell
mkdir .env
cd .env

nix flake init --template "github:sezaru/dotfiles?dir=templates#devenv"
```

Now, edit the file `devenv.nix` to your liking.

Then, if you want to create extra environment variables, you can create the file `.env`. There is a `.env.example` file that can be used as a reference.

Now, you need to create the `.envrc` file in the root project. First go back to the root directory:

``` shell
cd ..
```

Now copy the `.envrc.example` file so we can use it as reference:

``` shell
cp .env/.envrc.example .envrc
```

You probably don't need to edit the `.envrc` file as it should work just fine as-is.

Finally, we can enable the environment by allowing `direnv`:

``` shell
direnv allow
```
