//
//  XCUIApplication+Helpers.swift
//  AccordUITests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest

extension XCUIApplication {

    /// Finds any element, whatever its type, by accessibility identifier.
    func element(_ identifier: String) -> XCUIElement {
        descendants(matching: .any).matching(identifier: identifier).firstMatch
    }

    /// Finds a tab bar button whose label contains `name`.
    func tab(_ name: String) -> XCUIElement {
        tabBars.buttons.matching(NSPredicate(format: "label CONTAINS[c] %@", name)).firstMatch
    }
}

extension XCUIElement {

    /// Waits until the element stops existing.
    ///
    /// - Returns: `true` if the element disappeared before the timeout.
    func waitForNonExistence(timeout: TimeInterval = 5) -> Bool {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
}
