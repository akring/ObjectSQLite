//
//  NSObject+SQLiteTests.swift
//  ObjectSQLite-Demo
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import XCTest
@testable import ObjectSQLite

class NSObject_SQLiteTests: XCTestCase {
    
    class TestModel: NSObject {
        var name:String?
        var age:String?
        var gender:String?
        var job:Array<String>?
        var infomation:Dictionary<String,Any>?
    }
    
    let model = TestModel()
    
    override func setUp() {
        super.setUp()
        
        model.name = "Chris"
        model.age = "20"
        model.gender = "Male"
        model.job = ["job1", "job2"]
        model.infomation = ["children":["tom","chris"]]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetAllPropertys() {
        
        let propertyKeys = model.getAllPropertys()
        
        XCTAssertNotNil(propertyKeys)
        XCTAssertEqual(propertyKeys.count, 5)
        XCTAssertEqual(propertyKeys, ["name","age","gender","job","infomation",])
    }
    
    func testGetValueOfProperty() {
        
        let name = model.getValueOfProperty(property: "name") as? String
        XCTAssertNotNil(name)
        XCTAssertEqual(name, "Chris")
        
        let job = model.getValueOfProperty(property: "job") as? Array<String>
        XCTAssertNotNil(job)
        XCTAssertEqual(job!, ["job1", "job2"])
        
        let infomation = model.getValueOfProperty(property: "infomation") as? Dictionary<String,Any>
        XCTAssertNotNil(infomation)
        XCTAssertTrue((infomation != nil))
        
    }
    
    func testSetValueOfProperty() {
        
        let result1 = model.setValueOfProperty(property: "name", value: "Curry" as AnyObject)
        XCTAssertTrue(result1)
        XCTAssertEqual(model.name, "Curry")
    }
    
    func testConvertToDictionary() {
        
        let result = model.convertToDictionary()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result["name"], "Chris")
        XCTAssertEqual(result["age"], "20")
        
        let job = result["job"]
        XCTAssertNotNil(job)
        
        let information = result["infomation"]
        XCTAssertNotNil(information)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
