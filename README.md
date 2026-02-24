<center>
    <picture>
    <source
        width="50%"
        srcset="./docs/media/AnySynx.png"
        media="(prefers-color-scheme: dark)"
    />
    <source
        width="50%"
        srcset="./docs/media/AnySynx.png"
        media="(prefers-color-scheme: light), (prefers-color-scheme: no-preference)"
    />
    <img width="150" src="./docs/media/AnySynx.png" />
    </picture>
</center>

<h1 align="center">AnySynx ( WIP )</h1>

<p align="center">This application was built to provide fast and efficient access to download content from various platforms without the obstacles of advertising or subscription fees. ( Hasil vibe coder jir 😂 )</p>

<p align="center">
  [<a href="https://github.com/SyntxFlow/AnySynx/releases">Try it</a>]
</p>

<p align="center">
  <a href="https://github.com/moeru-ai/airi/blob/main/LICENSE"><img src="https://img.shields.io/github/license/moeru-ai/airi.svg?style=flat&colorA=080f12&colorB=1fa669"></a>
  <a href="https://discord.gg/fUusrraZ"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fdiscord.com%2Fapi%2Finvites%2FfUusrraZ%3Fwith_counts%3Dtrue&query=%24.approximate_member_count&suffix=%20members&logo=discord&logoColor=white&label=%20&color=7389D8&labelColor=6A7EC2"></a>
  <a href="https://github.com/SyntxFlow"><img src="https://img.shields.io/badge/%40SyntxFlow-black?style=flat&logo=github&labelColor=%23101419&color=%232d2e30"></a>
</p>

> [!NOTE]
> This application is currently under active **development**. At the moment, only the user interface (UI) is available as an early preview of the design and overall user experience.
> 
> Core features and functionalities have not been implemented yet and will be added gradually in future **updates**. Feedback, suggestions, and ideas are highly appreciated to help improve and shape this application moving forward.
>
> Thank you for your support and patience

## Preview

<div style="display: flex; flex-wrap: wrap; gap: 16px;">
  <img src="./docs/media/preview/tiktok.jpg" width="260" />
  <img src="./docs/media/preview/instagram.jpg" width="260" />
  <img src="./docs/media/preview/youtube.jpg" width="260" />
  <img src="./docs/media/preview/x.jpg" width="260" />
</div>

## Current Progress

- [ ] UI 
  - [x] Tiktok
  - [ ] Youtube
  - [ ] X
  - [ ] Instagram

## Development

```shell
cd App
flutter pub get
```

### Start dev

```shell
flutter run
```

### Build APK ( Split per abi )

```shell
flutter build apk --release --split-per-abi
```

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=SyntxFlow/AnySynx&type=Date)](https://www.star-history.com/#SyntxFlow/AnySynx&Date)