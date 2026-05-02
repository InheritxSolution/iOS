//
//  NetworkService.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

/// Defines the possible errors in the networking layer.
public enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case unauthorized
    case serverError(Int)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "The URL provided was invalid."
        case .requestFailed(let error): return "Network request failed: \(error.localizedDescription)"
        case .invalidResponse: return "The server returned an invalid response."
        case .decodingFailed: return "Failed to decode the response from the server."
        case .unauthorized: return "You are not authorized to perform this action."
        case .serverError(let code): return "Server returned an error with code: \(code)"
        case .unknown: return "An unknown error occurred."
        }
    }
}

/// A protocol defining the core networking capabilities.
public protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async -> Result<T, NetworkError>
}

/// Implementation of a premium, async/await based network service.
public final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint) async -> Result<T, NetworkError> {
        guard let urlRequest = endpoint.urlRequest else {
            return .failure(.invalidURL)
        }
        
        Logger.info("🚀 Request: \(endpoint.method.rawValue) \(endpoint.path)")
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    Logger.info("✅ Success: \(endpoint.path)")
                    return .success(decodedData)
                } catch {
                    Logger.error("❌ Decoding Error: \(error)")
                    return .failure(.decodingFailed(error))
                }
            case 401:
                return .failure(.unauthorized)
            default:
                Logger.error("❌ Server Error: \(httpResponse.statusCode)")
                return .failure(.serverError(httpResponse.statusCode))
            }
            
        } catch {
            Logger.error("❌ Request Failed: \(error.localizedDescription)")
            return .failure(.requestFailed(error))
        }
    }
}

// MARK: - Endpoint Helper Structures

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var urlRequest: URLRequest? {
        guard let url = URL(string: path, relativeTo: baseURL) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
