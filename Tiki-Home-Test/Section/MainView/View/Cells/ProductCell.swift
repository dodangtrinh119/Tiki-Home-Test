//
//  ProductCell.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit
import Kingfisher



class ProductCell: UICollectionViewCell {

    static let reuseIdentifier = "ProductCell"
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UIPaddedLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productNameLabel.layer.masksToBounds = true
        productNameLabel.layer.cornerRadius = 5
    }

    func setupCellWithModel(model: Products, index: Int) {
        productNameLabel.text = StringAlg.formatText(text: model.keyword)
        productNameLabel.sizeToFit()
        if let url = URL(string: model.icon.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            productImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.2))],
                progressBlock: { receivedSize, totalSize in
                    print("\(index + 1): \(receivedSize)/\(totalSize)")
                },
                completionHandler: { result in
                    print("\(index + 1): \(result.debugDescription)")
                })
        }
    }
    
}
