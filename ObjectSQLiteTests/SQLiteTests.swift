//
//  SQLiteTests.swift
//  ObjectSQLite-Demo
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import XCTest
@testable import ObjectSQLite

class SQLiteTests: XCTestCase {
    
    let sqlInstance = SQLite.shared
    var people:TestModel?
    
    override func setUp() {
        super.setUp()
        XCTAssertNotNil(sqlInstance)
        
        people = TestModel()
        XCTAssertNotNil(people)
    }
    
    override func tearDown() {
        sqlInstance.dataBase = nil
        people = nil
        super.tearDown()
    }
    
    func testConnect() {
        sqlInstance.connect()
        XCTAssertNotNil(sqlInstance.dataBase)
    }
    
    func testInsertData() {
        
        if let people = people {
            people.name = "Name"
            people.age = "30"
            people.gender = "male"
            people.job = ["job1", "job2"]
            people.infomation = ["children":["tom","chris"]]
            
            people.sql_saveToDataBase(completeBlock: { (success) in
                XCTAssertTrue(success)
            })
        }
    }
    
    func testFetchData() {
        
        SQLite.shared.fetchData(model: TestModel()) { (success, result) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(result)
            XCTAssertNotEqual(result?.count, 0)
            
            let object = result!.last!
            let resultJob = ["job1", "job2"]
            XCTAssertEqual(object.name, "Name")
            XCTAssertEqual(object.age, "30")
            XCTAssertEqual(object.gender, "male")
            XCTAssertEqual(object.job!, resultJob)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
