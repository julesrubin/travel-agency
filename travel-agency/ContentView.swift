//
//  ContentView.swift
//  travel-agency
//
//  Created by Jules RUBIN on 01/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var previousTab = 0
    @State private var promptToSend: String?
    @State private var showChat = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("For You", systemImage: "heart.fill", value: 0) {
                ForYouView(
                    onPromptSelected: { prompt in
                        promptToSend = prompt
                        showChat = true  // Open chat modal
                    }
                )
            }
            
            Tab("Travel", systemImage: "airplane.departure", value: 1) {
                SearchView()  // Pre-rolled trips / Explore feed
            }
            
            // Separated tab - triggers action instead of navigating
            Tab(value: 2, role: .search) {
                // Empty view - we intercept the tap before it shows
                Color.clear
            } label: {
                Label {
                    Text("Chat")
                } icon: {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .frame(width: 32, height: 32)
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.blue.opacity(0.7)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(Circle())
                        .glassEffect(.regular, in: .circle)
                }
            }
        }
        .tabBarMinimizeBehavior(.automatic)
        .onChange(of: selectedTab) { oldValue, newValue in
            // Intercept chat tab selection
            if newValue == 2 {
                showChat = true
                // Revert to previous tab to prevent navigation
                selectedTab = oldValue
            } else {
                previousTab = oldValue
            }
        }
        .fullScreenCover(isPresented: $showChat) {
            TravelChatView(initialPrompt: $promptToSend)
        }
    }
}

// Enhanced Profile View with favorites and settings
struct ProfileView: View {
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
                            Text("Travel Enthusiast")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("traveler@example.com")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Favorites Section
                Section("Favorites") {
                    NavigationLink(destination: FavoritesView()) {
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

// Favorites View
struct FavoritesView: View {
    var body: some View {
        List {
            // Mock saved trips
            ForEach(0..<3) { index in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(
                                colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 80, height: 80)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Paris, France")
                                .font(.headline)
                            Text("3 days • €450")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                                Text("4.8")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Saved Trips")
        .overlay {
            if true == false { // Change to show empty state
                ContentUnavailableView(
                    "No Saved Trips",
                    systemImage: "bookmark",
                    description: Text("Your saved trips will appear here")
                )
            }
        }
    }
}

#Preview {
    ContentView()
}

