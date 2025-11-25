import Foundation
import UIKit

struct Trip: Identifiable, Codable {
    let id: UUID
    let destination: String
    let price: Double
    let duration: String
    let imageName: String
    let rating: Double
    
    /// Returns the UIImage for this trip if available
    var image: UIImage? {
        UIImage(named: imageName)
    }
    
    init(id: UUID = UUID(), destination: String, price: Double, duration: String, imageName: String, rating: Double) {
        self.id = id
        self.destination = destination
        self.price = price
        self.duration = duration
        self.imageName = imageName
        self.rating = rating
    }
}
