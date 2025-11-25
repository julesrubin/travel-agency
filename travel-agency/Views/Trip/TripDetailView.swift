import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    @State private var selectedTab = 0
    @State private var adaptiveGradient: LinearGradient?
    
    // Liquid Glass Modifier
    struct LiquidGlass: ViewModifier {
        var cornerRadius: CGFloat
        
        func body(content: Content) -> some View {
            content
                .background(Material.ultraThin) // 1. The Blur/Material Base
                .background(Color.white.opacity(0.5)) // 2. The Tint (Crucial for contrast)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(
                            LinearGradient(
                                colors: [.white.opacity(0.6), .white.opacity(0.1), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10) // 4. Soft Shadow
        }
    }
    
    var body: some View {
        ZStack {
            // Adaptive background extracted from trip image
            (adaptiveGradient ?? fallbackGradient)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Hero image with rounded corners
                    if let image = trip.image {
                        GeometryReader { geometry in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 280)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .shadow(color: .black.opacity(0.3), radius: 20, y: 10)
                        }
                        .frame(height: 280)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    } else {
                        // Fallback icon if no image
                        Image(systemName: "globe.europe.africa.fill")
                            .font(.system(size: 100))
                            .foregroundStyle(.white.opacity(0.95))
                            .padding(.top, 60)
                    }
                    
                    // Glass info card
                    tripInfoCard
                        .modifier(LiquidGlass(cornerRadius: 20))
                        .padding(.horizontal)
                    
                    // Glass tabs
                    customTabPicker
                        .modifier(LiquidGlass(cornerRadius: 24))
                        .padding(.horizontal)
                    
                    // Offer cards
                    offerCardsSection
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Trip Details")
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
            }
        }
        .task {
            // Extract colors when view appears
            if let image = trip.image {
                let colors = image.extractColorPalette()
                adaptiveGradient = LinearGradient(
                    colors: colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
    }
    
    private var fallbackGradient: LinearGradient {
        LinearGradient(
            colors: [.blue.opacity(0.6), .purple.opacity(0.5), .indigo.opacity(0.4)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var tripInfoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(trip.destination)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(uiColor: .darkGray))
            
            HStack(spacing: 20) {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text(trip.duration)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", trip.rating))
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("€\(Int(trip.price))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .font(.subheadline)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var customTabPicker: some View {
        HStack(spacing: 0) {
            ForEach(["Flights", "Hotels", "Activities"], id: \.self) { tab in
                let index = ["Flights", "Hotels", "Activities"].firstIndex(of: tab) ?? 0
                Button(action: { 
                    withAnimation(.spring(response: 0.3)) {
                        selectedTab = index
                    }
                }) {
                    Text(tab)
                        .font(.subheadline)
                        .fontWeight(selectedTab == index ? .bold : .regular)
                        .foregroundColor(selectedTab == index ? .white : .primary.opacity(0.7))
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedTab == index ? 
                            LinearGradient(
                                colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.6)],
                                startPoint: .top,
                                endPoint: .bottom
                            ) : LinearGradient(colors: [.clear], startPoint: .top, endPoint: .bottom)
                        )
                        .clipShape(Capsule())
                        .overlay(
                            selectedTab == index ?
                            Capsule()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                            : nil
                        )
                }
            }
        }
        .padding(4)
    }
    
    private var offerCardsSection: some View {
        VStack(spacing: 16) {
            switch selectedTab {
            case 0:
                OfferCardView(title: "Skyscanner", price: 350, type: "Flight")
                OfferCardView(title: "Google Flights", price: 380, type: "Flight")
            case 1:
                OfferCardView(title: "Booking.com", price: 120, type: "Hotel")
                OfferCardView(title: "Hotels.com", price: 135, type: "Hotel")
            case 2:
                OfferCardView(title: "Viator", price: 50, type: "Activity")
                OfferCardView(title: "GetYourGuide", price: 45, type: "Activity")
            default:
                EmptyView()
            }
        }
        .animation(.easeInOut, value: selectedTab)
    }
}

struct OfferCardView: View {
    let title: String
    let price: Int
    let type: String
    @State private var isPressed = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Glass icon with background
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: iconForType)
                    .font(.title2)
                    .foregroundStyle(.primary) // Dark icon
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(type)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text("€\(price)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Button(action: {
                    // TODO: Open in SFSafariViewController
                    print("Book with \(title)")
                }) {
                    Text("Book")
                        .font(.headline) // Bolder font
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(.blue)
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .modifier(TripDetailView.LiquidGlass(cornerRadius: 20))
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
    
    private var iconForType: String {
        switch type {
        case "Flight":
            return "airplane.departure"
        case "Hotel":
            return "bed.double"
        case "Activity":
            return "figure.hiking"
        default:
            return "mappin.and.ellipse"
        }
    }
}

#Preview {
    NavigationStack {
        TripDetailView(trip: Trip(
            destination: "Paris, France",
            price: 450,
            duration: "3 days",
            imageName: "paris",
            rating: 4.8
        ))
    }
}
