import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let onSearchTap: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            // Left-aligned tabs
            HStack(spacing: 8) {
                TabButton(
                    icon: "heart.fill",
                    title: "For You",
                    isSelected: selectedTab == 0,
                    action: { selectedTab = 0 }
                )
                
                TabButton(
                    icon: "airplane.departure",
                    title: "Travel",
                    isSelected: selectedTab == 1,
                    action: { selectedTab = 1 }
                )
            }
            .padding(.leading, 16)
            
            Spacer()
            
            // Search button on the right
            Button(action: onSearchTap) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 52, height: 52)
                    .background(
                        Circle()
                            .fill(Color.primary.opacity(0.2))
                    )
            }
            .padding(.trailing, 16)
        }
        .frame(height: 70)
        .glassEffect(.regular, in: .rect(cornerRadius: 0))
    }
}

struct TabButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                
                if isSelected {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                }
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, isSelected ? 20 : 16)
            .padding(.vertical, 12)
            .background(
                Group {
                    if isSelected {
                        Capsule()
                            .fill(Color.blue.opacity(0.8))
                    } else {
                        Capsule()
                            .fill(Color.clear)
                    }
                }
            )
        }
    }
}

#Preview {
    VStack {
        Spacer()
        CustomTabBar(selectedTab: .constant(0), onSearchTap: {})
    }
}
