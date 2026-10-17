//
//  RootViewModel.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Drives the app's root screen: the launch splash followed by the tab bar.
@MainActor
final class RootViewModel: ObservableObject {

    /// `true` while the splash screen must be displayed.
    @Published private(set) var isLoading = true

    private let splashDuration: TimeInterval

    /// Creates the view model.
    ///
    /// - Parameter splashDuration: How long, in seconds, the splash is displayed. Pass `0` to skip it.
    init(splashDuration: TimeInterval = 1.0) {
        self.splashDuration = splashDuration
    }

    /// Keeps the splash on screen for ``init(splashDuration:)`` seconds and then hides it.
    ///
    /// Call it from a `.task` modifier. If the task is cancelled the splash is hidden right away.
    func start() async {
        if splashDuration > 0 {
            try? await Task.sleep(nanoseconds: UInt64(splashDuration * 1_000_000_000))
        }
        isLoading = false
    }
}
