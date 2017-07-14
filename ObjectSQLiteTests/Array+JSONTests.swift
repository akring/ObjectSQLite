//
//  Array+JSONTests.swift
//  ObjectSQLite-Demo
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import XCTest
@testable import ObjectSQLite

class Array_JSONTests: XCTestCase {
    
    let array1 = Array<Any>()
    let array2 = ["1","2"]
    let array3 = [["key":"value"],["key":"value"]]
    let array4 = [1,3,2,4,5]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArrayToJSON() {
        //1. empty test
        let json1 = array1.toJsonString()
        XCTAssertNotNil(json1)
        XCTAssertNotEqual(json1, "")
        
        //2. string array
        let json2 = array2.toJsonString()
        XCTAssertNotNil(json2)
        XCTAssertNotEqual(json2, "")
        
        //3. empty test
        let json3 = array3.toJsonString()
        XCTAssertNotNil(json3)
        XCTAssertNotEqual(json3, "")
        
        //4. string array
        let json4 = array4.toJsonString()
        XCTAssertNotNil(json4)
        XCTAssertNotEqual(json4, "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
