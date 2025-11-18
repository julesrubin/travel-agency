import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Hero image
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(
                        colors: [.blue.opacity(0.7), .purple.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 250)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.7))
                    )
                
                // Trip info
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
                .glassmorphism()
                
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
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OfferCardView: View {
    let title: String
    let price: Int
    let type: String
    
    var body: some View {
        HStack {
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
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .glassmorphism()
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
