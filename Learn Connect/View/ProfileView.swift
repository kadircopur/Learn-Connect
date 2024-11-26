//
//  ProfileView.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI


@MainActor
struct ProfileView: View {
    @AppStorage("appearance") private var appearance: Appearance = .system
    
    @State var viewModel = ProfileViewModel()
    @State var isDarkMode = false
    @State var isLogoutAlertVisible = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    
                    VStack(alignment: .leading ) {
                        Text("Email")
                            .font(.title2)
                        
                        Text("\(viewModel.getUserEmail() ?? "Couldn't get user e-mail")")
                            .font(.caption)
                            .allowsHitTesting(false)
                        
                        Spacer()
                    }
                    .padding()
                    
                    VStack(alignment: .leading ) {
                        Text("Username")
                            .font(.title2)
                        
                        Text("\(viewModel.getUserName())")
                            .font(.caption)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                            .font(.title2)
                    }
                    .padding()
                    .onChange(of: isDarkMode) { _, newValue in
                        appearance = newValue ? .dark : .light
                    }
                }
                .padding()
                .onAppear {
                    switch appearance {
                    case .dark:
                        isDarkMode = true
                    default:
                        isDarkMode = false
                    }
                }
                
                Button(action: {
                    isLogoutAlertVisible = true
                }) {
                    Text("Log Out")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                NavigationLink(destination: LoginSignupView(), isActive: $viewModel.isLoggedOut) {
                    EmptyView()
                }
            }
            .alert("Log Out", isPresented: $isLogoutAlertVisible) {
                Button("Yes", role: .destructive) {
                    viewModel.logOut()
                }
                Button("No", role: .cancel) { isLogoutAlertVisible = false }
            } message: {
                Text("Do you want to log out?")
            }
        }
    }
}
