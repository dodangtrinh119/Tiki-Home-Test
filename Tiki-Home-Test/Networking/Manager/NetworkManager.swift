//
//  NetworkManager.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/22/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import Foundation
import RxSwift

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

class NetworkManager {
    static let environment: NetworkEnvironment = .staging
    let router = Router<HotProductApi>()
    
    func getDataFromJSON(data: Data, key: String) -> Data? {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let restaurants = jsonResult[key] as? [Any] {
                return try JSONSerialization.data(withJSONObject: restaurants, options: [])
            }
        } catch {
            // handle error here
        }
        return nil
    }
    
    func getHotProducts(completion: @escaping (_ products: [Product]?, _ error: String?) -> ()) {
        router.request(.popular()) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                print(result)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    if let jsonData = self.getDataFromJSON(data: responseData, key: "keywords") {
                        do {
                            let result = try JSONDecoder().decode([Product].self, from: jsonData)
                            completion(result, nil)
                        } catch {
                            print("Error when parsing JSON: \(error)")
                        }
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
