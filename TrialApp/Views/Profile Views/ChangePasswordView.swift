//
//  ChangePasswordView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 31.10.2024.
//


import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var showSuccessMessage: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Change Password")) {
                SecureField("Current Password", text: $currentPassword)
                SecureField("New Password", text: $newPassword)
                SecureField("Confirm New Password", text: $confirmPassword)
            }

            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }

            Button(action: {
                changePassword()
            }) {
                Text("Update Password")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(newPassword.isEmpty || confirmPassword.isEmpty || currentPassword.isEmpty)
        }
        .navigationBarTitle("Change Password", displayMode: .inline)
        .alert(isPresented: $showSuccessMessage) {
            Alert(title: Text("Success"), message: Text("Your password has been changed."), dismissButton: .default(Text("OK")))
        }
    }

    private func changePassword() {
        // Implement password change logic
        // Validate inputs and handle errors
        // On success:
        // showSuccessMessage = true
        // On failure:
        // errorMessage = "An error occurred"
    }
}
