//
//  ReminderScheduleTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class ReminderScheduleTests: XCTestCase {

    private let weekly: TimeInterval = 604_800

    func testWeeklyIntervalFitsFourTimesInTheWindow() {
        XCTAssertEqual(ReminderSchedule.count(forInterval: weekly), 4)
    }

    func testDailyIntervalFitsThirtyTimes() {
        XCTAssertEqual(ReminderSchedule.count(forInterval: 86_400), 30)
    }

    func testInvalidIntervalsProduceNoNotifications() {
        XCTAssertEqual(ReminderSchedule.count(forInterval: 0), 0)
        XCTAssertEqual(ReminderSchedule.count(forInterval: -10), 0)
        XCTAssertEqual(ReminderSchedule.count(forInterval: .nan), 0)
        XCTAssertEqual(ReminderSchedule.count(forInterval: .infinity), 0)
        XCTAssertEqual(ReminderSchedule.count(forInterval: Double(ReminderSchedule.secondsPerMonth) + 1), 0)
    }

    func testDatesStartTodayAtTheRequestedTimeAndAdvanceByTheInterval() {
        let calendar = Fixtures.utcCalendar

        let dates = ReminderSchedule.dates(
            hour: 9,
            minute: 30,
            interval: weekly,
            from: Fixtures.referenceDate,
            calendar: calendar
        )

        XCTAssertEqual(dates.count, 4)

        let components = dates.map { calendar.dateComponents([.year, .month, .day, .hour, .minute], from: $0) }
        XCTAssertEqual(components[0].day, 17)
        XCTAssertEqual(components[0].month, 10)
        XCTAssertEqual(components[1].day, 24)
        XCTAssertEqual(components[2].day, 31)
        XCTAssertEqual(components[3].day, 7)
        XCTAssertEqual(components[3].month, 11)
        for component in components {
            XCTAssertEqual(component.hour, 9)
            XCTAssertEqual(component.minute, 30)
        }
    }

    func testDatesAreEmptyForAnInvalidInterval() {
        let dates = ReminderSchedule.dates(
            hour: 9,
            minute: 0,
            interval: 0,
            from: Fixtures.referenceDate,
            calendar: Fixtures.utcCalendar
        )

        XCTAssertTrue(dates.isEmpty)
    }
}
