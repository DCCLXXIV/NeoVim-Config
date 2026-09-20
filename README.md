# Neovim configuration

A portable Neovim configuration for C++, Java/Spring Boot, and web development. Plugins, language servers, formatters, Java debug support, and test support are installed automatically by `lazy.nvim` and Mason.

## Install on a new machine

1. Install Neovim 0.10 or newer, `git`, and `ripgrep`.
2. Install a JDK (21 is recommended for current Spring Boot projects). Ensure `java` and `javac` are on `PATH`.
3. Clone this repository as Neovim's configuration directory:

   ```sh
   git clone https://github.com/DCCLXXIV/NeoVim-Config.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
   ```

4. Start `nvim`. The first launch clones `lazy.nvim` and Mason installs the configured tools. Run `:Lazy sync` if an installation was interrupted.

No plugin files, Mason packages, or Java workspaces are committed; they are stored under Neovim's data directory.

## C++ workflow

`clangd` uses a project's `compile_commands.json`, `compile_flags.txt`, or `.clangd` file. Generate `compile_commands.json` for CMake projects with:

```sh
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

Formatting uses the project's `.clang-format` when present. Without one, the personal fallback uses four spaces, Allman-style braces for functions/classes/namespaces/control blocks, same-line braces for enums and structs, and flush-left `public:`/`private:` access specifiers.

## Java and Spring Boot workflow

Opening a Java file in a Maven or Gradle project starts `jdtls` at the project root. It imports Maven/Gradle projects, downloads sources, organizes imports on save, and enables implementation/reference code lenses. Mason also installs `google-java-format`, `java-debug-adapter`, and `java-test`.

Use Maven/Gradle wrappers (`./mvnw`, `./gradlew`) in projects so builds are reproducible on every device. A Spring Boot project needs its configured JDK available on `PATH`; this configuration deliberately does not pin a machine-specific Java installation path.

## Key mappings

| Mapping | Action |
| --- | --- |
| `gd`, `gr`, `K` | Definition, references, documentation |
| `<leader>ca`, `<leader>rn` | Code action, rename |
| `<leader>f` | Format file or selection |
| `[d`, `]d` | Previous/next diagnostic |
| `<leader>xx`, `<leader>xX` | Project/current-buffer diagnostic list |
| `<leader>e` | Toggle file explorer |
