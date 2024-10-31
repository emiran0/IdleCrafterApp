//
//  SettingsView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 31.10.2024.
//


import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var darkModeEnabled: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Preferences")) {
                Toggle(isOn: $notificationsEnabled) {
                    Text("Enable Notifications")
                }
                Toggle(isOn: $darkModeEnabled) {
                    Text("Enable Dark Mode")
                }
            }

            Section(header: Text("Account")) {
                NavigationLink(destination: ChangePasswordView()) {
                    Text("Change Password")
                }
                NavigationLink(destination: PrivacyPolicyView()) {
                    Text("Privacy Policy")
                }
            }

            Section {
                Button(action: {
                    // Add action for deleting the account
                }) {
                    Text("Delete Account")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}