//
//  PersistenceController.swift
//  Accord
//
//  Created by Dayô Araújo on 28/07/25.
//

import CoreData
import Foundation

/// Owns the Core Data stack of the app.
///
/// The previous version of the project created *two* independent stacks for the same `ReviewModel`
/// store (one for reviews and one for notifications). `PersistenceController` replaces both: there is a
/// single container, shared by every repository.
///
/// ## Testing
///
/// Create it with `inMemory: true` to get an isolated, throw-away store:
///
/// ```swift
/// let persistence = PersistenceController(inMemory: true)
/// let repository = CoreDataReviewRepository(persistence: persistence)
/// ```
final class PersistenceController {

    /// The stack used by the running app.
    static let shared = PersistenceController()

    /// Name of the Core Data model (`ReviewModel.xcdatamodeld`) and of the SQLite file.
    static let modelName = "ReviewModel"

    /// The compiled model, loaded only once.
    ///
    /// Loading the model more than once would make Core Data complain about duplicated entity
    /// descriptions as soon as several in-memory stacks are created, which happens in tests.
    private static let managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: PersistenceController.self)
        guard
            let url = bundle.url(forResource: PersistenceController.modelName, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: url)
        else {
            fatalError("[ERROR]: Could not load the Core Data model \"\(PersistenceController.modelName)\"")
        }
        return model
    }()

    /// The underlying persistent container.
    let container: NSPersistentContainer

    /// The main-queue context. Every repository reads and writes through it.
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    /// Creates and loads a Core Data stack.
    ///
    /// - Parameter inMemory: When `true` nothing is written to disk. Use it in tests, previews and UI tests.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(
            name: Self.modelName,
            managedObjectModel: Self.managedObjectModel
        )

        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("[ERROR]: Could not load Core Data stack (\(error.localizedDescription))")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
