# setting up kubernetes in local for log monitoring

## Install initial dependencies
For this we have `install.sh` file which we need to run by following below commands

```
chmod +x install.sh
./install.sh <configFileWithPath>
```

> NOTE: for `configFileWithPath` we need to pass name of default shell config file like if we are using `zsh` then config file will be `~/.zshrc`, for `bash` this will be `~/.bashrc` or ~`/.profile`, etc.
> By default it will be `~/.zshrc`.

> Example: `./install ~/.zshrc`