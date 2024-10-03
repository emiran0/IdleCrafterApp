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
            Text("IDLECRAFTER")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()

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

            // Remove or comment out the inline error message if desired
            /*
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
            */

            Spacer()
        }
        .padding()
        // Add the alert modifier
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text(isLoginMode ? "Login Failed" : "Signup Failed"),
                message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                dismissButton: .default(Text("OK")) {
                    // Optional: Reset error message and alert flag if needed
                    viewModel.errorMessage = nil
                    viewModel.showErrorAlert = false
                }
            )
        }
    }
}