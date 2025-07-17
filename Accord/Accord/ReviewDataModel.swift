import Foundation
import CoreData

public class ReviewDataModel: ObservableObject {
    @Published var reviews: [Review] = []
    
    func getReview() {
        reviews = CoreDataController.shared.fetchAllReviews()
    }
    
    func createReview(title: String, sillage: Double, season: String, projection: Double, name: String, desc: String) {
        let result = CoreDataController.shared.createReview(title: title, sillage: sillage, season: season, projection: projection, name: name, desc: desc)
        self.reviews.append(result)
    }
    
    func deleteReview(_ review: Review) {
        CoreDataController.shared.deleteReview(review)
    }
    
}
