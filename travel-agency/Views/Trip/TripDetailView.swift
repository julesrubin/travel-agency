import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    @State private var selectedTab = 0
    
    // Destination-themed gradient
    private var destinationGradient: LinearGradient {
        let colors: [Color]
        
        switch trip.destination {
        case let dest where dest.contains("Paris"):
            colors = [.pink.opacity(0.6), .purple.opacity(0.5), .blue.opacity(0.4)]
        case let dest where dest.contains("Rome"):
            colors = [.orange.opacity(0.6), .red.opacity(0.5), .yellow.opacity(0.4)]
        case let dest where dest.contains("Barcelona"):
            colors = [.red.opacity(0.6), .orange.opacity(0.5), .yellow.opacity(0.4)]
        case let dest where dest.contains("Tokyo"):
            colors = [.pink.opacity(0.6), .red.opacity(0.5), .purple.opacity(0.4)]
        case let dest where dest.contains("Bali"):
            colors = [.green.opacity(0.6), .teal.opacity(0.5), .blue.opacity(0.4)]
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
        ZStack {
            // Immersive background with extension effect
            destinationGradient
                .ignoresSafeArea()
                .backgroundExtensionEffect()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Hero section with glass effect
                    VStack(spacing: 16) {
                        // Large destination icon
                        Image(systemName: "globe.europe.africa.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.white.opacity(0.9))
                            .padding(.top, 40)
                        
                        // Trip info card with glass effect
                        VStack(alignment: .leading, spacing: 12) {
                            Text(trip.destination)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack {
                                Label(trip.duration, systemImage: "calendar")
                                Spacer()
                                Label(String(format: "%.1f", trip.rating), systemImage: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            
                            Text("€\(Int(trip.price))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassEffect(.regular, in: .rect(cornerRadius: 16))
                        .padding(.horizontal)
                    }
                    
                    // Tabs
                    Picker("Category", selection: $selectedTab) {
                        Text("Flights").tag(0)
                        Text("Hotels").tag(1)
                        Text("Activities").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    // Tab content
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
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OfferCardView: View {
    let title: String
    let price: Int
    let type: String
    @State private var isPressed = false
    
    var body: some View {
        HStack {
            // Icon based on type
            Image(systemName: iconForType)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 50, height: 50)
                .glassEffect(.regular, in: .circle)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                
                Text(type)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                Text("€\(price)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Button(action: {
                    // TODO: Open in SFSafariViewController
                    print("Book with \(title)")
                }) {
                    Text("Book")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(.blue)
                        .clipShape(Capsule())
                }
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = pressing
                    }
                }, perform: {})
            }
        }
        .padding()
        .glassEffect(.regular, in: .rect(cornerRadius: 16))
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
