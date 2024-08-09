<div align="center">

# asdf-cargo-shuttle [![Build](https://github.com/sergei-ivanov/asdf-cargo-shuttle/actions/workflows/build.yml/badge.svg)](https://github.com/sergei-ivanov/asdf-cargo-shuttle/actions/workflows/build.yml) [![Lint](https://github.com/sergei-ivanov/asdf-cargo-shuttle/actions/workflows/lint.yml/badge.svg)](https://github.com/sergei-ivanov/asdf-cargo-shuttle/actions/workflows/lint.yml)

[cargo-shuttle](https://docs.shuttle.rs) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add cargo-shuttle
# or
asdf plugin add cargo-shuttle https://github.com/sergei-ivanov/asdf-cargo-shuttle.git
```

cargo-shuttle:

```shell
# Show all installable versions
asdf list-all cargo-shuttle

# Install specific version
asdf install cargo-shuttle latest

# Set a version globally (on your ~/.tool-versions file)
asdf global cargo-shuttle latest

# Now cargo-shuttle commands are available
cargo-shuttle --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/sergei-ivanov/asdf-cargo-shuttle/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Sergey Ivanov](https://github.com/sergei-ivanov/)
