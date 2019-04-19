# Problem with the binary

For the moment it doesn't work without tinkering on nix because the
binary tresorit is trying to write in its current directory (and nix
store is rw). Currently, there are no options to change this:

_strace tresorit_ :


``` shell
mkdir("/nix/store/0qrdl9f7qpk4vfk3j854vri941jccw1z-tresorit-3.5.698.875/bin/Logs/", 0777) = -1 EROFS (Read-only file system)
```

or

``` shell
openat(AT_FDCWD, "/nix/store/0qrdl9f7qpk4vfk3j854vri941jccw1z-tresorit-3.5.698.875/bin/running.pid", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = -1 EROFS (Read-only file system)
```

# Bypass with "impure" method

``` shell
nix run -f release.nix -c install-impure-tresorit
```

This install tresorit in your $HOME/.local/tresorit (as does the
tresorit installation script)

or

``` shell
nix-env -if release.nix -A impure
```

and you can use 

``` shell
tresorit-impure
# or
tresorit-cli-impure
```
