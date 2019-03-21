//
//  HotProductEndPoint.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/22/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case staging
}

public enum HotProductApi {
    
    case popular()
    
}

extension HotProductApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .staging: return "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
  
        case .popular:
            return "keywords.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .popular():
            return .request
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
}



