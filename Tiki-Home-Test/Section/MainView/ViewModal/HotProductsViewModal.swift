//
//  HotProductsViewModal.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HotProductsViewModal {
    
    private let disposeBag = DisposeBag()
    
    fileprivate(set) var productDataSources = BehaviorRelay(value: [Products]())
    
    func requestProductDataSources() {
        if let jsonData = getDataFromJSONFile(fileName: "products", key: "keywords") {
            do {
                let result = try JSONDecoder().decode([Products].self, from: jsonData)
                productDataSources.accept(result)
            } catch {
                print("Error when parsing JSON: \(error)")
            }
        }
    }
    
     func getDataFromJSONFile(fileName: String, key: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let restaurants = jsonResult[key] as? [Any] {
                    return try JSONSerialization.data(withJSONObject: restaurants, options: [])
                }
            } catch {
                // handle error here
            }
        }
        return nil
    }
    
}
