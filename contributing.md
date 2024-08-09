# Contributing

Testing Locally:

```shell
asdf plugin test cargo-shuttle https://github.com/sergei-ivanov/asdf-cargo-shuttle.git "cargo-shuttle --version"
```

If you have a local checkout, you can test your changes (all changes must be committed):

```shell
asdf plugin test cargo-shuttle file://$(pwd) "cargo-shuttle --version"
```

Tests are automatically run in GitHub Actions on push and PR.
