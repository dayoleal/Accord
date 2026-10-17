# Architecture

How the app is organized, and why.

## Overview

Accord uses **MVVM** (Model–View–ViewModel). Each layer has one job, and dependencies only point downwards:

```
Views ──▶ ViewModels ──▶ Services (protocols) ──▶ Models
                              ▲
                              │ implemented by
                  Core Data / UserNotifications / bundled data
```

### Models

Plain value types with no knowledge of SwiftUI or Core Data: ``Card``, ``Family``, ``NoteCard``, ``ReviewDraft``,
``ReviewItem``, ``ScheduledReminder`` and ``NotificationModel``. They are trivial to create in tests.

Rules that belong to the domain live next to the data. For example, ``PerfumeFilter`` decides whether a
perfume matches a family or a note, and ``ReminderSchedule`` does the date math of the weekly reminders.

### Services

Everything that talks to the outside world hides behind a protocol:

| Protocol | Production implementation | Responsibility |
| --- | --- | --- |
| ``CatalogProviding`` | ``StaticCatalog`` | Perfumes, families and notes |
| ``ReviewRepository`` | ``CoreDataReviewRepository`` | Saving, editing and deleting reviews |
| ``ScheduledNotificationStore`` | ``CoreDataScheduledNotificationStore`` | Remembering which notifications were scheduled |
| ``UserNotificationCenter`` | ``SystemUserNotificationCenter`` | Delivering local notifications |
| ``NotificationScheduling`` | ``NotificationService`` | Asking permission, scheduling and cancelling reminders |

``PersistenceController`` owns the single Core Data stack shared by the repositories.

### ViewModels

Each screen with logic has an `ObservableObject` view model, annotated with `@MainActor`. View models

- expose state as `@Published` properties that the view binds to;
- receive their services through `init`, as protocols;
- never import SwiftUI, so they run in plain unit tests.

| Screen | View model |
| --- | --- |
| ``ContentView`` | ``RootViewModel`` |
| ``HomeView`` | ``HomeViewModel`` |
| ``FamilyScrollView`` | ``FamilyCarouselViewModel`` |
| ``SearchView`` | ``SearchViewModel`` |
| Perfume grids | ``PerfumeSectionViewModel`` |
| ``ReviewList`` | ``ReviewListViewModel`` |
| ``ReviewView`` | ``ReviewFormViewModel`` |
| ``NotificationView`` | ``NotificationSettingsViewModel`` |

### Views

Views describe the interface and forward user actions to their view model. A view that owns a view model receives it
through its initializer and keeps it in a `@StateObject`:

```swift
struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    ...
}
```

## Dependency injection

``AppDependencies`` is the *composition root*. ``AccordApp`` builds it once from the ``LaunchConfiguration`` and puts it
in the SwiftUI environment. A view that needs to open another screen reads it with `@Environment(\.dependencies)` and
asks it to build the destination's view model.

| Configuration | Storage | Notifications | Splash |
| --- | --- | --- | --- |
| `.live` | SQLite on disk | System notification center | 1 s |
| `.unitTesting` | In memory | No-op | 1 s |
| `.uiTesting` | In memory | No-op | none |

UI tests select `.uiTesting` by launching the app with the argument `UI_TESTING`.

## Error handling

Services throw. View models catch the error, log it when relevant and publish a short, user-facing `errorMessage`.
The `errorAlert(message:title:)` view modifier turns that message into an alert.

## Persistence compatibility

The Core Data model (`ReviewModel`) was **not** changed by the refactoring, so reviews saved by earlier versions of the
app keep loading. ``Season`` uses the same Portuguese labels that were already stored.
