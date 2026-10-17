# Accord – iOS App For Fragrance Reviews

## About the Project

Accord is an iOS app developed by me, Dayo Araújo, designed to help users explore, record, and discover their olfactory preferences.

The app allows you to write down what you like in a fragrance and classify its traits, such as projection and sillage or even the season in which the fragrance performs better.

What started as a passion for fragrance turned into an elegant, user-friendly application that merges technology with sensory memory.

📱 Available on [App Store](https://apps.apple.com/br/app/accord/id6749021921?l=en-GB)

![Frame 6](https://github.com/user-attachments/assets/5d6db541-985a-4725-8666-3898c66f6db7)

---

## Features

- Search through the fragrance catalog.
- Retrieve important information about any specific fragrance available on the app.
- Visual interface inspired by the 1980/1990 whimsical goth aesthetic for a nostalgic and mystic feel.
- Reviews with text and classifications that can be looked back into.

## Technologies Used

- **SwiftUI**: For developing the user interface in a modern, declarative, and responsive way.
- **Core Data**: Object graph and persistence framework provided by Apple for managing the model layer objects in applications across Apple platforms
- **UserNotifications**: Local reminders to register new perfumes.
- **XCTest / XCUITest**: Unit and UI tests.
- **DocC**: API documentation generated from the source code.

## Architecture

Accord follows **MVVM** with explicit dependency injection:

```
Views ──▶ ViewModels ──▶ Services (protocols) ──▶ Models
```

- **Models**: plain value types (`Card`, `Family`, `NoteCard`, `ReviewDraft`, `ReviewItem`, ...).
- **Services**: everything that touches the outside world hides behind a protocol (`CatalogProviding`, `ReviewRepository`, `NotificationScheduling`, ...), with a Core Data / UserNotifications implementation for production and doubles for tests.
- **ViewModels**: `@MainActor` `ObservableObject`s that hold the state of each screen and never import SwiftUI.
- **Views**: SwiftUI views that render a view model and forward user actions to it.
- **`AppDependencies`**: the composition root. It is created once in `AccordApp` and injected through the SwiftUI environment.

```
Accord/Accord/Accord
├── App/            Entry point, dependency container, launch configuration
├── Models/         Domain value types
├── Services/       Catalog, Core Data persistence and local notifications
├── ViewModels/     One view model per screen
├── Views/          Screens and reusable components
├── Accord.docc/    DocC catalog (landing page, Architecture and Testing articles)
└── Assets.xcassets
Accord/Accord/AccordTests     Unit tests
Accord/Accord/AccordUITests   UI tests
```

## Tests

```bash
xcodebuild test \
  -project Accord/Accord.xcodeproj \
  -scheme Accord \
  -destination 'platform=iOS Simulator,name=<a simulator installed on your Mac>'
```

Or press **⌘U** in Xcode. UI tests launch the app with the `UI_TESTING` argument, which switches it to an in-memory database and disables the splash screen and the notification permission alert.

## Documentation

Open the project in Xcode and choose **Product ▸ Build Documentation** (⌃⇧⌘D). The API reference is generated from the `///` comments, and the catalog also contains the *Architecture* and *Testing* articles.


 ## Contact Information

- [Dayô Araújo](https://www.linkedin.com/in/dayo-araujo/)

---

## How to Run the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/dayoleal/Accord
   ```
2. Open `Accord/Accord.xcodeproj` in Xcode.
3. Select the **Accord** scheme and an iPhone simulator, then press **⌘R**.
