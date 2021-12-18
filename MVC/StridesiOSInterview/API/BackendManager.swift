//
//  BackendManager.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation

class BackendManager {
    // MARK: - Base URL
    private static let baseAPIURL = "https://pokeapi.co/api/v2/"
    
    // MARK: - Enums
    enum APIError: String, Error {
        case AuthError = "You are not authorized to view this information."
        case NoData = "Whoops, please try again!"
        case UnableToDecodeObject = "Whoops, there is something wrong going one. Please try again. "
    }
    
    enum HttpRequestMethod: String {
        case get = "GET"
    }
    
    // MARK: - API
    class func httpRequest<T: Decodable>(method: HttpRequestMethod, endpoint: String, includeBase: Bool = true, completion: @escaping(Result<T, Error>) -> ()) {
        
        guard let url = URL(string: (includeBase ? baseAPIURL : "") + endpoint) else { assert(true, "Invalid URL"); return }
        print(url.absoluteURL)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            
            if response.statusCode == 401 {
                completion(.failure(APIError.AuthError))
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.NoData))
                }
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    completion(.failure(generateDecodeError()))
                }
            } catch let DecodingError.valueNotFound(value, context)  {
                print("Value not found: '\(value)' message:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    completion(.failure(generateDecodeError()))
                }
            } catch let DecodingError.keyNotFound(key, context)  {
                print("Key not found: '\(key)' message:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    completion(.failure(generateDecodeError()))
                }
            }catch let DecodingError.dataCorrupted(context)  {
                print("Data corrupted:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    completion(.failure(generateDecodeError()))
                }
            } catch let e {
                print("[BackendManager]: Failed to decode object of type \(T.self) \nError: \(e)")
                DispatchQueue.main.async {
                    completion(.failure(generateDecodeError()))
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: - Private Methods
    
    /*
     Generates a networking error with decode error messages
     */
    class private func generateDecodeError() -> APINetworkingError {
        return APINetworkingError(error: .UnableToDecodeObject, message: APIError.UnableToDecodeObject.rawValue)
    }
    
    struct APINetworkingError: Error {
        let error: APIError
        let message: String
    }
}
