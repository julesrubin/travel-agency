import SwiftUI

struct PromptCardView: View {
    let suggestion: PromptSuggestion
    
    // Travel-themed gradient colors based on suggestion type
    private var destinationGradient: LinearGradient {
        let colors: [Color]
        
        switch suggestion.title {
        case let title where title.contains("Beach"):
            colors = [.cyan.opacity(0.7), .blue.opacity(0.5), .teal.opacity(0.6)]
        case let title where title.contains("Mountain"):
            colors = [.green.opacity(0.6), .mint.opacity(0.5), .gray.opacity(0.4)]
        case let title where title.contains("City"):
            colors = [.orange.opacity(0.6), .pink.opacity(0.5), .purple.opacity(0.4)]
        case let title where title.contains("Foodie"):
            colors = [.red.opacity(0.6), .orange.opacity(0.5), .yellow.opacity(0.4)]
        default:
            colors = [.blue.opacity(0.6), .purple.opacity(0.5), .indigo.opacity(0.4)]
        }
        
        return LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background image area with gradient
            destinationGradient
                .frame(height: 250)
                .overlay(
                    // Simulated destination imagery - centered and more visible
                    Image(systemName: iconForSuggestion)
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.4))
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // Glass effect info card overlaying the bottom
            VStack(alignment: .leading, spacing: 8) {
                Text(suggestion.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text(suggestion.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Image(systemName: "airplane.departure")
                        .font(.caption)
                    Text("Explore now")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .foregroundStyle(.blue)
                .padding(.top, 4)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(.regular, in: .rect(cornerRadius: 16))
            .padding()
        }
        .frame(height: 250)
    }
    
    private var iconForSuggestion: String {
        switch suggestion.title {
        case let title where title.contains("Beach"):
            return "beach.umbrella"
        case let title where title.contains("Mountain"):
            return "mountain.2"
        case let title where title.contains("City"):
            return "building.2"
        case let title where title.contains("Foodie"):
            return "fork.knife"
        default:
            return "globe.europe.africa"
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PromptCardView(suggestion: PromptSuggestion(
            title: "Beach Paradise",
            description: "Sunny destinations in November",
            imageName: "beach_paradise"
        ))
        
        PromptCardView(suggestion: PromptSuggestion(
            title: "Mountain Adventure",
            description: "Hiking and nature trails",
            imageName: "mountain_adventure"
        ))
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
