//
//  AppDependencies.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import SwiftUI

/// The composition root of the app: it owns every service and knows how to build every view model.
///
/// Views never create services. They read `AppDependencies` from the SwiftUI environment and ask it for
/// the view model they need:
///
/// ```swift
/// struct AddButton: View {
///     @Environment(\.dependencies) private var dependencies
///
///     var body: some View {
///         NavigationLink {
///             ReviewView(viewModel: dependencies.makeReviewFormViewModel())
///         } label: { ... }
///     }
/// }
/// ```
///
/// The app injects ``live()`` at launch. Previews and tests inject ``inMemory(splashDuration:)``, which
/// has the same shape but never touches the disk or the system notification center.
struct AppDependencies {

    /// Where perfumes, families and notes come from.
    let catalog: CatalogProviding

    /// Where reviews are stored.
    let reviews: ReviewRepository

    /// Schedules and cancels local notifications.
    let notifications: NotificationScheduling

    /// How long the launch splash stays on screen, in seconds.
    let splashDuration: TimeInterval

    // MARK: - Factories

    /// The real dependencies, backed by the on-disk Core Data store and the system notification center.
    static func live() -> AppDependencies {
        let persistence = PersistenceController.shared
        return AppDependencies(
            catalog: StaticCatalog(),
            reviews: CoreDataReviewRepository(persistence: persistence),
            notifications: NotificationService(
                center: SystemUserNotificationCenter(),
                store: CoreDataScheduledNotificationStore(persistence: persistence)
            ),
            splashDuration: 1.0
        )
    }

    /// Dependencies that keep everything in memory and never contact the system notification center.
    ///
    /// Each call creates a fresh, empty store.
    ///
    /// - Parameter splashDuration: How long the launch splash stays on screen, in seconds.
    static func inMemory(splashDuration: TimeInterval = 1.0) -> AppDependencies {
        let persistence = PersistenceController(inMemory: true)
        return AppDependencies(
            catalog: StaticCatalog(),
            reviews: CoreDataReviewRepository(persistence: persistence),
            notifications: NotificationService(
                center: NoOpUserNotificationCenter(),
                store: CoreDataScheduledNotificationStore(persistence: persistence)
            ),
            splashDuration: splashDuration
        )
    }

    /// The dependencies to use for a given launch configuration.
    ///
    /// - Parameter configuration: How the app was launched.
    static func make(for configuration: LaunchConfiguration) -> AppDependencies {
        switch configuration {
        case .live:
            return .live()
        case .unitTesting:
            return .inMemory()
        case .uiTesting:
            return .inMemory(splashDuration: 0)
        }
    }

    /// Dependencies for SwiftUI previews.
    static var preview: AppDependencies {
        .inMemory(splashDuration: 0)
    }

    // MARK: - View model factories

    /// Builds the view model of the root screen.
    @MainActor
    func makeRootViewModel() -> RootViewModel {
        RootViewModel(splashDuration: splashDuration)
    }

    /// Builds the view model of the home tab.
    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(catalog: catalog, notifications: notifications)
    }

    /// Builds the view model of the search tab.
    @MainActor
    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(catalog: catalog)
    }

    /// Builds the view model of a perfume grid.
    ///
    /// - Parameter filter: Which perfumes the grid shows.
    func makePerfumeSectionViewModel(filter: PerfumeFilter) -> PerfumeSectionViewModel {
        PerfumeSectionViewModel(filter: filter, catalog: catalog)
    }

    /// Builds the view model of the review list.
    @MainActor
    func makeReviewListViewModel() -> ReviewListViewModel {
        ReviewListViewModel(repository: reviews)
    }

    /// Builds the view model of the review form.
    ///
    /// - Parameter item: The review to edit, or `nil` to create a new one.
    @MainActor
    func makeReviewFormViewModel(editing item: ReviewItem? = nil) -> ReviewFormViewModel {
        ReviewFormViewModel(repository: reviews, editing: item)
    }

    /// Builds the view model of the notification settings screen.
    @MainActor
    func makeNotificationSettingsViewModel() -> NotificationSettingsViewModel {
        NotificationSettingsViewModel(service: notifications)
    }
}

// MARK: - Environment

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue = AppDependencies.preview
}

extension EnvironmentValues {

    /// The app's dependencies. The default value is an in-memory set, which is what previews use.
    var dependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
