//
//  AccordUITests.swift
//  AccordUITests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest

/// End-to-end tests that drive the real app.
///
/// The app is launched with the `UI_TESTING` argument: it uses an in-memory database (every test starts
/// with no reviews), skips the splash screen and never shows the system notification permission alert.
final class AccordUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // MARK: - Helpers

    @MainActor
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append(AccessibilityID.launchArgument)
        app.launch()
        XCTAssertTrue(app.tab("Início").waitForExistence(timeout: 10), "The tab bar should appear after launch")
        return app
    }

    @MainActor
    private func openReviewsTab(in app: XCUIApplication) {
        app.tab("Lista").tap()
        XCTAssertTrue(app.element(AccessibilityID.addButton).waitForExistence(timeout: 5))
    }

    @MainActor
    private func createReview(titled title: String, in app: XCUIApplication) {
        openReviewsTab(in: app)
        app.element(AccessibilityID.addButton).tap()

        let titleField = app.textFields[AccessibilityID.reviewTitleField]
        XCTAssertTrue(titleField.waitForExistence(timeout: 5))
        titleField.tap()
        titleField.typeText(title)

        app.buttons[AccessibilityID.reviewSaveButton].tap()
        XCTAssertTrue(app.staticTexts[title].waitForExistence(timeout: 5), "The new review should be listed")
    }

    // MARK: - Navigation

    @MainActor
    func testTabBarShowsEverySection() {
        let app = launchApp()

        XCTAssertTrue(app.tab("Início").exists)
        XCTAssertTrue(app.tab("Busca").exists)
        XCTAssertTrue(app.tab("Lista").exists)
    }

    @MainActor
    func testHomeShowsTheSectionsAndAPerfumeOpensItsDetails() {
        let app = launchApp()

        XCTAssertTrue(app.staticTexts["Explorar Perfumes"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Famílias Olfativas"].exists)

        let card = app.element(AccessibilityID.perfumeCard("serrasins"))
        XCTAssertTrue(card.waitForExistence(timeout: 5))
        card.tap()

        XCTAssertTrue(app.staticTexts["Topo:"].waitForExistence(timeout: 5), "The perfume detail should show its notes")
        XCTAssertTrue(app.staticTexts["Meio:"].exists)
        XCTAssertTrue(app.staticTexts["Base:"].exists)
    }

    // MARK: - Search

    @MainActor
    func testSearchFindsAPerfumeByNameAndOpensIt() {
        let app = launchApp()
        app.tab("Busca").tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("Poison")

        let result = app.staticTexts["Poison"]
        XCTAssertTrue(result.waitForExistence(timeout: 5))
        result.tap()

        XCTAssertTrue(app.staticTexts["Topo:"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testSearchWithoutMatchListsNothing() {
        let app = launchApp()
        app.tab("Busca").tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("zzzz")

        XCTAssertEqual(app.cells.count, 0)
    }

    // MARK: - Reviews

    @MainActor
    func testReviewsTabStartsEmpty() {
        let app = launchApp()

        openReviewsTab(in: app)

        XCTAssertTrue(app.staticTexts["Meus Registros"].exists)
        XCTAssertEqual(app.cells.count, 0)
    }

    @MainActor
    func testCreatingAReviewAddsItToTheList() {
        let app = launchApp()

        createReview(titled: "Noite de Gala", in: app)

        XCTAssertEqual(app.cells.count, 1)
    }

    @MainActor
    func testCancelingTheFormDoesNotCreateAReview() {
        let app = launchApp()
        openReviewsTab(in: app)
        app.element(AccessibilityID.addButton).tap()

        let titleField = app.textFields[AccessibilityID.reviewTitleField]
        XCTAssertTrue(titleField.waitForExistence(timeout: 5))
        titleField.tap()
        titleField.typeText("Descartado")
        app.buttons[AccessibilityID.reviewCancelButton].tap()

        XCTAssertTrue(app.staticTexts["Meus Registros"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.staticTexts["Descartado"].exists)
        XCTAssertEqual(app.cells.count, 0)
    }

    @MainActor
    func testEditingAReviewUpdatesItInsteadOfDuplicatingIt() {
        let app = launchApp()
        createReview(titled: "Primeiro", in: app)

        app.staticTexts["Primeiro"].tap()
        let titleField = app.textFields[AccessibilityID.reviewTitleField]
        XCTAssertTrue(titleField.waitForExistence(timeout: 5))
        XCTAssertEqual(titleField.value as? String, "Primeiro")

        titleField.tap()
        titleField.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: "Primeiro".count))
        titleField.typeText("Segundo")
        app.buttons[AccessibilityID.reviewSaveButton].tap()

        XCTAssertTrue(app.staticTexts["Segundo"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.staticTexts["Primeiro"].exists)
        XCTAssertEqual(app.cells.count, 1)
    }

    @MainActor
    func testSwipingARowDeletesTheReview() {
        let app = launchApp()
        createReview(titled: "Apagar", in: app)

        app.cells.firstMatch.swipeLeft()
        let deleteButton = app.buttons[AccessibilityID.deleteReviewButton]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 5))
        deleteButton.tap()

        XCTAssertTrue(app.staticTexts["Apagar"].waitForNonExistence())
        XCTAssertEqual(app.cells.count, 0)
    }

    // MARK: - Notifications

    @MainActor
    func testNotificationSettingsRevealTheTimePickerWhenEnabled() {
        let app = launchApp()
        openReviewsTab(in: app)

        app.element(AccessibilityID.notificationsButton).tap()

        let toggle = app.switches[AccessibilityID.remindersToggle]
        XCTAssertTrue(toggle.waitForExistence(timeout: 5))
        XCTAssertFalse(app.element(AccessibilityID.reminderTimePicker).exists)

        // Tap near the trailing edge, where the switch itself is drawn.
        toggle.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()

        XCTAssertTrue(app.element(AccessibilityID.reminderTimePicker).waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons[AccessibilityID.notificationSaveButton].exists)
        XCTAssertTrue(app.buttons[AccessibilityID.notificationDisableButton].exists)
    }
}
