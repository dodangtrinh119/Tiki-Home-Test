//
//  UIPaddedLabel.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit

class UIPaddedLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    
    @IBInspectable var bottomInset: CGFloat = 5.0
    
    @IBInspectable var leftInset: CGFloat = 7.0
    
    @IBInspectable var rightInset: CGFloat = 7.0
    
    
    
    public override func drawText(in rect: CGRect) {
        
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    
    
    public override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        
        return CGSize(width: size.width + leftInset + rightInset,
                      
                      height: size.height + topInset + bottomInset)
        
    }
    
    
    
    public override func sizeToFit() {
        
        super.sizeThatFits(intrinsicContentSize)
        
    }
    
}
