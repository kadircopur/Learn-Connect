//
//  ContentView.swift
//  Learn Connect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

@MainActor
struct ContentView: View {
    
    @State var viewModel: ContentViewModel = ContentViewModel()
    @State var title = ""
    
    var body: some View {
        
        TabView {
            CoursesView()
                .onAppear {
                    title = "Course"
                }
                .tabItem {
                    Label("Courses", systemImage: "book")
                }
            
            MyCoursesView()
                .onAppear {
                    title = "Attended Courses"
                }
                .tabItem {
                    Label("My Courses", systemImage: "list.bullet.rectangle")
                }
            
            FavoritesView()
                .onAppear {
                    title = "Favorite Courses"
                }
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            ProfileView()
                .onAppear {
                    title = "Profile"
                }
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .navigationTitle(title)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
    }
}
