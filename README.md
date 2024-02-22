# vide

Tool to probe and crawl targets and enumerate their attack surface using varous engines. 
Inputs can be:
* `.xml` files generated by `nmap`
   - `vide.sh nmap -sc -sp -eu -ew`
* a list of targets
    - `vide.sh scope.txt -sp -sc -ev`
* stdin
    - `echo example.com | vide.sh -sp -es --config custom.sh`

```
      _______________
  ==c(___(o(______(_()
          \=\
           )=\    ┌─────────────────────────~vide~────┐
          //|\\   │ attack surface enumeration        │
         //|| \\  │ version: 2.2                      │
        // ||. \\ └─────────────────@dreizehnutters───┘
      .//  ||   \\ .
      //  .      \\ 
```
This is yet another ctf/engagement automation tool, born out of curiosity and boredom. This tool was inspired by [six2dez/reconftw](https://github.com/six2dez/reconftw).

---

## Usage

```txt
Usage: vide.sh input [mods] [options] [misc]

Required:
    input   Specify an input format (e.g., file/path, string or stdin)

Mods:
    -sp     Skip probing with httpx
    -sc     Skip crawling with katana

Options:
    -es     Enable screenshot
    -ew     Enable whatweb scans
    -ea     Enable wanalyze scans
    -en     Enable nmap script scans
    -eu     Enable nuclei scans
    -ei     Enable nikto scans
    -ef     Enable ffuf brute forcing
    -ev     Enable virtual host header fuzzing
    -ej     Enable js crawl
    -eb     Enable bypass scans
    --all   Enable all modules

Misc:
    -h|--help                  Show this message
    -c|--config  <config.sh>   Config file to pass (default: custom.sh)
    -o|--out-dir <path>        Out-dir to work in (default: $PWD)
    --verify                   Check configuration file (default: config.sh)

Example:
    # skip crawl, skip probing, do virtual host header scan on a list of targets
    vide.sh scope.txt -sp -sc -ev
    # skip crawl, do nuclei, do whatweb on nmap output directory
    vide.sh nmap -sc -eu -ew
    # with config skip probing, do screenshot on stdin (default to HTTP)
    echo example.com | vide.sh -sp -es --config custom.sh
    # verify current config.sh
    vide.sh --verify
```

## Example

[![CLI
demo](https://asciinema.org/a/JiafnV3IX0pn2nShFv7Uqs0Gc.svg)](https://asciinema.org/a/JiafnV3IX0pn2nShFv7Uqs0Gc?autoplay=1)


```bash
# skip crawling, do httpX screenshots and WhatWeb scans on nmap -oX data
$ vide.sh nmap -sc -es -ew
[...]

$ tree .
├── nmap
│   └── init.xml
└── vide_runs
    └── vide_22.02_23301708641003
        ├── host_port.txt
        ├── http_servers.txt
        ├── https_servers.txt
        ├── httpx
        │   └── scan.log
        ├── screenshots
        │   ├── response
        │   │   ├── 192.168.42.131
        │   │   │   └── 628362c5635403dbffbf03eb624e464b50915bc4.txt
        │   │   └── index.txt
        │   └── screenshot
        │       ├── 192.168.42.131
        │       │   └── 628362c5635403dbffbf03eb624e464b50915bc4.png
        │       ├── index_screenshot.txt
        │       └── screenshot.html
        ├── vide.log
        ├── vide_targets.txt
        └── whatweb
            ├── brief_all.log
            ├── brief.log
            ├── deep_all.log
            └── deep.log
```

---

## Installation

The installtion and maintance of used modules by `vide.sh` is left to the user

```bash
$ git clone https://github.com/dreizehnutters/vide
$ cd vide
$ ln -s $(pwd)/vide.sh ~/.local/bin/vide.sh
$ vide.sh --verify
```

---

## Configuration 

One has to edit the `config.sh` to adjust the location of used binaries and configure extra parameter about each engine

```bash
cat config.sh| head -n15
# ---= bins =--- #CHANGE ME
NMAP=/usr/bin/nmap
XMLS=/usr/bin/xmlstarlet
NIKTO=/usr/bin/nikto
WW=/usr/bin/whatweb
WA=/usr/local/bin/webanalyze
SMBMAP=/usr/bin/smbmap
ENUM4LINUX=$PY_PATH/enum4linux-ng.py
FFUF=$GO_PATH/bin/ffuf
BYP4=$GO_PATH/bin/byp4xx
SUBJS=$GO_PATH/bin/subjs
HTTPX=$HOME/.pdtm/go/bin/httpx
NUCLEI=$HOME/.pdtm/go/bin/nuclei
KATANA=$HOME/.pdtm/go/bin/katana
```

```bash
# check the current configuration
$ vide.sh --verify
```

---

## Features
- `xmlstarlet` >= `1.6.1` [used for XML parsing](https://xmlstar.sourceforge.net)
- `httpx` >= `1.2.5` 	[used for server probing](https://github.com/projectdiscovery/httpx)
- `katana` >= `1.0.0`   [used for crwaling](https://github.com/projectdiscovery/katana)
- `whatweb` >= `0.5.5`	[used for tech discovery ](https://github.com/urbanadventurer/WhatWeb)
- `webanalyze` >= `0.3.8`	[used for tech discovery](https://github.com/rverton/webanalyze)
- `nuclei` >= `2.8.9` 	[used for web server scanning](https://github.com/projectdiscovery/nuclei)
- `nikto` >= `2.5.0` 	[used for web server scanning](https://github.com/sullo/nikto)
- `ffuf` >= `2.0.0` 	[used for directory brute forcing](https://github.com/ffuf/ffuf)
- `byp4xx` >= `b337580` [used for bypass checks](https://github.com/lobuhi/byp4xx)
- `subjs` >= `1.0.0`    [used for crawling js](https://github.com/lc/subjs)
- `enum4linux-ng.py` >= `1.3.1`    [used for windows enumeration  ](https://github.com/cddmp/enum4linux-ng)
- `smbmap` >= `1.9.1`    [used for smb enumeration](https://github.com/ShawnDEvans/smbmap)
- `nmap` >= `7.94`    [used for extended script scans](https://github.com/nmap/nmap)
