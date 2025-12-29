# Seven Wonders Dice

An iOS companion app for the 7 Wonders Dice board game. This unofficial fan-made app simulates rolling the game's colored dice and distributes them across four quadrants with different coin costs (0-3).

**Unofficial - by fans, for fans**

## Features

- Roll 7 dice simultaneously with animated results
- Dice automatically distributed across four cost quadrants
- Select 3 additional dice from gray, black, white, and purple options
- Support for both portrait and landscape orientations

## Requirements

- iOS 15.0+
- Xcode 14.0+

## Building

```bash
# Build for iOS Simulator
xcodebuild -project SevenWondersDice.xcodeproj -scheme SevenWondersDice -destination 'generic/platform=iOS Simulator' build

# Build for physical device
xcodebuild -project SevenWondersDice.xcodeproj -scheme SevenWondersDice -destination 'generic/platform=iOS' build
```

## Important Notice Regarding Dice Images

The dice face images included in this application are photographs of physical Seven Wonders Dice game components. These images may be protected by copyrights held by their respective owners (Repos Production, Asmodee, and/or affiliated parties).

**Distribution of this application, in whole or in part, is strictly limited to individuals who have received direct written approval from the Seven Wonders Dice copyright owners.**

If you have not received such approval, you may not distribute this application or its assets.

## License

This project's source code is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

**Note:** The MIT License applies only to the source code. The dice images are subject to separate copyright restrictions as described above.

## Disclaimer

This is an unofficial fan project and is not affiliated with, endorsed by, or connected to Repos Production, Asmodee, or any official Seven Wonders brand. Seven Wonders is a trademark of Repos Production.
