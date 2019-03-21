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

class HotProductsViewModel {
    
    private let disposeBag = DisposeBag()
    var networkManager: NetworkManager!
    fileprivate(set) var productDataSources = BehaviorRelay(value: [Product]())
    
    init(networkManager: NetworkManager) {
       self.networkManager = networkManager
    }
    
    func requestProductDataSources() {
        networkManager.getHotProducts() { products, error in
            self.productDataSources.accept(products!)
        }
    }
    
    
}
