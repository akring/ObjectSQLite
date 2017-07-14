//
//  Dictionary+JSONTests.swift
//  ObjectSQLite-Demo
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import XCTest
@testable import ObjectSQLite

class Dictionary_JSONTests: XCTestCase {
    
    let dic1 = Dictionary<String,String>()
    let dic2 = ["key":"value"]
    let dic3 = ["key":["key":"value"]]
    let dic4 = ["key":[1,3,2,4,5]]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDictionaryToJSON() {
        //1. empty test
        let json1 = dic1.toJsonString()
        XCTAssertNotNil(json1)
        XCTAssertNotEqual(json1, "")
        
        //2. string array
        let json2 = dic2.toJsonString()
        XCTAssertNotNil(json2)
        XCTAssertNotEqual(json2, "")
        
        //3. empty test
        let json3 = dic3.toJsonString()
        XCTAssertNotNil(json3)
        XCTAssertNotEqual(json3, "")
        
        //4. string array
        let json4 = dic4.toJsonString()
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
