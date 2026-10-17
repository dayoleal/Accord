//
//  StaticCatalogTests.swift
//  AccordTests
//
//  Created by Dayô Araújo on 17/10/26.
//

import UIKit
import XCTest
@testable import Accord

final class StaticCatalogTests: XCTestCase {

    private let catalog = StaticCatalog()

    // MARK: Searching and filtering

    func testSearchWithEmptyTextReturnsNothing() {
        XCTAssertTrue(catalog.searchPerfumes(named: "").isEmpty)
    }

    func testSearchMatchesByNamePartIgnoringCase() {
        let names = catalog.searchPerfumes(named: "poi").map(\.name)

        XCTAssertEqual(names, ["Poison"])
    }

    func testSearchIgnoresDiacriticsAndCase() {
        let fake = FakeCatalog(perfumes: [Fixtures.card(name: "Âmbar Noir")])

        XCTAssertEqual(fake.searchPerfumes(named: "ambar").count, 1)
    }

    func testSearchWithoutMatchReturnsNothing() {
        XCTAssertTrue(catalog.searchPerfumes(named: "zzzz").isEmpty)
    }

    func testFilterByAccordOnlyReturnsPerfumesOfThatFamily() {
        let result = catalog.filteredPerfumes(by: .accord("woody.sy"))

        XCTAssertFalse(result.isEmpty)
        XCTAssertTrue(result.allSatisfy { $0.accord.contains("woody.sy") })
    }

    func testFilterByNoteOnlyReturnsPerfumesWithThatNote() {
        let result = catalog.filteredPerfumes(by: .note("wood"))

        XCTAssertFalse(result.isEmpty)
        XCTAssertTrue(result.allSatisfy { $0.contains(note: "wood") })
    }

    func testFilterAllReturnsTheWholeCatalog() {
        XCTAssertEqual(catalog.filteredPerfumes(by: .all), catalog.perfumes)
    }

    // MARK: Data integrity

    func testCatalogIsNotEmpty() {
        XCTAssertFalse(catalog.perfumes.isEmpty)
        XCTAssertFalse(catalog.families.isEmpty)
        XCTAssertFalse(catalog.notes.isEmpty)
    }

    func testPerfumeNamesAreUnique() {
        let names = catalog.perfumes.map(\.name)

        XCTAssertEqual(Set(names).count, names.count)
    }

    func testEveryPerfumeHasAHumanReadableNamePerAccord() {
        for perfume in catalog.perfumes {
            XCTAssertEqual(perfume.accord.count, perfume.accordSearch.count, perfume.name)
        }
    }

    func testEveryAccordUsedByAPerfumeBelongsToAFamily() {
        let familyAccords = Set(catalog.families.map(\.accord))

        for perfume in catalog.perfumes {
            for accord in perfume.accord {
                XCTAssertTrue(familyAccords.contains(accord), "\(perfume.name) uses unknown accord \(accord)")
            }
        }
    }

    func testEveryNoteUsedByAPerfumeExists() {
        let noteImages = Set(catalog.notes.map(\.image))

        for perfume in catalog.perfumes {
            for note in perfume.allNotes {
                XCTAssertTrue(noteImages.contains(note), "\(perfume.name) uses unknown note \(note)")
            }
        }
    }

    func testEveryReferencedImageExistsInTheAssetCatalog() {
        let bundle = Bundle(for: PersistenceController.self)

        var imageNames = Set<String>()
        for perfume in catalog.perfumes {
            imageNames.insert(perfume.perfume)
            imageNames.formUnion(perfume.accord)
            imageNames.formUnion(perfume.allNotes)
        }
        for family in catalog.families {
            imageNames.insert(family.image)
            imageNames.insert(family.accord)
        }
        for note in catalog.notes {
            imageNames.insert(note.image)
        }

        for name in imageNames.sorted() {
            XCTAssertNotNil(UIImage(named: name, in: bundle, compatibleWith: nil), "Missing image asset: \(name)")
        }
    }
}
