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
    @State private var showProfile = false
    
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
        .sheet(isPresented: $showProfile) {
            ProfileView()
        }
    }
}

#Preview {
    ContentView()
}

