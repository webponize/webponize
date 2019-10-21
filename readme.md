# [WebPonize](https://webponize.org) 

> macOS app which converts images to [WebP](https://developers.google.com/speed/webp/).

[Vote on Product Hunt](https://www.producthunt.com/posts/webponize).

![""](webponize.jpg)

## Install

### Archive file

Download the newest from [releases page](https://github.com/webponize/webponize/releases) and unzip it, and move it to /Applications folder.

### Homebrew Cask

```bash
$ brew cask install webponize
```

## Usage

Just drag and drop image files into app.

## Build

```
carthage update  --use-submodules --use-ssh --no-use-binaries  --platform Mac
```

open Xcode and run the project.
