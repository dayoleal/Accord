//
//  RootViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

@MainActor
final class RootViewModelTests: XCTestCase {

    func testStartsLoading() {
        let sut = RootViewModel(splashDuration: 0)

        XCTAssertTrue(sut.isLoading)
    }

    func testStartHidesTheSplash() async {
        let sut = RootViewModel(splashDuration: 0)

        await sut.start()

        XCTAssertFalse(sut.isLoading)
    }

    func testStartWaitsForTheSplashDuration() async {
        let sut = RootViewModel(splashDuration: 0.2)
        let startedAt = Date()

        await sut.start()

        XCTAssertFalse(sut.isLoading)
        XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(startedAt), 0.15)
    }
}
