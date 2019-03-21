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
    @IBOutlet var subContentView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCellWithModel(model: Products, index: Int) {
        productNameLabel.text = model.keyword
        if let url = URL(string: model.icon.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            productImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.2))],
                progressBlock: { receivedSize, totalSize in
                    print("\(index + 1): \(receivedSize)/\(totalSize)")
                },
                completionHandler: { image, error, cacheType, imageURL in
                    print("\(index + 1): Finished")
                })
        }
    }

}
