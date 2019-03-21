//
//  StringAlg.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import Foundation
import UIKit

class StringAlg {
    
    static func getMiddleIndex(text: String) -> Int {
        let middleWordIndex = text.count / 2
        for index in middleWordIndex...text.count {
            if text[index] == " " {
                return index
            }
        }
        return -1
    }
    
    static func insertBreakLineAtMiddle(text: String, middleIndex: Int) -> String {
        var newText = text
        newText.insert("\n", at: newText.index(newText.startIndex, offsetBy: middleIndex))
        return newText
    }
    
    static func formatText(text: String) -> String {
        let componentString = text.components(separatedBy: .whitespaces)
        if (componentString.count == 1) {
            return text
        }
        return insertBreakLineAtMiddle(text: text, middleIndex: getMiddleIndex(text: text))
    }
    
    static func maxWidthOfLabel(text: String) -> CGFloat {
        let splitText = text.components(separatedBy: .newlines)
        var maximum: CGFloat = -1
        if splitText.count > 0 {
            for comp in splitText {
                let sizeOfComponent: CGSize = comp.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])

                if (sizeOfComponent.width > maximum) {
                    maximum = sizeOfComponent.width
                }
            }
        }
        else {
            return text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)]).width
        }
        return maximum
    }
    
    
    
}
