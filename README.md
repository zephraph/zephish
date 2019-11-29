<img src="https://user-images.githubusercontent.com/3087225/69847296-b4494c00-1244-11ea-969c-fce5bed4d253.png" align="left" />

# Zephish

> [Zephraph](https://github.com/zephraph)'s dotfiles, but as a plugin for [Oh My Fish][omf-link].

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)
<br/><sup>_Works best on OSX_</sup>

---

## What it does

- Silences the fish welcome command
- Installs [brew](https://brew.sh/) if it isn't present
- Installs [exa](https://github.com/ogham/exa) and aliases it to `ls`
- Installs [bat](https://github.com/sharkdp/bat) and aliases it to `cat`
- Adds omf plugin [bang-bang](https://github.com/oh-my-fish/plugin-bang-bang) so `!! sudo` will rerun the last command with sudo
- Adds omf plugins [git](https://github.com/jhillyerd/plugin-git), [yarn](https://github.com/zephraph/yarn), and [nvm]() for helpful abbreviations and completions
- Adds omf plugin [technicolor](https://github.com/oh-my-fish/plugin-technicolor) for easy CLI coloring
- Adds `./node_modules/.bin` to your path so you can run local node programs without having to prefix it with `yarn`
- Uses [starship](https://github.com/starship/starship) if it's installed

## Install

```fish
$ omf install https://github.com/zephraph/zephish
```

## Uninstall

```fish
omf uninstall zephish
```

# License

[MIT][mit] © [Zephraph][author] et [al][contributors]

[mit]: https://opensource.org/licenses/MIT
[author]: https://github.com/zephraph
[contributors]: https://github.com/zephraph/zephish/graphs/contributors
[omf-link]: https://www.github.com/oh-my-fish/oh-my-fish
[license-badge]: https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
