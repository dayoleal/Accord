# ``Accord``

An iOS app to explore fragrances and keep a diary of the perfumes you try.

## Overview

Accord lets you browse a catalog of perfumes, filter it by olfactory family or note, search by name and
register reviews that classify projection, longevity and the best season for each fragrance. It can also remind
you, once a week, to register the perfumes you tried.

The code follows the **MVVM** architecture with explicit dependency injection. Read <doc:Architecture> for the big
picture and <doc:Testing> to learn how the unit and UI tests are organized.

## Topics

### Essentials

- <doc:Architecture>
- <doc:Testing>

### App

- ``AccordApp``
- ``ContentView``
- ``AppDependencies``
- ``LaunchConfiguration``
- ``AccessibilityID``

### Models

- ``Card``
- ``Family``
- ``NoteCard``
- ``PerfumeFilter``
- ``Season``
- ``ReviewDraft``
- ``ReviewItem``
- ``NotificationModel``
- ``ScheduledReminder``

### View models

- ``RootViewModel``
- ``HomeViewModel``
- ``SearchViewModel``
- ``PerfumeSectionViewModel``
- ``FamilyCarouselViewModel``
- ``ReviewListViewModel``
- ``ReviewFormViewModel``
- ``NotificationSettingsViewModel``

### Catalog

- ``CatalogProviding``
- ``StaticCatalog``
- ``CatalogData``

### Reviews and persistence

- ``PersistenceController``
- ``ReviewRepository``
- ``CoreDataReviewRepository``
- ``ReviewRepositoryError``

### Notifications

- ``NotificationScheduling``
- ``NotificationService``
- ``UserNotificationCenter``
- ``SystemUserNotificationCenter``
- ``NoOpUserNotificationCenter``
- ``ScheduledNotificationStore``
- ``CoreDataScheduledNotificationStore``
- ``ReminderSchedule``

### Screens

- ``HomeView``
- ``SearchView``
- ``ReviewList``
- ``ReviewView``
- ``NotificationView``
- ``PerfumeView``
- ``FamilyDisplayView``
- ``NoteDisplayView``
- ``LoadingView``
