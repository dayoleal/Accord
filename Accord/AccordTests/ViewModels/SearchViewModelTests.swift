//
//  SearchViewModelTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import XCTest
@testable import Accord

@MainActor
final class SearchViewModelTests: XCTestCase {

    private let catalog = FakeCatalog(perfumes: [
        Fixtures.card(name: "Poison"),
        Fixtures.card(name: "Plum de Velours"),
        Fixtures.card(name: "Feerie")
    ])

    func testHasNoResultsWhileTheFieldIsEmpty() {
        let sut = SearchViewModel(catalog: catalog)

        XCTAssertTrue(sut.results.isEmpty)
    }

    func testResultsFollowTheSearchText() {
        let sut = SearchViewModel(catalog: catalog)

        sut.searchText = "p"
        XCTAssertEqual(sut.results.map(\.name), ["Poison", "Plum de Velours"])

        sut.searchText = "poison"
        XCTAssertEqual(sut.results.map(\.name), ["Poison"])
    }

    func testNoMatchGivesNoResults() {
        let sut = SearchViewModel(catalog: catalog)

        sut.searchText = "xyz"

        XCTAssertTrue(sut.results.isEmpty)
    }

    func testClearingTheFieldClearsTheResults() {
        let sut = SearchViewModel(catalog: catalog)
        sut.searchText = "poison"

        sut.searchText = ""

        XCTAssertTrue(sut.results.isEmpty)
    }
}
