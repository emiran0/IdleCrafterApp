//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Networking/NetworkManager.swift

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://127.0.0.1:8000" // Replace with your actual API URL
    
    
    
    // Token is now accessible
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: "jwtToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "jwtToken")
        }
    }
    
    // MARK: - URLRequest Creation
    
    private func createURLRequest(endpoint: String, method: String = "GET", body: Data? = nil, requiresAuth: Bool = true) -> URLRequest {
        let url = URL(string: "\(baseURL)\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = method
        if requiresAuth, let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    // MARK: - Authentication Methods
    
    func login(username: String, password: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyData = "username=\(username)&password=\(password)"
        request.httpBody = bodyData.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                try self.handleResponse(data: data, response: response)
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                self.token = tokenResponse.accessToken
                print("JWT Token: \(tokenResponse.accessToken)") // Print token to console
            }
            .eraseToAnyPublisher()
    }
    
    func signup(username: String, email: String, password: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let signupData = ["Username": username, "Email": email, "Password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: signupData, options: [])
        
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                try self.handleResponse(data: data, response: response)
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                self.token = tokenResponse.accessToken
                print("JWT Token: \(tokenResponse.accessToken)") // Print token to console
            }
            .eraseToAnyPublisher()
    }
    
    func logout() {
        self.token = nil
        UserDefaults.standard.removeObject(forKey: "jwtToken")
    }
    
    // MARK: - Fetch User Data
    
    func fetchUserTools() -> AnyPublisher<UserToolsResponse, Error> {
            guard token != nil else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
            
            let request = createURLRequest(endpoint: "/user/tools")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
//                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    print("API Success Response (Tools)") // Print API response
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys // Use default keys
                    return try decoder.decode(UserToolsResponse.self, from: data)
                }
                .eraseToAnyPublisher()
        }

        func fetchUserItems() -> AnyPublisher<UserItemsResponse, Error> {
            guard token != nil else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
            
            let request = createURLRequest(endpoint: "/user/items")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
//                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    print("API Success Response (Items)") // Print API response
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys // Use default keys
                    return try decoder.decode(UserItemsResponse.self, from: data)
                }
                .eraseToAnyPublisher()
        }
    
    // MARK: - Fetch Craftable Tools
        
        func fetchCraftableTools() -> AnyPublisher<[CraftableTool], Error> {
            guard token != nil else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
            
            let request = createURLRequest(endpoint: "/tool-crafting-recipes")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
//                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    print("API Success Response (Craftable Tools)") // Print API response
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys // Use default keys
                    return try decoder.decode([CraftableTool].self, from: data)
                }
                .eraseToAnyPublisher()
        }
        
        // MARK: - Craft Tool
        
        func craftTool(toolUniqueName: String, toolTier: Int = 1) -> AnyPublisher<Void, Error> {
            guard token != nil else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
            
            let endpoint = "/craft/tool"
            let body: [String: Any] = [
                "tool_unique_name": toolUniqueName,
                "tool_tier": toolTier
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            
            let request = createURLRequest(endpoint: endpoint, method: "POST", body: jsonData)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
                    // Handle response if needed
//                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    print("API Success Response (Craft Tool)") // Print API response
                }
                .eraseToAnyPublisher()
        }
    
    // MARK: - Fetch Item Crafting Recipes for a Tool
        
        func fetchItemCraftingRecipes(for toolUniqueName: String) -> AnyPublisher<ToolRecipesResponse?, Error> {
            guard token != nil else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
            
            let request = createURLRequest(endpoint: "/item-crafting-recipes")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
//                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    print("API Success Response (Item Crafting Recipes)")
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let allRecipes = try decoder.decode([ToolRecipesResponse].self, from: data)
                    // Find the recipes for the specific tool
                    return allRecipes.first { $0.uniqueToolName == toolUniqueName }
                }
                .eraseToAnyPublisher()
        }
        
        // MARK: - Craft Item
        
        func craftItem(itemUniqueName: String, quantity: Int) -> AnyPublisher<Void, Error> {
            guard token != nil else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
            
            let endpoint = "/craft/item"
            let body: [String: Any] = [
                "item_unique_name": itemUniqueName,
                "quantity": quantity
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            
            let request = createURLRequest(endpoint: endpoint, method: "POST", body: jsonData)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
//                    let responseString = String(data: data, encoding: .utf8) ?? ""
                    print("API Success Response (Craft Item)")
                }
                .eraseToAnyPublisher()
        }
    
    // MARK: - Fetch User Profile

        func fetchUserProfile() -> AnyPublisher<UserProfile, Error> {
            guard token != nil else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }

            let request = createURLRequest(endpoint: "/users/me")

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    return try decoder.decode(UserProfile.self, from: data)
                }
                .eraseToAnyPublisher()
        }
    
    
    // MARK: - Tool Management
    
    func toggleToolEnabled(toolUniqueName: String) -> AnyPublisher<ToolToggleResponse, Error> {
        guard token != nil else {
            return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
        }
        
        let endpoint = "/user/tools/\(toolUniqueName)/toggle"
        let request = createURLRequest(endpoint: endpoint, method: "PATCH")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                try self.handleResponse(data: data, response: response)
                let responseString = String(data: data, encoding: .utf8) ?? ""
                print("API Success Response (Toggle Tool): \(responseString)") // Print API response
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(ToolToggleResponse.self, from: data)
            }
            .eraseToAnyPublisher()
    }
    
    
    // MARK: - Market Endpoints

        // 2.1.1 Fetch Market Listings
        func fetchMarketListings() -> AnyPublisher<MarketListingsResponse, Error> {
            let request = createURLRequest(endpoint: "/market/listings")

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    return try decoder.decode(MarketListingsResponse.self, from: data)
                }
                .eraseToAnyPublisher()
        }

        // 2.1.2 Fetch User's Listings
        func fetchUserMarketListings() -> AnyPublisher<MarketListingsResponse, Error> {
            let request = createURLRequest(endpoint: "/market/my-listings")

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    return try decoder.decode(MarketListingsResponse.self, from: data)
                }
                .eraseToAnyPublisher()
        }

        // 2.1.3 List Item for Sale
        func listItemForSale(requestBody: ListItemRequest) -> AnyPublisher<ListItemResponse, Error> {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601

            guard let body = try? encoder.encode(requestBody) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            let request = createURLRequest(endpoint: "/market/list", method: "POST", body: body)

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
                    return try JSONDecoder().decode(ListItemResponse.self, from: data)
                }
                .eraseToAnyPublisher()
        }

        // 2.1.4 Buy Item
        func buyMarketItem(requestBody: BuyItemRequest) -> AnyPublisher<BuyItemResponse, Error> {
            guard let body = try? JSONEncoder().encode(requestBody) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            let request = createURLRequest(endpoint: "/market/buy", method: "POST", body: body)

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
                    return try JSONDecoder().decode(BuyItemResponse.self, from: data)
                }
                .eraseToAnyPublisher()
        }

        // 2.1.5 Cancel Listing
        func cancelMarketListing(requestBody: CancelListingRequest) -> AnyPublisher<CancelListingResponse, Error> {
            guard let body = try? JSONEncoder().encode(requestBody) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            let request = createURLRequest(endpoint: "/market/my-listings/cancel", method: "DELETE", body: body)

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response)
                    return try JSONDecoder().decode(CancelListingResponse.self, from: data)
                }
                .eraseToAnyPublisher()
        }
    
    // MARK: - Helper Methods
    
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        if !(200...299).contains(httpResponse.statusCode) {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            print("API Error Response: \(message)")
            
            if httpResponse.statusCode == 401 {
                // Post a notification or update authentication state
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .didReceiveUnauthorized, object: nil)
                }
            }
            
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: message])
        }
        // Success
    }
}

extension Notification.Name {
    static let didReceiveUnauthorized = Notification.Name("didReceiveUnauthorized")
}
