//
//  Logging.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import os

/// Central place for the app's `os.Logger` instances.
///
/// Using the unified logging system (instead of `print`) keeps messages filterable in Console
/// and lets the system redact private values.
enum Log {

    /// Subsystem shared by every logger of the app.
    private static let subsystem = "dayo.Accord"

    /// Messages about Core Data and storage.
    static let persistence = Logger(subsystem: subsystem, category: "persistence")

    /// Messages about local notifications.
    static let notifications = Logger(subsystem: subsystem, category: "notifications")
}
