# Testing

How the automated tests are organized and how to run them.

## Overview

The project has two test targets.

### AccordTests (unit tests)

Hosted by the app and written with XCTest. Because every dependency is injected through a protocol, tests replace
real services with doubles from `TestDoubles.swift`:

| Double | Replaces |
| --- | --- |
| `FakeReviewRepository` | ``ReviewRepository`` |
| `FakeScheduledNotificationStore` | ``ScheduledNotificationStore`` |
| `SpyUserNotificationCenter` | ``UserNotificationCenter`` |
| `SpyNotificationScheduler` | ``NotificationScheduling`` |
| `FakeCatalog` | ``CatalogProviding`` |

The Core Data implementations are tested against `PersistenceController(inMemory: true)`, which gives each test a clean store.

The suite covers:

- models and filters (``Card``, ``PerfumeFilter``, ``Season``, ``ReviewItem``);
- the catalog, including a check that every image name it references exists in `Assets.xcassets`;
- every view model;
- ``ReminderSchedule`` and ``NotificationService``;
- the Core Data repository and store;
- ``LaunchConfiguration``.

### AccordUITests (UI tests)

Drive the real app through `XCUIApplication`. The app is launched with the `UI_TESTING` argument, which makes it use an
in-memory database, skip the splash and avoid the system permission alert. Elements are found through the identifiers
declared in ``AccessibilityID`` (mirrored in `AccessibilityIdentifiers.swift` inside the UI test target).

## Running

In Xcode press **⌘U**, or from the terminal:

```bash
xcodebuild test \
  -project Accord/Accord.xcodeproj \
  -scheme Accord \
  -destination 'platform=iOS Simulator,name=<a simulator installed on your Mac>'
```

## Building this documentation

Choose **Product ▸ Build Documentation** (⌃⇧⌘D) in Xcode.
