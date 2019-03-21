//
//  HotProductsViewController.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit
import RxSwift

class HotProductsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.register(UINib(nibName:"ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        setupViewModal()
    }
    
    fileprivate let productViewModal = HotProductsViewModal()
    fileprivate let disposeBag = DisposeBag()
    
    private func setupViewModal() {
        productViewModal.requestProductDataSources()
        productViewModal.productDataSources.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "ProductCell")) { (index, model, cell) in
            if let cell = cell as? ProductCell {
                cell.setupCellWithModel(model: model, index: index)
                print("Dang trinh test", index)
            }
            }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    
}
