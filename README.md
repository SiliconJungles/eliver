# Eliver

Interactive semantic versioning for Elixir packages.

Eliver is an Elixir clone of [semvergen](https://github.com/brendon9x/semvergen)

Eliver...
* bumps the version in `mix.exs`
* prompts the user for changelog entries and updates `CHANGELOG.md`
* commits these changes

* pushes to origin

**NOTES**

- We have customized this package to work for SiliconJungles's projects.

  - Creates git tags with `staging` or `master` as a prefix.
  - The eliver.bump only works if we're stay at `staging` or `master` branch.
  - The changelog file is renamed to staging_changelog or master_changelog.

## Installation

  1. Add `eliver` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:eliver, github: "SiliconJungles/eliver", branch: "master_2.2.2"}]
end
```

  2. Create a VERSION file with the initial version in the root of the project
  3. In `mix.exs`, read the version from `VERSION`

```elixir
version: String.trim(File.read!("VERSION")),
```

## Usage

```bash
$ mix eliver.bump
```
