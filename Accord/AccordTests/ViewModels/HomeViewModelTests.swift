//
//  HomeViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

@MainActor
final class HomeViewModelTests: XCTestCase {

    func testExposesTheCatalogContent() {
        let catalog = FakeCatalog(
            perfumes: [Fixtures.card(name: "A"), Fixtures.card(name: "B")],
            families: [.sample],
            notes: [.sample]
        )

        let sut = HomeViewModel(catalog: catalog, notifications: SpyNotificationScheduler())

        XCTAssertEqual(sut.perfumes.map(\.name), ["A", "B"])
        XCTAssertEqual(sut.families, [.sample])
        XCTAssertEqual(sut.notes, [.sample])
    }

    func testRequestsNotificationPermission() async {
        let notifications = SpyNotificationScheduler()
        let sut = HomeViewModel(catalog: FakeCatalog(), notifications: notifications)

        await sut.requestNotificationPermission()

        XCTAssertEqual(notifications.authorizationRequests, 1)
    }
}
