import SwiftUI

struct Theme {
    static let background = Color("Background") // Define in Assets or use system
    static let primary = Color.blue
    static let secondary = Color.purple
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
}

// iOS 26 GlassEffect wrapper for consistent styling across the app
extension View {
    /// Applies iOS 26's native glass effect with rounded corners
    func glassmorphism() -> some View {
        self
            .glassEffect(.regular, in: .rect(cornerRadius: 16))
    }
}

