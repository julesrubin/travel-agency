import SwiftUI

/// Profile view displaying user information and navigation to favorites/settings
struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                // Account Section
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.userName)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(viewModel.userEmail)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Favorites Section
                Section("Favorites") {
                    NavigationLink(destination: FavoritesView(viewModel: viewModel)) {
                        Label("Saved Trips", systemImage: "bookmark.fill")
                    }
                    NavigationLink(destination: Text("Favorite Destinations")) {
                        Label("Favorite Destinations", systemImage: "heart.fill")
                    }
                }
                
                // Preferences Section
                Section("Preferences") {
                    NavigationLink(destination: Text("Interests")) {
                        Label("Travel Interests", systemImage: "star.fill")
                    }
                    NavigationLink(destination: Text("Budget")) {
                        Label("Budget Preferences", systemImage: "dollarsign.circle")
                    }
                    NavigationLink(destination: Text("Notifications")) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                }
                
                // Settings Section
                Section("Settings") {
                    NavigationLink(destination: Text("Account Settings")) {
                        Label("Account", systemImage: "person.fill")
                    }
                    NavigationLink(destination: Text("Privacy")) {
                        Label("Privacy", systemImage: "lock.fill")
                    }
                    NavigationLink(destination: Text("About")) {
                        Label("About", systemImage: "info.circle")
                    }
                }
                
                // Sign Out
                Section {
                    Button(role: .destructive, action: {}) {
                        Label("Sign Out", systemImage: "arrow.right.square")
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
