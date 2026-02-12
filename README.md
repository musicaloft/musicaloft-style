# musicaloft-style

This is the standardized Musicaloft code style for consistent formatting and
development practices across all Musicaloft projects.

This repository is open for you to use on your own projects as well!

## Overview

This repository provides reusable Nix flake and devenv modules for

- **Code formatting** with treefmt (Nix, Rust, SCSS, Markdown, TOML, KDL)
- **Git commit hooks** for automatic formatting and commit message validation
- **Consistent development environments** across projects

## Features

### Code formatters

Automatically formats code using treefmt with the following tools:

- **dprint** - SCSS formatting with malva plugin (SMACSS declaration order)
- **mdformat** - Markdown formatting (80-char wrap, GFM, MyST, TOC, wikilinks)
- **nixfmt** - Nix code formatting
- **rustfmt** - Rust code formatting
- **taplo** - TOML formatting
- **kdlfmt** - KDL formatting

### Git hooks

Pre-commit hooks powered by git-hooks-nix:

- **treefmt** - Automatically formats staged files before commit
- **commitlint-rs** - Validates commit messages using conventional commit format

#### Commit message format

```
type(scope): description under 72 characters
```

**Allowed types**:

| Type       | Description                                      |
| ---------- | ------------------------------------------------ |
| `build`    | Changes the build process                        |
| `chore`    | Doesn't affect source code                       |
| `ci`       | Affects CI/CD pipelines                          |
| `docs`     | Affects comments or documentation                |
| `dx`       | Improves or changes developer experience         |
| `feat`     | Adds a new user-facing feature                   |
| `fix`      | Introduces a user-facing bug fix                 |
| `perf`     | Improves performance                             |
| `refactor` | Changes source code without a new feature or fix |
| `revert`   | Reverts a previous commit                        |
| `style`    | Changes how code or documents are formatted      |
| `test`     | Changes or adds automated testing                |

**Rules**:

- Description must be lowercase
- Maximum 72 characters
- Scope maximum 10 characters (warning)

## Usage

### Adding to your project

Add this flake as an input to your `flake.nix`:

```nix
{
  inputs = {
    musicaloft-style.url = "github:musicaloft/musicaloft-style";

    # (optional)
    # musicaloft-style.inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

### Using with devenv

Import the devenv module in your `devenv.nix` or flake configuration:

```nix
{
  imports = [
    inputs.musicaloft-style.devenvModule
  ];
}
```

### Using with flake-parts

Import the flake-parts module:

```nix
{
  imports = [
    inputs.musicaloft-style.flakeModule
  ];
}
```

### Available modules

The flake exports several modules for flexible integration:

- `devenvModules.style` - Complete style module (hooks + formatting)
- `devenvModules.hooks` - Git hooks only
- `devenvModules.fmt` - Treefmt formatters only
- `flakeModules.style` - Flake-parts module

## Development

This project uses its own style configuration ("dogfooding").

### Setup

```bash
# Clone the repository
git clone git@git.musicaloft.com:musicaloft/musicaloft-style.git
cd musicaloft-style

# Allow direnv (automatic environment loading)
direnv allow

# Or manually enter the development shell
nix develop
```

### Formatting

Format all files:

```bash
nix fmt
```

### Project structure

```
musicaloft-style/
├── devenv/
│   └── style/          # devenv module implementations
│       ├── default.nix # Main module entry point
│       ├── hooks.nix   # Git hooks configuration
│       └── treefmt.nix # Treefmt formatters
├── nix/
│   └── style.nix       # Flake-parts module
└── flake.nix           # Main flake definition
```

## Dependencies

This flake uses:

- [flake-parts](https://flake.parts/) - Modular flake framework
- [devenv](https://devenv.sh/) - Development environments
- [git-hooks-nix](https://github.com/cachix/git-hooks.nix) - Git hooks
  integration
- [treefmt-nix](https://github.com/numtide/treefmt-nix) - Code formatting

## License

MIT License - Copyright (c) 2026 Musicaloft LLC

See [LICENSE](LICENSE) for details.
