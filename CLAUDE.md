# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SevenWondersDice is an iOS application for rolling dice in the 7 Wonders Dice board game. The app simulates rolling multiple colored dice and distributes them across four quadrants with different costs (0-3 coins). It supports shake-to-roll using device motion detection.

## Build Commands

```bash
# Build the project
xcodebuild -project SevenWondersDice.xcodeproj -scheme SevenWondersDice -destination 'platform=iOS Simulator,name=iPhone 15' build

# Build for physical device
xcodebuild -project SevenWondersDice.xcodeproj -scheme SevenWondersDice -destination 'generic/platform=iOS' build

# Clean build folder
xcodebuild clean -project SevenWondersDice.xcodeproj -scheme SevenWondersDice
```

## Architecture

### MVVM Pattern
The app follows the Model-View-ViewModel architecture pattern:

- **Models** (`SevenWondersDice/Models/`): Data structures representing game entities
  - `Die`: Represents a single die with color and face index
  - `DiceColor`: Enum of 10 dice colors (black, blue, gray1-3, green, purple, red, white, yellow)
  - `Quadrant`: Enum of 4 quadrants (0-3) representing different coin costs

- **ViewModels** (`SevenWondersDice/ViewModels/`): Business logic and state management
  - `DiceBoxViewModel`: Main state manager handling dice rolling, shake detection, and quadrant distribution

- **Views** (`SevenWondersDice/Views/`): SwiftUI views
  - `ContentView`: Main view coordinating between dice selection and results display
  - `DiceSelectionView`: Grid of toggleable dice buttons
  - `QuadrantGridView`: 2x2 grid showing rolled dice distributed across quadrants

### State Management
- Uses `@Published` properties in `DiceBoxViewModel` for reactive state updates
- Main state: `activeDice` (selected dice), `quadrantDice` (roll results), `hasRolled` (display mode)
- All view model operations are `@MainActor` annotated for thread safety

### Motion Detection
- `CMMotionManager` in `DiceBoxViewModel` detects device shaking (threshold: 2.5 acceleration magnitude)
- Shake triggers automatic dice roll with 1-second cooldown to prevent double-rolls

## Critical Implementation Details

### Dice Image Mapping
Each `DiceColor` has 6 faces, but the image files use non-sequential numbering. The `Die.getImageNumber(for:index:)` method maps logical face indices (0-5) to actual image numbers. For example:
- Black dice: [66, 67, 68, 70, 71, 72]
- Some gray variants share image numbers (gray1, gray2, gray3 use overlapping sets)

Images are expected at paths like: `{color.folderName}/IMG_{imageNumber}.jpeg`

### Image Loading Strategy
The app uses a fallback loading mechanism in `QuadrantGridView.swift:117-126`:
1. First attempts to load from app bundle using `UIImage(named:)`
2. Falls back to hardcoded development path: `/Users/ekscrypto/Downloads/Dices/`
3. Displays colored placeholder with "?" if image not found

**Important**: Before deploying, ensure all dice images are properly added to the Xcode asset catalog or bundle.

### Random Distribution
When dice are rolled (`DiceBoxViewModel.rollDice()`):
1. Each active die gets a random face (0 to faceCount-1)
2. Each die is independently assigned to a random quadrant
3. Quadrants can have 0 to N dice (no balanced distribution)

## SwiftUI Patterns

- Uses `@StateObject` for view model ownership in root view
- Binding-based communication between parent and child views
- Spring animations for dice selection and roll button (response: 0.3, damping: 0.6)
- Adaptive grid layout for dice selection (80-100pt min/max width)

## Color Scheme

The app uses an "ancient parchment" theme:
- Background: `Color(red: 0.96, green: 0.95, blue: 0.88)`
- Quadrant backgrounds: Semi-transparent colors (green, blue, orange, red at 0.2 opacity)
- Typography: Serif font for title, emphasizing classical/board game aesthetic
