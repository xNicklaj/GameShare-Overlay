<a name="readme-top"></a>
<div align="center">
  <a href="https://github.com/xNicklaj/GameShare-Overlay">
    <img src="Icon.ico" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">GameShare Overlay</h3>
  <span align="center">
  </span>
  
  <p align="center">
    GameShare Overlay is a project that allows you to emulate the PS5 GameShare Overlay with Discord, or really any screenshare app.<br/><br/>
    <img src="https://github.com/xNicklaj/GameShare-Overlay/actions/workflows/main.yml/badge.svg" alt="Passing action" /> <img src="https://img.shields.io/github/last-commit/xNicklaj/GameShare-Overlay" alt="Last Commit"/> <img src="https://img.shields.io/github/downloads/xNicklaj/GameShare-Overlay/total" alt="Downloads" /><br/>
    <a href="https://github.com/xNicklaj/GameShare-Overlay/issues">Report Bug</a>
    ·
    <a href="https://github.com/xNicklaj/GameShare-Overlay/issues">Request Feature</a>
  </p>
</div>

<div align="center">

GameShare Overlay | PS5 |
--- | --- 
<img src="https://media0.giphy.com/media/LT3FYsIKghoYG4VUhh/giphy.gif?cid=790b76111abbc74156cebb0eff5db22bddb305eb432b28f8&rid=giphy.gif&ct=g" >|<img src="https://media1.giphy.com/media/B8Mk84qATIEL4bLJtC/giphy.gif?cid=790b761143116a77d40355de5c0bbf59f8b5a131c800dbfc&rid=giphy.gif&ct=g" >
</div>
  
## Getting Started
### Prerequisites

None, if you use the compiled version. The script is written in [Auto Hotkey](https://www.autohotkey.com), but if you use the precompiled version you don't need to download it.

### Installation

1. Head to the [actions](https://github.com/xNicklaj/GameShare-Overlay/actions) tab or [releases](https://github.com/xNicklaj/GameShare-Overlay/releases) tab and click on the most recent build.
2. Scroll down to the artifacts section and download GameShare.zip.
3. Inside the zip you will find GameShare.exe. Extract it in any folder.
4. Execute GameShare.exe and enjoy your game.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage

This script is composed of three sections:
 - Target
 - Enable
 - Configure

For GameShare to be able to handle a ScreenShare window you first need to open it and press `CTRL + ALT + T`. The window will then be considered the "Target" window.
Once the target is selected you can enable the overlay by pressing `CTRL + ALT + S`, and the window should be minimized on your top-right corner.

Finally there are three features available at the moment:
 - Move the corner of the overlay with `CTRL + ALT + Arrows`.
 - Toggle a maximized view by pressing `CTRL + ALT + M`.
 - Increase / decrease the size of the overlay by pressing `SHIFT + ALT + UP/DOWN`, or greatly increase / decrease by pressing `CTRL + SHIFT + ALT + UP/DOWN`.

 ## Configuration

 Upon your first launch of GameShare Overlay, you will find that a configuration file has been created in its containing folder.
 What follows is a list of all the different configuration options:
 
- `General.fAnimationDuration`, this is the duration in ms of the animations. Defaults to `200`.
- `General.fStepSize`, this is the step that will be used when increasing or decreasing the size of the overlayed window. Defaults to `32`.
- `Display.sFormat`, this is the window ratio that will be used for the overlayed window. Defaults to `16:9`. Currently supported `16:9` or `21:9`.
- `Display.fTransparency`, this is the transparency of the minimized window. Defaults to `255`, and its value goes from `0` (fully transparent) to `255` (fully opaque).
- `Display.bUseAnimations`, this is a boolean that represents whether to use animations or not. Defaults to `True`.

Changing configuration requires restarting the application.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Example

This is a usage example with Discord ScreenShare:

 1. Join a Discord Voice Channel*.
 2. Ask a friend to Screenshare his game.
 3. Open the Popout Call Window from the bottom right of the call window.
 4. Start GameShare Overlay and press `CTRL + ALT + T` on the Popout Call.
 5. Go to your game's settings and enable Borderless Window mode.
 6. Press `CTRL + ALT + S` to enable the overlay.

*For some reason this only works with calls in a server. Not sure why yet.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Roadmap

- [x] Setup any window as overlay.
- [x] Move window corner.
- [x] Maximize window.
- [x] Increase / Decrease overlay size.
- [X] Configuration INI
- [ ] Improved Multiple Windows Management
- [ ] More Hotkeys

You can check the full changelog <a href="https://github.com/xNicklaj/GameShare-Overlay/releases/">here</a>.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## FAQ
### Why Autohotkey?
Because it's fast to code. It's not as optimized as a C program would be, but it's fast to code.

### Why does it look so janky?
Because I don't have access to my main computer right now, I'm developing from an old laptop that can barely run 2D games.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the GNU GPLv3 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgements

 - <a href="https://www.flaticon.com/free-icons/screen" title="screen icons">Screen icons created by mpanicon - Flaticon</a>
 - Developed in [Auto Hotkey](https://www.autohotkey.com).
 - [Thumbnail video](https://www.youtube.com/watch?v=Eg0sClmLIBA) taken from the PS5 Youtube channel.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
