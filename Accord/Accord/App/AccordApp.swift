//
//  AccordApp.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
//

import SwiftUI

/// The entry point of the app.
///
/// It builds ``AppDependencies`` once, according to how the process was launched, and injects them
/// into the SwiftUI environment for every view.
@main
struct AccordApp: App {

    private let dependencies = AppDependencies.make(for: LaunchConfiguration.current)

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: dependencies.makeRootViewModel())
                .environment(\.dependencies, dependencies)
        }
    }
}
