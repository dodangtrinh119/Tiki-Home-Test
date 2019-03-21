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
    
    private func getMiddleWordIndex(text: String) -> Int {
        
        let componentOfText = text.components(separatedBy: .whitespacesAndNewlines)
        if componentOfText.count % 2 == 0 {
            return componentOfText.count / 2 - 1
        }
        return (componentOfText.count + 1) / 2 - 1
    }
    
    private func insertBreakLineAtMiddle(text: String, middleIndex: Int) -> String {
        var newText = text
        let componentOfText = text.components(separatedBy: .whitespacesAndNewlines)
        if (componentOfText.count < 2) {
            return text
        }
        if (componentOfText.count == 2) {
            newText.insert("\n", at: newText.index(newText.startIndex, offsetBy: componentOfText[0].count))
            return newText
        }
        let middlePoint = getMiddleWordIndex(text: text)
        var firstParam = componentOfText[0]
        var secondParam = componentOfText[middlePoint]
        for i in 1...middlePoint {
            firstParam = firstParam + " " + componentOfText[i]
        }
        for i in middlePoint + 1...componentOfText.count - 1 {
            secondParam = secondParam + " " + componentOfText[i]
        }
        
        if (firstParam.textWidth(font: UIFont.systemFont(ofSize: fontSize)) > secondParam.textWidth(font: UIFont.systemFont(ofSize: fontSize))) {
            newText.insert("\n", at: newText.index(newText.startIndex, offsetBy: firstParam.count - componentOfText[middlePoint].count - 1))
        }
        else {
            newText.insert("\n", at: newText.index(newText.startIndex, offsetBy: firstParam.count))
        }
        
        return newText
        
    }
    
    func formatText(text: String) -> String {
        let componentString = text.components(separatedBy: .whitespaces)
        if (componentString.count == 1) {
            return text
        }
        return insertBreakLineAtMiddle(text: text, middleIndex: getMiddleWordIndex(text: text))
    }
    
}
