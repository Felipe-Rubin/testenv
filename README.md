# testenv
Docker Container tailored for executing simple tasks (e.g., compile code, validate shell script). Some of the pre-installed packages include man pages, network tools, python3, gcc, make, nodejs among others.

**Features**
- Man Pages

**Build**
Optionally also push it to dockerhub.
```sh 
docker build . -t <user>/testenv
```

**Alias**
Add the following to your `~/.bashrc` or `~/.zshrc`
```sh
alias ds='docker run -it --rm -v $PWD/.:/testenv:ro <user>/testenv' 
alias dw='docker run -it --rm -v $PWD/.:/testenv <user>/testenv'
```

**Execute**
```sh
ds # Mount current path as Read Only and open shell
dw # Mount current path as Read Write and open shell
[ds|dw] CMD # Executes a command and exits
```
