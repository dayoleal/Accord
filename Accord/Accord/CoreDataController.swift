//
//  CoreDataModel.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import Foundation
import CoreData

class CoreDataController {
    static let shared = CoreDataController()
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Could not load CoreData stack: \(error.localizedDescription)")
            }
            
        }
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
        }
    }
    
    func createReview(title: String, sillage: Double, season: String, projection: Double, name: String, desc: String) -> Review {
        let review = Review(context: viewContext)
        
        review.title = title
        review.sillage = sillage
        review.season = season
        review.projection = projection
        review.name = name
        review.desc = desc
        
        saveContext()
        return review
    }
    
    func fetchAllReviews() -> [Review] {
        let fetchRequest: NSFetchRequest<Review> = Review.fetchRequest()
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("Error fetching ToDos: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteReview(_ review: Review) {
        viewContext.delete(review)
        
        saveContext()
    }
}
