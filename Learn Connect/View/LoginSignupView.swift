//
//  LoginSignupView.swift
//  Learn Connect
//
//  Created by kadir on 25.11.2024.
//

import SwiftUI

@MainActor
struct LoginSignupView: View {
    
    @State private var viewModel = LoginSignupViewModel()
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    Text(viewModel.isSignupMode ? "Sign Up" : "Sign In")
                        .font(.largeTitle)
                        .bold()
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $viewModel.password)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        } else {
                            SecureField("Password", text: $viewModel.password)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    if viewModel.isSignupMode {
                        HStack {
                            if isConfirmPasswordVisible {
                                TextField("Confirm Password", text: $viewModel.confirmPassword)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            } else {
                                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                isConfirmPasswordVisible.toggle()
                            }) {
                                Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        TextField("Username", text: $viewModel.username)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    NavigationLink(destination: ContentView(), isActive: $viewModel.isAuthenticated) {
                        Button(action: {
                            Task { @MainActor in
                                viewModel.handleAction()
                            }
                        }) {
                            Text(viewModel.isSignupMode ? "Sign Up" : "Sign In")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(viewModel.isPasswordValid ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }.disabled(viewModel.isLoading || !viewModel.isPasswordValid)
                    
                    Button(action: {
                        viewModel.toggleMode()
                    }) {
                        Text(viewModel.isSignupMode ? "Already have an account? Sign In" : "Don't you have an account? Sign Up")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .padding()
                
                ActivityIndicator(isLoading: $viewModel.isLoading)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

