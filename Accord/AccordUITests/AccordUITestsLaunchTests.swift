//
//  AccordUITestsLaunchTests.swift
//  AccordUITests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest

final class AccordUITestsLaunchTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchScreenshot() throws {
        let app = XCUIApplication()
        app.launchArguments.append(AccessibilityID.launchArgument)
        app.launch()

        XCTAssertTrue(app.tabBars.firstMatch.waitForExistence(timeout: 10))

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Home after launch"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
