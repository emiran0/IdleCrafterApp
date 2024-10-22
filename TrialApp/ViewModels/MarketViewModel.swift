//
//  MarketViewModel.swift
//  TrialApp
//
//  Created by Emiran Kartal on 22.10.2024.
//


import Foundation
import Combine

class MarketViewModel: ObservableObject {
    @Published var allListings: [MarketListing] = []
    @Published var myListings: [MarketListing] = []
    @Published var filteredListings: [MarketListing] = []
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Observe search query changes
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.filterListings(by: query)
            }
            .store(in: &cancellables)
    }

    func fetchMarketListings() {
        isLoading = true
        errorMessage = nil

        NetworkManager.shared.fetchMarketListings()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching market listings: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.allListings = response.listings
                self?.filterListings(by: self?.searchQuery ?? "")
            })
            .store(in: &cancellables)
    }

    func fetchUserListings() {
        NetworkManager.shared.fetchUserMarketListings()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching user market listings: \(error)")
                    // Handle error if necessary
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.myListings = response.listings
            })
            .store(in: &cancellables)
    }

    private func filterListings(by query: String) {
        if query.isEmpty {
            filteredListings = allListings
        } else {
            filteredListings = allListings.filter { $0.itemDisplayName.lowercased().contains(query.lowercased()) }
        }
    }

    func listItemForSale(request: ListItemRequest, completion: @escaping (Result<ListItemResponse, Error>) -> Void) {
        NetworkManager.shared.listItemForSale(requestBody: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .failure(let error):
                    print("Error listing item: \(error)")
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { response in
                print("Item listed: \(response)")
                completion(.success(response))
                self.fetchUserListings() // Refresh user's listings
            })
            .store(in: &cancellables)
    }

    func buyMarketItem(request: BuyItemRequest, completion: @escaping (Result<BuyItemResponse, Error>) -> Void) {
        NetworkManager.shared.buyMarketItem(requestBody: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .failure(let error):
                    print("Error buying item: \(error)")
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { response in
                print("Item bought: \(response)")
                completion(.success(response))
                self.fetchMarketListings() // Refresh market listings
            })
            .store(in: &cancellables)
    }

    func cancelMarketListing(request: CancelListingRequest, completion: @escaping (Result<CancelListingResponse, Error>) -> Void) {
        NetworkManager.shared.cancelMarketListing(requestBody: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .failure(let error):
                    print("Error cancelling listing: \(error)")
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { response in
                print("Listing cancelled: \(response)")
                completion(.success(response))
                self.fetchUserListings() // Refresh user's listings
            })
            .store(in: &cancellables)
    }
}
