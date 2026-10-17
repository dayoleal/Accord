//
//  LaunchConfiguration.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// How the app was launched, which decides what kind of services it is wired with.
enum LaunchConfiguration: Equatable {

    /// A regular launch: real database and real notification center.
    case live

    /// The app is hosting unit tests: it uses throw-away storage so tests never touch real data.
    case unitTesting

    /// The app is being driven by UI tests: throw-away storage, no splash and no permission alerts.
    case uiTesting

    /// Launch argument that UI tests pass to the app to select ``uiTesting``.
    static let uiTestingArgument = "UI_TESTING"

    /// Environment variable that Xcode defines when the process is a test host.
    static let testConfigurationKey = "XCTestConfigurationFilePath"

    /// Decides the configuration from the launch information.
    ///
    /// - Parameters:
    ///   - arguments: The process arguments.
    ///   - environment: The process environment.
    init(arguments: [String], environment: [String: String]) {
        if arguments.contains(Self.uiTestingArgument) {
            self = .uiTesting
        } else if environment[Self.testConfigurationKey] != nil {
            self = .unitTesting
        } else {
            self = .live
        }
    }

    /// The configuration of the running process.
    static var current: LaunchConfiguration {
        let info = ProcessInfo.processInfo
        return LaunchConfiguration(arguments: info.arguments, environment: info.environment)
    }
}
