//
//  ReminderSchedule.swift
//  Accord
//
//  Created by Dayô Araújo on 17/10/26.
//

import Foundation

/// Pure date arithmetic used to spread repeating reminders over the next month.
///
/// Local notifications cannot repeat at an arbitrary interval (only daily or weekly through calendar
/// triggers), so the app schedules *individual* notifications for the next month instead. Keeping the math
/// in a stateless type makes it trivial to test.
enum ReminderSchedule {

    /// Length of the scheduling window, in seconds (about 30.4 days).
    static let secondsPerMonth = 2_628_000

    /// How many notifications fit in the scheduling window.
    ///
    /// - Parameter interval: The space between two notifications, in seconds.
    /// - Returns: The number of notifications, or `0` when `interval` is shorter than a second
    ///   or longer than the window.
    static func count(forInterval interval: TimeInterval) -> Int {
        guard interval.isFinite, interval >= 1, interval <= Double(secondsPerMonth) else { return 0 }
        return secondsPerMonth / Int(interval)
    }

    /// Computes when every notification of the window must be delivered.
    ///
    /// The first date is *today* at `hour:minute`; every following date is `interval` seconds after the previous one.
    ///
    /// - Parameters:
    ///   - hour: The hour of the first notification (`0...23`).
    ///   - minute: The minute of the first notification (`0...59`).
    ///   - interval: The space between two notifications, in seconds.
    ///   - now: The current date. It is injected so tests do not depend on the clock.
    ///   - calendar: The calendar used to read today's date.
    /// - Returns: The delivery dates in ascending order.
    static func dates(
        hour: Int,
        minute: Int,
        interval: TimeInterval,
        from now: Date,
        calendar: Calendar
    ) -> [Date] {
        let amount = count(forInterval: interval)
        guard amount > 0 else { return [] }

        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = hour
        components.minute = minute

        var current = calendar.date(from: components) ?? now
        var result: [Date] = []
        for _ in 0..<amount {
            result.append(current)
            current = current.addingTimeInterval(interval)
        }
        return result
    }
}
