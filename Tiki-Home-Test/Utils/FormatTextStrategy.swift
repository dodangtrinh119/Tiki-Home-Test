//
//  FormatTextStrategy.swift
//  Tiki-Home-Test
//
//  Created by Đăng Trình on 3/22/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit

//Easy to implement more way to format text. User design pattern: Strategy
protocol FormatTextStrategy {
    
    func formatText(text: String) -> String
    
}

struct FormatText {
    
    let strategy: FormatTextStrategy
    
    func formatText(text: String) -> String {
        return strategy.formatText(text: text)
    }
    
}

struct FormatTwoLine: FormatTextStrategy {
    
    private func getMiddleIndexToRight(text: String) -> Int {
        
        for index in (text.count/2)...text.count - 1 {
            if text[index] == " " {
                return index
            }
        }
        return -1
        
    }
    
    private func getMiddleIndexToLeft(text: String) -> Int {
        
        for index in stride(from: text.count/2, to: 0, by: -1) {
            if text[index] == " " {
                return index
            }
        }
        return -1
        
    }
    
    func insertBreakLineAtMiddle(text: String, middleIndex: Int) -> String {
        var newText = text
        newText.insert("\n", at: newText.index(newText.startIndex, offsetBy: middleIndex))
        newText = newText.replacingOccurrences(of: "\n ", with: "\n", options: .literal, range: nil)
        return newText
    }
    
    func formatText(text: String) -> String {
        let componentString = text.components(separatedBy: .whitespaces)
        if (componentString.count == 1) {
            return text
        }
        let middleFormLeft = getMiddleIndexToLeft(text: text)
        let middleFromRight = getMiddleIndexToRight(text: text)
        if (middleFormLeft == -1) {
            return insertBreakLineAtMiddle(text: text, middleIndex: middleFromRight)
        }
        else if (middleFromRight == -1) {
            return insertBreakLineAtMiddle(text: text, middleIndex: middleFormLeft)
        }
        let firstParam = insertBreakLineAtMiddle(text: text, middleIndex: middleFormLeft)
        let secondParam = insertBreakLineAtMiddle(text: text, middleIndex: middleFromRight)
        if (firstParam.textWidth(font: UIFont.systemFont(ofSize: fontSize)) < secondParam.textWidth(font: UIFont.systemFont(ofSize: fontSize))) {
            return firstParam
        }
        return secondParam
    }
    
}
