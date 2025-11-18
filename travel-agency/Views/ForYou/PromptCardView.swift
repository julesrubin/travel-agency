import SwiftUI

struct PromptCardView: View {
    let suggestion: PromptSuggestion
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                    colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 180)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.7))
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(suggestion.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text(suggestion.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 4)
        }
        .padding(16)
        .glassmorphism()
    }
}

#Preview {
    PromptCardView(suggestion: PromptSuggestion(
        title: "Weekend Escape",
        description: "Under €300",
        imageName: "weekend_escape"
    ))
    .padding()
    .background(Color.gray.opacity(0.1))
}
