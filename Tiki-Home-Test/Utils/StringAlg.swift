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
        let middleWordIndex = text.count % 2
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
    
    
}
