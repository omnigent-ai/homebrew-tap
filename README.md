# Omnigent Homebrew Tap

Homebrew formulae for [Omnigents](https://github.com/omnigent-ai/omnigent).

## Formulae

### omnigents

Installs the [Omnigents](https://github.com/Omnigents/omnigents) CLI
(`omnigents` and its `omni` alias) into a self-contained virtualenv built
with Homebrew's Python, plus shell completions for bash, zsh, and fish.
No `uv` or pre-existing Python setup required.

The upstream repository has no tagged releases yet, so the formula is
HEAD-only and builds from the latest `main`:

```sh
brew install --HEAD omnigent-ai/tap/omnigents
```

To pick up new upstream commits later:

```sh
brew upgrade --fetch-HEAD omnigents
```

Cloning the private source repository uses your existing git credentials
(`gh auth setup-git` configures them if needed).

#### Building behind a registry mirror

The build downloads Python packages from PyPI and (for the bundled web UI)
npm packages from the npm registry. Homebrew builds run with a scrubbed
`HOME`, so `~/.pip/pip.conf` and `~/.npmrc` are not visible to them. If
your network requires registry mirrors, export them before installing:

```sh
export HOMEBREW_PIP_INDEX_URL=https://<your-pypi-mirror>/simple
export HOMEBREW_NPM_REGISTRY=https://<your-npm-mirror>/
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
