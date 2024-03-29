# Proxy::Scraper

![Made with Perl](https://img.shields.io/badge/made%20with-perl-0.svg?color=cc2020&labelColor=ff3030&style=for-the-badge)

![GitHub](https://img.shields.io/github/license/DeBos99/Proxy-Scraper.svg?color=2020cc&labelColor=5050ff&style=for-the-badge)
![GitHub followers](https://img.shields.io/github/followers/DeBos99.svg?color=2020cc&labelColor=5050ff&style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/DeBos99/Proxy-Scraper.svg?color=2020cc&labelColor=5050ff&style=for-the-badge)
![GitHub stars](https://img.shields.io/github/stars/DeBos99/Proxy-Scraper.svg?color=2020cc&labelColor=5050ff&style=for-the-badge)
![GitHub watchers](https://img.shields.io/github/watchers/DeBos99/Proxy-Scraper.svg?color=2020cc&labelColor=5050ff&style=for-the-badge)
![GitHub contributors](https://img.shields.io/github/contributors/DeBos99/Proxy-Scraper.svg?color=2020cc&labelColor=5050ff&style=for-the-badge)

![GitHub commit activity](https://img.shields.io/github/commit-activity/w/DeBos99/Proxy-Scraper.svg?color=ffaa00&labelColor=ffaa30&style=for-the-badge)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/DeBos99/Proxy-Scraper.svg?color=ffaa00&labelColor=ffaa30&style=for-the-badge)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/DeBos99/Proxy-Scraper.svg?color=ffaa00&labelColor=ffaa30&style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/DeBos99/Proxy-Scraper.svg?color=ffaa00&labelColor=ffaa30&style=for-the-badge)

![GitHub issues](https://img.shields.io/github/issues-raw/DeBos99/Proxy-Scraper.svg?color=cc2020&labelColor=ff3030&style=for-the-badge)
![GitHub closed issues](https://img.shields.io/github/issues-closed-raw/DeBos99/Proxy-Scraper.svg?color=10aa10&labelColor=30ff30&style=for-the-badge)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=NH8JV53DSVDMY)

**Proxy::Scraper** is simple Perl script for scraping proxies from multiple websites.

## Content

- [Content](#content)
- [Installation](#installation)
  - [Windows](#windows)
  - [Unix](#unix)
    - [Debian/Ubuntu](#apt)
    - [Arch Linux/Manjaro](#pacman)
    - [CentOS](#yum)
    - [MacOS](#homebrew)
- [Usage](#usage)
- [Documentation](#documentation)
  - [Required arguments](#required-arguments)
  - [Optional arguments](#optional-arguments)
- [Authors](#authors)
- [Contact](#contact)
- [License](#license)

## Installation

### Windows

* Install [Git](https://git-scm.com/download/win).
* Install [Perl](http://strawberryperl.com/).
* Run following command in the command prompt:
```
cpan -i Proxy::Scraper
```

### Unix

#### <a name="APT">Debian/Ubuntu based

* Run following commands in the terminal:
```
sudo apt install git perl -y
cpan -i Proxy::Scraper
```

#### <a name="Pacman">Arch Linux/Manjaro

* Run following commands in the terminal:
```
sudo pacman -S git perl --noconfirm
cpan -i Proxy::Scraper
```

#### <a name="YUM">CentOS

* Run following commands in the terminal:
```
sudo yum install git perl -y
cpan -i Proxy::Scraper
```

#### <a name="Homebrew">MacOS

* Run following commands in the terminal:
```
brew install git perl
cpan -i Proxy::Scraper
```

## Usage

`proxy-scraper ARGUMENTS`

## Documentation

### Required arguments

| Argument                              | Description         |
| :------------------------------------ | :------------------ |
| -t, --type {http,https,socks4,socks5} | Sets type of proxy. |

### Optional arguments

| Argument                                  | Description                    | Default value |
| :---------------------------------------- | :----------------------------- | :------------ |
| -h, --help                                | Shows help message and exits.  |               |
| -v, --version                             | Shows version and exits.       |               |
| -d, --debug                               | Enables debug mode.            | false         |
| -l, --level {transparent,anonymous,elite} | Sets level of proxy anonymity. | any           |
| -o, --output PATH                         | Sets output filename.          | proxies.txt   |

## Authors

* **Michał Wróblewski** - Main Developer - [DeBos99](https://github.com/DeBos99)

## Contact

* Discord: DeBos#3292
* Reddit: [DeBos99](https://www.reddit.com/user/DeBos99)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
