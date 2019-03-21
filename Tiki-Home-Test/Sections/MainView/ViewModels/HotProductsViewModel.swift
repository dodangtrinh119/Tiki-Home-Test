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
    fileprivate(set) var productDataSources = BehaviorRelay(value: [Product]())
    fileprivate(set) var isLoadingAnimation = PublishSubject<Bool>()


    func requestProductDataSources() {
        isLoadingAnimation.onNext(true)
        NetworkManager.shared.getHotProducts() { products, error in
            self.productDataSources.accept(products!)
            self.isLoadingAnimation.onNext(false)
        }
    }
    
    
}
