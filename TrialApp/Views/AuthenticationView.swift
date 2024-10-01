//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/AuthenticationView.swift

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var isLoginMode = true
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Picker("", selection: $isLoginMode) {
                Text("Login").tag(true)
                Text("Signup").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if !isLoginMode {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
            }
            
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            Button(action: {
                if isLoginMode {
                    viewModel.login(username: username, password: password)
                } else {
                    viewModel.signup(username: username, email: email, password: password)
                }
            }) {
                Text(isLoginMode ? "Login" : "Signup")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}
