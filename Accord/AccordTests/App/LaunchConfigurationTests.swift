//
//  LaunchConfigurationTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

final class LaunchConfigurationTests: XCTestCase {

    func testRegularLaunchIsLive() {
        let configuration = LaunchConfiguration(arguments: ["Accord"], environment: [:])

        XCTAssertEqual(configuration, .live)
    }

    func testUITestingArgumentSelectsUITesting() {
        let configuration = LaunchConfiguration(arguments: ["Accord", "UI_TESTING"], environment: [:])

        XCTAssertEqual(configuration, .uiTesting)
    }

    func testXCTestEnvironmentSelectsUnitTesting() {
        let configuration = LaunchConfiguration(
            arguments: ["Accord"],
            environment: [LaunchConfiguration.testConfigurationKey: "/tmp/x.xctestconfiguration"]
        )

        XCTAssertEqual(configuration, .unitTesting)
    }

    func testUITestingWinsOverUnitTesting() {
        let configuration = LaunchConfiguration(
            arguments: ["UI_TESTING"],
            environment: [LaunchConfiguration.testConfigurationKey: "x"]
        )

        XCTAssertEqual(configuration, .uiTesting)
    }
}

@MainActor
final class AppDependenciesTests: XCTestCase {

    func testInMemoryDependenciesStartEmptyAndAreIsolated() throws {
        let first = AppDependencies.inMemory()
        let second = AppDependencies.inMemory()

        try first.reviews.create(Fixtures.draft)

        XCTAssertEqual(try first.reviews.fetchAll().count, 1)
        XCTAssertTrue(try second.reviews.fetchAll().isEmpty)
    }

    func testUITestingDependenciesSkipTheSplash() {
        let dependencies = AppDependencies.make(for: .uiTesting)

        XCTAssertEqual(dependencies.splashDuration, 0)
    }

    func testFactoriesShareTheSameStorage() throws {
        let dependencies = AppDependencies.inMemory()
        let form = dependencies.makeReviewFormViewModel()
        let list = dependencies.makeReviewListViewModel()
        form.draft = Fixtures.draft

        XCTAssertTrue(form.save())
        list.load()

        XCTAssertEqual(list.reviews.count, 1)
    }

    func testFactoriesBuildViewModelsFromTheCatalog() {
        let dependencies = AppDependencies.inMemory()

        let home = dependencies.makeHomeViewModel()
        let section = dependencies.makePerfumeSectionViewModel(filter: .all)

        XCTAssertFalse(home.perfumes.isEmpty)
        XCTAssertEqual(section.perfumes, home.perfumes)
    }
}
