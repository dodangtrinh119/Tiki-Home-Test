//
//  HotProductsViewController.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit
import RxSwift

class HotProductsViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
 
    @IBOutlet var collectionView: UICollectionView!
    private var widthOfCells: [CGFloat]?
    
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
        widthOfCells = [CGFloat](repeating: 0, count: productViewModal.productDataSources.value.count)
        productViewModal.productDataSources.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "ProductCell")) { (index, model, cell) in
            if let cell = cell as? ProductCell {
                cell.setupCellWithModel(model: model, index: index)
            }
            }.disposed(by: disposeBag)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = productViewModal.productDataSources.value[indexPath.row].keyword
        let width = StringAlg.maxWidthOfLabel(text: StringAlg.formatText(text: text))
        if (width == -1) {
            return CGSize(width: 100, height: 160)
            
        }
        return CGSize(width: width + 14, height: 160)

    }
    

}

