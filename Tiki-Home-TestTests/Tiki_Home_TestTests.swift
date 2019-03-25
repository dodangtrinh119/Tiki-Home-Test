//
//  Tiki_Home_TestTests.swift
//  Tiki-Home-TestTests
//
//  Created by Đăng Trình on 3/21/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import XCTest
@testable import Tiki_Home_Test

class Tiki_Home_TestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testFormatText() {
        let formatter = FormatTwoLine()
        var inputTexts: [String]?
        var outputTexts: [String]?
        
        do {
            let testBundle = Bundle(for: type(of: self))
            if let path = testBundle.path(forResource: "inputStringTest", ofType: "txt") {
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                inputTexts = data.components(separatedBy: "!@")
            }
            
            if let path = testBundle.path(forResource: "outputStringTestExpected", ofType: "txt") {
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                outputTexts = data.components(separatedBy: "!@")
            }
            if (inputTexts != nil && outputTexts != nil) {
                for i in 0...(inputTexts?.count)! - 1 {
                    XCTAssertEqual(formatter.formatText(text: inputTexts![i]), outputTexts![i])
                }
            }
        } catch {
            print("Error when read file")
        }
    }

}
