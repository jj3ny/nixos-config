COMMMON COMMANDS

# Build the system 
Ensure the build works before deploying the configuration, run:
```sh
nix run .#build
```

# Make changes
Alter your system with this command:
```sh
nix run .#build-switch
```
> [!CAUTION]
> `~/.zshrc` will be replaced with the [`zsh` configuration](https://github.com/dustinlyons/nixos-config/blob/main/templates/starter/modules/shared/home-manager.nix#L8) from this repository. Make sure this is what you want.

# Update
```sh
nix flake update
```

# Switch shell

```sh
nix build .#darwinConfigurations.x86_64-darwin.system
 ./result/sw/bin/darwin-rebuild switch --flake .#x86_64-darwin
 
 
 nix build .#darwinConfigurations.aarch64-darwin.system
./result/sw/bin/darwin-rebuild switch --flake .#aarch64-darwin
```

## Installing
## For macOS (November 2024)
This configuration supports both Intel and Apple Silicon Macs.

### 1. Install dependencies
```sh
xcode-select --install
```

### 2. Install Nix
Thank you for the [installer](https://zero-to-nix.com/concepts/nix-installer), [Determinate Systems](https://determinate.systems/)!
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
After installation, open a new terminal session to make the `nix` executable available in your `$PATH`. You'll need this in the steps ahead.

> [!IMPORTANT]
>
> If using [the official installation instructions](https://nixos.org/download) instead, [`flakes`](https://nixos.wiki/wiki/Flakes) and [`nix-command`](https://nixos.wiki/wiki/Nix_command) aren't available by default.
>
> You'll need to enable them.
> 
> **Add this line to your `/etc/nix/nix.conf` file**
> ```
> experimental-features = nix-command flakes
> ```
> 
> **_OR_**
>
> **Specify experimental features when using `nix run` below**
> ```
> nix --extra-experimental-features 'nix-command flakes' run .#<command>
> ```

### 3. Initialize a starter template
*Choose one of two options*

**Simplified version without secrets management**
* Great for beginners, enables you to get started quickly and test out Nix.
* Forgoing secrets just means you must configure apps that depend on keys, passwords, etc., yourself.
* You can always add secrets later.

```sh
mkdir -p nixos-config && cd nixos-config && nix flake --extra-experimental-features 'nix-command flakes' init -t github:dustinlyons/nixos-config#starter
```
**Full version with secrets management**
* Choose this to add more moving parts for a 100% declarative configuration.
* This template offers you a place to keep passwords, private keys, etc. *as part of your configuration*.

```sh
mkdir -p nixos-config && cd nixos-config && nix flake --extra-experimental-features 'nix-command flakes' init -t github:dustinlyons/nixos-config#starter-with-secrets
```

### 4. Make [apps](https://github.com/dustinlyons/nixos-config/tree/main/apps) executable
```sh
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys \) -exec chmod +x {} \;
```

### 5. Apply your current user info
Run this Nix command to replace stub values with your system properties, username, full name, and email.
> Your email is only used in the `git` configuration.
```sh
nix run .#apply
```
> [!NOTE]
> If you're using a git repository, only files in the working tree will be copied to the [Nix Store](https://zero-to-nix.com/concepts/nix-store).
>
> You must run `git add .` first.

### 6. Decide what packages to install
You can search for packages on the [official NixOS website](https://search.nixos.org/packages).

**Review these files**

* [`modules/darwin/casks.nix`](https://github.com/dustinlyons/nixos-config/blob/main/modules/darwin/casks.nix)
* [`modules/darwin/packages.nix`](https://github.com/dustinlyons/nixos-config/blob/main/modules/darwin/packages.nix)
* [`modules/shared/packages.nix`](https://github.com/dustinlyons/nixos-config/blob/main/modules/shared/packages.nix)

### 7. Review your shell configuration
Add anything from your existing `~/.zshrc`, or just review the new configuration.

**Review these files**

* [`modules/darwin/home-manager`](https://github.com/dustinlyons/nixos-config/blob/main/modules/darwin/home-manager.nix)
* [`modules/shared/home-manager`](https://github.com/dustinlyons/nixos-config/blob/main/modules/shared/home-manager.nix)

### 8. Optional: Setup secrets
If you are using the starter with secrets, there are a few additional steps.

#### 8a. Create a private Github repo to hold your secrets
In Github, create a private [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repository with at least one file (like a `README`). You'll enter this name during installation.

#### 8b. Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory. Don't worry, I provide a few commands to help you.

| Key Name            | Platform         | Description                           | 
|---------------------|------------------|-----------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Download secrets from Github. Used only during bootstrap. |
| id_ed25519_agenix   | macOS / NixOS    | Copied over, used to encrypt and decrypt secrets.         |

Run one of these commands:

##### Copy keys from USB drive
This command auto-detects a USB drive connected to the current system.
> Keys must be named `id_ed25519` and `id_ed25519_agenix`.
```sh
nix run .#copy-keys
```

##### Create new keys
```sh
nix run .#create-keys
```
> [!NOTE]
> If you choose this option, make sure to [save the value](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) of `id_ed25519.pub` to Github.
> 
> ```sh
> cat /Users/$USER/.ssh/id_ed25519.pub | pbcopy # Copy key to clipboard
> ```

##### Check existing keys
If you're rolling your own, just check they are installed correctly.
```sh
nix run .#check-keys
```

### 9. Install configuration
Ensure the build works before deploying the configuration, run:
```sh
nix run .#build
```
> [!NOTE]
> If you're using a git repository, only files in the working tree will be copied to the [Nix Store](https://zero-to-nix.com/concepts/nix-store).
>
> You must run `git add .` first.

> [!WARNING]
> You may encounter `error: Unexpected files in /etc, aborting activation` if `nix-darwin` detects it will overwrite
> an existing `/etc/` file. The error will list the files like this:
> 
> ```
> The following files have unrecognized content and would be overwritten:
> 
>   /etc/nix/nix.conf
>   /etc/bashrc
> 
> Please check there is nothing critical in these files, rename them by adding .before-nix-darwin to the end, and then try again.
> ```
> Backup and move the files out of the way and/or edit your Nix configuration before continuing.

### 10. Make changes
Finally, alter your system with this command:
```sh
nix run .#build-switch
```
> [!CAUTION]
> `~/.zshrc` will be replaced with the [`zsh` configuration](https://github.com/dustinlyons/nixos-config/blob/main/templates/starter/modules/shared/home-manager.nix#L8) from this repository. Make sure this is what you want.

## For NixOS
This configuration supports both `x86_64` and `aarch64` platforms.

### 1. Burn and use the latest ISO
Download and burn [the minimal ISO image](https://nixos.org/download.html) to a USB, or create a new VM with the ISO as base. Boot the installer.
> If you're building a VM on an Apple Silicon Mac, choose [64-bit ARM](https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-aarch64-linux.iso).

**Quick Links**

* [64-bit Intel/AMD](https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-x86_64-linux.iso)
* [64-bit ARM](https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-aarch64-linux.iso)

### 2. Optional: Setup secrets
If you are using the starter with secrets, there are a few additional steps.

#### 2a. Create a private Github repo to hold your secrets
In Github, create a private [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repository with at least one file (like a `README`). You'll enter this name during installation.

#### 2b. Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory. Don't worry, I provide a few commands to help you.

| Key Name            | Platform         | Description                           | 
|---------------------|------------------|-----------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Download secrets from Github. Used only during bootstrap. |
| id_ed25519_agenix   | macOS / NixOS    | Copied over, used to encrypt and decrypt secrets.         |

Run one of these commands:

##### Copy keys from USB drive
This command auto-detects a USB drive connected to the current system.
> Keys must be named `id_ed25519` and `id_ed25519_agenix`.
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:dustinlyons/nixos-config#copy-keys
```

##### Create new keys
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:dustinlyons/nixos-config#create-keys
```

##### Check existing keys
If you're rolling your own, just check they are installed correctly.
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:dustinlyons/nixos-config#check-keys
```

### 3. Install configuration
#### Pick your template

> [!IMPORTANT]
> For Nvidia cards, select the second option, `nomodeset`, when booting the installer, or you will see a blank screen.

> [!CAUTION]
> Running this will reformat your drive to the `ext4` filesystem.

**Simple**
* Great for beginners, enables you to get started quickly and test out Nix.
* Forgoing secrets means you must configure apps that depend on keys or passwords yourself.
* You can always add secrets later.
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:dustinlyons/nixos-config#install
```

**With secrets**
* Choose this to add more moving parts for a 100% declarative configuration.
* This template offers you a place to keep passwords, private keys, etc. *as part of your configuration*.
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:dustinlyons/nixos-config#install-with-secrets
```

### 4. Set user password
On first boot at the login screen:
- Use shortcut `Ctrl-Alt-F2` (or `Fn-Ctrl-Option-F2` if on a Mac) to move to a terminal session
- Login as `root` using the password created during installation
- Set the user password with `passwd <user>`
- Go back to the login screen: `Ctrl-Alt-F7`

## How to create secrets
To create a new secret `secret.age`, first [create a `secrets.nix` file](https://github.com/ryantm/agenix#tutorial) at the root of your [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repository. Use this code:

> [!NOTE]
> `secrets.nix` is interpreted by the imperative `agenix` commands to pick the "right" keys for your secrets.
>
> Think of this file as the config file for `agenix`. It's not part of your system configuration.

**secrets.nix**
```nix
let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  users = [ user1 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJDyIr/FSz1cJdcoW69R+NrWzwGK/+3gJpqD1t8L2zE";
  systems = [ system1 ];
in
{
  "secret.age".publicKeys = [ user1 system1 ];
}
```
Values for `user1` should be your public key, or if you prefer to have keys attached to hosts, use the `system1` declaration. 

Now that we've configured `agenix` with our `secrets.nix`, it's time to create our first secret. 

Run the command below. 

```
EDITOR=vim nix run github:ryantm/agenix -- -e secret.age
```

This opens an editor to accept, encrypt, and write your secret to disk. 

The command will look up the public key for `secret.age`, defined in your `secrets.nix`, and check for its private key in `~/.ssh/.`

> To override the SSH path, provide the `-i` flag with a path to your `id_ed25519` key.

Write your secret in the editor, save, and commit the file to your [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repo. 

Now we have two files: `secrets.nix` and our `secret.age`. 

Here's a more step-by-step example:

## Secrets Example
Let's say I wanted to create a new secret to hold my Github SSH key. 

I would `cd` into my [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repo directory, verify the `agenix` configuration (named `secrets.nix`) exists, then run 
```
EDITOR=vim nix run github:ryantm/agenix -- -e github-ssh-key.age
```

This would start a `vim` session.

I would enter insert mode `:i`, copy+paste the key, hit Esc and then type `:w` to save it, resulting in the creation of a new file, `github-ssh-key.age`.

Then, I would edit `secrets.nix` to include a line specifying the public key to use for my new secret. I specify a user key, but I could just as easily specify a host key.

**secrets.nix**
```nix
let
  dustin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  users = [ dustin ];
  systems = [ ];
in
{
  "github-ssh-key.age".publicKeys = [ dustin ];
}
```

Finally, I'd commit all changes to the [`nix-secrets`](https://github.com/dustinlyons/nix-secrets-example) repository, go back to my `nixos-config` and run `nix flake update` to update the lock file.

The secret is now ready to use. Here's an [example](https://github.com/dustinlyons/nixos-config/blob/3b95252bc6facd7f61c6c68ceb1935481cb6b457/nixos/secrets.nix#L28) from my configuration. In the end, this creates a symlink to a decrypted file in the Nix Store that reflects my original file.

## Making changes
With Nix, changes to your system are made by 
- editing your system configuration
- building the [system closure](https://zero-to-nix.com/concepts/closures)
- creating [a new generation](https://nixos.wiki/wiki/Terms_and_Definitions_in_Nix_Project#generation) based on this closure and switching to it

This is all wrapped up in the `build-switch` run command.

### Development workflow
So, in general, the workflow for managing your environment will look like
- make changes to the configuration
- run `nix run .#build-switch`
- watch Nix, `nix-darwin`, `home-manager`, etc do their thing
- go about your way and benefit from a declarative environment
  
### Trying packages
For quickly trying a package without installing it, I usually run
```sh
nix shell nixpkgs#hello
```

where `hello` is the package name from [nixpkgs](https://search.nixos.org/packages).