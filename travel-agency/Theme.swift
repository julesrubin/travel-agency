import SwiftUI

struct Theme {
    static let background = Color("Background") // Define in Assets or use system
    static let primary = Color.blue
    static let secondary = Color.purple
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
}

struct Glassmorphism: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}

extension View {
    func glassmorphism() -> some View {
        modifier(Glassmorphism())
    }
}
