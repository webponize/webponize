<div align="center">
  <img src="asset/webponize-512.png" width="200" height="200">
  <h1>WebPonize</h1>
  <p>macOS application that converts images to <a href="https://developers.google.com/speed/webp/">WebP</a></p>
</div>

## Install

[![](https://linkmaker.itunes.apple.com/assets/shared/badges/en-us/macappstore-lrg.svg)](https://apps.apple.com/us/app/id1526039365?mt=12)

## Usage

To convert, either:

- Drag and drop the images onto the application window or the Dock icon.
- Use "Open" in the "File" menu to choose the images to convert.
- Right-click the images in Finder and select WebPonize from the "Open With" menu.

## Product Hunt

[![WebPonize - macOS application that converts images to WebP. | Product Hunt Embed](https://api.producthunt.com/widgets/embed-image/v1/featured.svg?post_id=23523&theme=light)](https://www.producthunt.com/posts/webponize?utm_source=badge-featured&utm_medium=badge&utm_souce=badge-webponize)

## Press

- [WebPonize for Mac converts images to Google's WebP](https://thenextweb.com/apps/2015/06/09/webponize-for-mac-automatically-converts-images-into-googles-webp-format/)
- [CSS-Tricks 「WebP is pretty great for serving high quality images better than (pretty much any?) other format right now. But working with them locally isn't great. Not much can open them or create them. If you need to hand-create them, this is a handy little mac app: https://t.co/dY5dY4z9a7 https://t.co/pzMhF3WeMl」 / Twitter](https://twitter.com/css/status/1185333996831543299)

## Build

```sh
carthage update --use-submodules --use-ssh --no-use-binaries --platform Mac
```

open Xcode and run the project.
