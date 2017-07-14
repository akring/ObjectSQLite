//
//  String+JSONTests.swift
//  ObjectSQLite-Demo
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import XCTest
@testable import ObjectSQLite

class String_JSONTests: XCTestCase {
    
    let jsonArray = "[\n  {\n    \"key\" : \"value\"\n  },\n  {\n    \"key\" : \"value\"\n  }\n]"
    let jsonDictionary = "{\n  \"key\" : [\n    1,\n    3,\n    2,\n    4,\n    5\n  ]\n}"
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONToObject() {
        //1. array test
        let object1 = jsonArray.toObject()
        XCTAssertNotNil(object1)
        XCTAssertTrue((object1 is Array<Dictionary<String,String>>))
        
        //2. dictionary test
        let object2 = jsonDictionary.toObject()
        XCTAssertNotNil(object2)
        XCTAssertTrue((object2 is Dictionary<String,Array<Int>>))
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
