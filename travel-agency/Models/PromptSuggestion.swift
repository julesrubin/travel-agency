import Foundation

struct PromptSuggestion: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let imageName: String
    
    init(id: UUID = UUID(), title: String, description: String, imageName: String) {
        self.id = id
        self.title = title
        self.description = description
        self.imageName = imageName
    }
}
