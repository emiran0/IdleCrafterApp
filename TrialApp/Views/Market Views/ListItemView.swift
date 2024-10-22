//
//  ListItemView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 22.10.2024.
//

import SwiftUI

struct ListItemView: View {
    @EnvironmentObject var viewModel: MarketViewModel
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedItem: ItemData?
    @State private var quantity: String = ""
    @State private var price: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Item")) {
                    Picker("Item", selection: $selectedItem) {
                        Text("Select an item").tag(ItemData?.none)
                        ForEach(categoryViewModel.items) { item in
                            Text(item.itemDisplayName).tag(Optional(item))
                        }
                    }
                }

                if selectedItem != nil {
                    Section(header: Text("Details")) {
                        TextField("Quantity", text: $quantity)
                            .keyboardType(.numberPad)
                        TextField("Price per Item", text: $price)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationBarTitle("List Item", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("List") {
                listItem()
            }.disabled(selectedItem == nil))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("List Item"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "Item listed for sale." {
                        presentationMode.wrappedValue.dismiss()
                    }
                }))
            }
        }
    }

    private func listItem() {
        guard let selectedItem = selectedItem,
              let quantity = Int(self.quantity), quantity > 0,
              let price = Double(self.price), price > 0 else {
            alertMessage = "Please enter valid details."
            showAlert = true
            return
        }

        if quantity > selectedItem.itemQuantity {
            alertMessage = "You cannot list more than you have in your inventory."
            showAlert = true
            return
        }

        let request = ListItemRequest(
            itemUniqueName: selectedItem.itemUniqueName,
            quantity: quantity,
            price: price,
            expireDate: nil
        )

        viewModel.listItemForSale(request: request) { result in
            switch result {
            case .success(_):
                alertMessage = "Item listed for sale."
                viewModel.fetchMarketListings() // Refresh market listings
                categoryViewModel.fetchData() // Refresh inventory
            case .failure(let error):
                alertMessage = error.localizedDescription
            }
            showAlert = true
        }
    }
}
