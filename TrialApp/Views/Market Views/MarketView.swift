//
//  MarketView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 7.10.2024.
//

import SwiftUI

struct MarketView: View {
    @StateObject private var viewModel = MarketViewModel()
    @EnvironmentObject var categoryViewModel: CategoryViewModel // For items data

    @State private var selectedItem: ItemData?
    @State private var selectedListing: MarketListing?
    @State private var isPresentingListItemSheet = false

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $viewModel.searchQuery, placeholder: "Search items")

                // Listings Section
                if viewModel.isLoading {
                    ProgressView("Loading listings...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List {
                        ForEach(viewModel.filteredListings) { listing in
                            Button(action: {
                                selectedListing = listing
                            }) {
                                VStack(alignment: .leading) {
                                    Text(listing.itemDisplayName)
                                        .font(.headline)
                                    Text("Seller: \(listing.sellerUsername)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("Quantity: \(listing.quantity)")
                                    Text("Price: \(listing.price, specifier: "%.2f") gold each")
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }

                Spacer()
            }
            .navigationBarTitle("Market", displayMode: .inline)
            .navigationBarItems(
                leading: NavigationLink(destination: MyListingsView().environmentObject(viewModel)) {
                    Text("My Listings")
                },
                trailing: Button(action: {
                    isPresentingListItemSheet = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isPresentingListItemSheet) {
                ListItemView()
                    .environmentObject(viewModel)
                    .environmentObject(categoryViewModel)
            }
            .onAppear {
                viewModel.fetchMarketListings()
            }
            // Navigate to Listing Detail View
            .background(
                NavigationLink(
                    destination: ListingDetailView(listing: selectedListing).environmentObject(viewModel),
                    isActive: Binding(
                        get: { selectedListing != nil },
                        set: { if !$0 { selectedListing = nil } }
                    )
                ) {
                    EmptyView()
                }
            )
        }
    }

}

