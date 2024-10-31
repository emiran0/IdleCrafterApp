//  TrialApp
//
//  Created by Emiran Kartal on 2.10.2024.
//
// Views/ProfileView.swift

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject private var viewModel = ProfileViewModel()

    @State private var profileImage: UIImage? = nil
    @State private var imageSelection: PhotosPickerItem? = nil
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if let profile = viewModel.userProfile {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Profile Picture
                            ZStack(alignment: .bottomTrailing) {
                                if let image = profileImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .foregroundColor(.gray)
                                }

                                // Use PhotosPicker directly
                                PhotosPicker(
                                    selection: $imageSelection,
                                    matching: .images
                                ) {
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                }
                                .offset(x: -10, y: -10)
                            }
                            .padding(.top, 20)

                            // Username
                            Text(profile.username)
                                .font(.title)
                                .fontWeight(.bold)

                            // User Information
                            Form {
                                Section(header: Text("Personal Information")) {
                                    HStack {
                                        Text("Email")
                                        Spacer()
                                        Text(profile.email)
                                            .foregroundColor(.secondary)
                                    }
                                }

                                Section(header: Text("Account Details")) {
                                    HStack {
                                        Text("Gold")
                                        Spacer()
                                        Text("\(profile.gold, specifier: "%.0f")")
                                            .foregroundColor(.secondary)
                                    }
                                    HStack {
                                        Text("Energy")
                                        Spacer()
                                        Text("\(profile.energy, specifier: "%.0f")")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .frame(height: 300)

                            // Logout Button
                            Button(action: {
                                authViewModel.logout()
                            }) {
                                Text("Logout")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {
                    Text("No profile data available.")
                        .padding()
                }
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }
            )
            .onAppear {
                viewModel.fetchUserProfile()
                loadProfileImage()
            }
            // Handle the image selection
            .onChange(of: imageSelection) { _, newValue in
                if let imageSelection = newValue {
                    loadSelectedImage(item: imageSelection)
                }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func loadProfileImage() {
        profileImage = ProfileImageManager.shared.loadImage()
    }

    private func loadSelectedImage(item: PhotosPickerItem) {
        Task {
            do {
                if let data = try await item.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        profileImage = uiImage
                        ProfileImageManager.shared.saveImage(uiImage)
                    } else {
                        errorMessage = "Failed to convert data to image."
                        showErrorAlert = true
                    }
                } else {
                    errorMessage = "No image data found."
                    showErrorAlert = true
                }
            } catch {
                errorMessage = "Failed to load image: \(error.localizedDescription)"
                showErrorAlert = true
            }
        }
    }
}
