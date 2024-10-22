//
//  MyListingsView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 22.10.2024.
//


import SwiftUI

struct MyListingsView: View {
    @EnvironmentObject var viewModel: MarketViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading your listings...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if viewModel.myListings.isEmpty {
                Text("You have no active listings.")
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(viewModel.myListings) { listing in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(listing.itemDisplayName)
                                    .font(.headline)
                                Text("Quantity: \(listing.quantity)")
                                Text("Price: \(listing.price, specifier: "%.0f") gold each")
                            }
                            Spacer()
                            Button(action: {
                                cancelListing(listingId: listing.id)
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle("My Listings", displayMode: .inline)
        .onAppear {
            viewModel.fetchUserListings()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func cancelListing(listingId: Int) {
        let request = CancelListingRequest(listingId: listingId)
        viewModel.cancelMarketListing(request: request) { result in
            switch result {
            case .success(let response):
                print(response.message)
                viewModel.myListings.removeAll()
                viewModel.fetchUserListings() // Refresh listings after cancellation
            case .failure(let error):
                print("Error cancelling listing: \(error.localizedDescription)")
                viewModel.alertMessage = error.localizedDescription
                viewModel.showAlert = true
            }
        }
    }
}
