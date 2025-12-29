# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SevenWondersDice is an iOS application for rolling dice in the 7 Wonders Dice board game. The app simulates rolling multiple colored dice and distributes them across four quadrants with different costs (0-3 coins). This is an unofficial fan-made companion app.

## Build Commands

```bash
# Build for iOS Simulator (generic)
xcodebuild -project SevenWondersDice.xcodeproj -scheme SevenWondersDice -destination 'generic/platform=iOS Simulator' build

# Build for physical device
xcodebuild -project SevenWondersDice.xcodeproj -scheme SevenWondersDice -destination 'generic/platform=iOS' build

# Clean build folder
xcodebuild clean -project SevenWondersDice.xcodeproj -scheme SevenWondersDice
```

## Architecture

### MVVM Pattern
- **Models** (`SevenWondersDice/Models/`): `Die`, `DiceColor`, `Quadrant`
- **ViewModels** (`SevenWondersDice/ViewModels/`): `DiceBoxViewModel` handles all dice state and rolling logic
- **Views** (`SevenWondersDice/Views/`): SwiftUI views for setup, results, and dice display

### State Flow
1. `ContentView` owns the `DiceBoxViewModel` via `@StateObject`
2. `hasRolled` determines whether to show `DiceSetupView` or `DiceResultsView`
3. `activeDice` tracks selected dice; `quadrantDice` stores roll results by quadrant

### Dice Selection Rules
- 4 dice are always active: yellow, green, red, blue
- User must select exactly 3 from 6 selectable dice: gray1, gray2, gray3, black, white, purple
- Total of 7 dice are rolled when valid selection is made

### Responsive Layouts
Both `DiceSetupView` and `DiceResultsView` use `GeometryReader` to detect orientation:
- Portrait: vertical stacked layout
- Landscape: horizontal multi-column layout

## Critical Implementation Details

### Dice Image Mapping
Two separate image mapping systems exist:

1. **Roll Results** (`Die.getImageNumber`): Maps face indices (0-5) to image asset numbers for displaying random roll results. Some faces repeat (e.g., green uses [51, 52, 53, 51, 52, 53]).

2. **Selection UI** (`DiceColor.representativeImageName`): Each die has a single representative face shown in the dice selector:
   - Gray dice show their duplicated face (the face that appears twice)
   - Other dice show their first face
   - All images use `IMG_XXXX` format (e.g., `IMG_0066`)

### Quadrant Layout
Quadrants arranged with costs:
- Top-left: 0 coins (free)
- Top-right: 1 coin
- Bottom-right: 2 coins
- Bottom-left: 3 coins

Each quadrant has a 3x3 grid with one corner reserved (corner closest to center excluded).

### Rolling Animation
`DiceBoxViewModel.rollDice()` performs 7-10 iterations with cubic ease-out timing (80ms to 250ms delays). `isRolling` flag prevents concurrent rolls.

### Dice Selection Visual States
`DiceToggleButton` shows actual dice face images with:
- **Selected**: Full brightness, 1.1x scale, stronger shadow
- **Unselected**: Dark overlay (0.4 opacity), normal scale, lighter shadow

## SwiftUI Patterns

- `@StateObject` for ViewModel ownership in `ContentView`
- Spring animations (response: 0.3, damping: 0.6) for dice selection toggles
- `GeometryReader` for responsive layouts and square grid sizing

## Visual Theme

Ancient parchment theme:
- Background: `Color(red: 0.96, green: 0.95, blue: 0.88)`
- Quadrant backgrounds: green/blue/orange/red at 0.2 opacity
- Serif typography with muted brown colors
- Subtitle displays "Unofficial - by fans, for fans"
