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
 
    @IBOutlet private var collectionView: UICollectionView!
    fileprivate var formatter: FormatTextStrategy!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "TIKI"
        self.collectionView.register(UINib(nibName:"ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        formatter = FormatTwoLine()
        setupViewModel()
    }
    
    fileprivate let productViewModel = HotProductsViewModel()
    fileprivate let disposeBag = DisposeBag()
    fileprivate lazy var loadingView: LoaddingView = {
        let loadingView = LoaddingView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = .clear
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(loadingView)
        return loadingView
    }()
    
    private func setupViewModel() {
        // --- For loading animation ---
        productViewModel.isLoadingAnimation.subscribe(onNext: { [weak self] (isLoading) in
            if isLoading { self?.loadingView.startLoadding() }
            else {  self?.loadingView.stopLoadding() }
        }).disposed(by: disposeBag)
        
        productViewModel.requestProductDataSources()
        productViewModel.productDataSources.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "ProductCell")) { (index, model, cell) in
            if let cell = cell as? ProductCell {
                cell.setupCellWithModel(model: model, index: index, format: self.formatter)
            }
            }.disposed(by: disposeBag)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = productViewModel.productDataSources.value[indexPath.row].keyword
        let width = formatter.formatText(text: text).maxWidthOfMultiLineText()
        if (width == -1) {
            return CGSize(width: 100, height: 200)
            
        }
        return CGSize(width: width + 14, height: 200)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    

}

