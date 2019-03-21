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

    @IBOutlet private var productImageView: UIImageView!
    @IBOutlet private var productNameLabel: UIPaddedLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productNameLabel.layer.masksToBounds = true
        productNameLabel.layer.cornerRadius = 5
    }

    func setupCellWithModel(model: Product, index: Int, format: FormatTextStrategy) {
        productNameLabel.text = format.formatText(text: model.keyword)
        if (index > textColors.count - 1) {
            productNameLabel.backgroundColor = UIColor(hexString: textColors[index % textColors.count])
        }
        else {
            productNameLabel.backgroundColor = UIColor(hexString: textColors[index])
        }
        productNameLabel.sizeToFit()
        if let url = URL(string: model.icon.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            productImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.2))],
                progressBlock: { receivedSize, totalSize in
                    print("\(index + 1): \(receivedSize)/\(totalSize)")
                },
                completionHandler: { result in
                    print("\(index + 1): Finished")
                })
        }
    }
    
}
