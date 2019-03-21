//
//  String+Extension.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func textWidth(font: UIFont) -> CGFloat {
        let myText = self as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    func maxWidthOfMultiLineText() -> CGFloat {
        let splitText = self.components(separatedBy: .newlines)
        var maximum: CGFloat = -1
        if splitText.count > 0 {
            for comp in splitText {
                let sizeOfComponent = comp.textWidth(font: UIFont.systemFont(ofSize: fontSize))
                if (sizeOfComponent > maximum) {
                    maximum = sizeOfComponent
                }
            }
        }
        else {
            return self.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        }
        return maximum
    }

    
}
