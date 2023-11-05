//
//  NetworkManager.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func performServiceRequest(url: URL) async -> Result<Data, Error>
}

class NetworkManager: NetworkManagerProtocol {
    // Taking URL considering Demo application.
    func performServiceRequest(url: URL) async -> Result<Data, Error> {
        print("API url: \(url)")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
