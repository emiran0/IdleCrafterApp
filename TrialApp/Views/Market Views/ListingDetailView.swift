//
//  ListingDetailView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 22.10.2024.
//


import SwiftUI

struct ListingDetailView: View {
    let listing: MarketListing?
    @EnvironmentObject var viewModel: MarketViewModel

    @State private var purchaseQuantity: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let listing = listing {
                Text(listing.itemDisplayName)
                    .font(.largeTitle)
                    .padding(.bottom, 5)

                Text("Seller: \(listing.sellerUsername)")
                    .font(.headline)

                Text("Quantity Available: \(listing.quantity)")
                Text("Price per Item: \(listing.price, specifier: "%.2f") gold")

                TextField("Quantity to Buy", text: $purchaseQuantity)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 10)

                Button(action: {
                    buyItem()
                }) {
                    Text("Buy")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            } else {
                Text("Listing not found.")
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Listing Details", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Purchase"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func buyItem() {
        guard let listing = listing, let quantity = Int(purchaseQuantity), quantity > 0 else {
            alertMessage = "Please enter a valid quantity."
            showAlert = true
            return
        }
        
        if quantity > listing.quantity {
            alertMessage = "You cannot buy more than the available quantity."
            showAlert = true
            return
        }
        
        let request = BuyItemRequest(listingId: listing.id, quantity: quantity)
        print(listing.id, quantity)
        viewModel.buyMarketItem(request: request) { result in
            switch result {
            case .success(let response):
                alertMessage = response.message
                viewModel.fetchMarketListings() // Refresh listings after purchase
            case .failure(let error):
                alertMessage = error.localizedDescription
            }
            showAlert = true
        }
    }
}
