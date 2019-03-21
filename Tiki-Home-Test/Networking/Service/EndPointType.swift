//
//  EndPointType.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/22/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
