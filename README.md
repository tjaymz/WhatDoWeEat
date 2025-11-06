# What Do We Eat? 🍽️

A modern iOS app built with Swift and SwiftUI to help indecisive people figure out what they want to eat!

## Features

- **Beautiful Modern UI**: Clean, gradient-based design with smooth animations
- **Simple Decision Flow**: Two-step process to help you decide:
  1. Choose a cuisine type (American, Chinese, Mexican, Italian, Japanese, Thai, Indian, Mediterranean)
  2. Select dining style (Fast Food, Dine-In, Take Out, Delivery)
- **Smart Recommendations**: Get personalized suggestions based on your choices
- **Maps Integration**: Find nearby restaurants instantly with Apple Maps or Google Maps
  - Opens Maps with a pre-filled search query based on your selection
  - No API keys required - completely free
  - Choose between Apple Maps and Google Maps
- **Smooth Animations**: Spring-based transitions between screens
- **Easy Navigation**: Back button support and reset functionality

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## How to Use

1. Open `WhatDoWeEat.xcodeproj` in Xcode
2. Select your target device or simulator
3. Press `Cmd + R` to build and run

## App Structure

```
WhatDoWeEat/
├── WhatDoWeEatApp.swift      # Main app entry point
├── ContentView.swift          # Landing screen
├── DecisionFlowView.swift     # Main decision flow with all screens
├── Models.swift               # Data models for cuisine and service types
├── DecisionViewModel.swift    # View model managing app state
├── MapsHelper.swift           # Helper for opening Apple/Google Maps
└── Assets.xcassets/          # App icons and colors
```

## Architecture

- **SwiftUI**: Modern declarative UI framework
- **Observable Pattern**: Using Swift's new `@Observable` macro for state management
- **MVVM**: Model-View-ViewModel architecture for clean separation of concerns

## Customization

You can easily add more cuisine types or service options by editing the enums in `Models.swift`:

```swift
enum CuisineType: String, CaseIterable {
    case american = "American"
    // Add more cuisine types here
}

enum ServiceType: String, CaseIterable {
    case fastFood = "Fast Food"
    // Add more service types here
}
```

## How It Works

1. **Welcome Screen**: Tap "Start Deciding" to begin
2. **Choose Cuisine**: Select from 8 different cuisine types
3. **Select Service**: Pick your preferred dining style
4. **Get Results**: View personalized suggestions
5. **Find Places**: Tap "Find Places Near Me" to open Maps with your search
   - Choose Apple Maps or Google Maps
   - Maps opens automatically with optimized search query
   - Location-based results show nearby restaurants matching your choice

## UI Highlights

The app features:
- A welcoming landing page with a warm gradient
- Interactive cuisine selection with emoji icons
- Service type selection with a cool blue gradient
- Final recommendation screen with success message and action buttons
- Maps integration with choice dialog for Apple/Google Maps

## License

This project is open source and available for personal use.
