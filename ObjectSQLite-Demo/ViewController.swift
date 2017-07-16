//
//  ViewController.swift
//  ObjectSQLite-Demo
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import UIKit
import ObjectSQLite
import SQLite

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let people = TestModel()
        people.name = "Name"
        people.age = "30"
        people.gender = "male"
        people.job = ["job1", "job2"]
        people.infomation = ["children":["tom","chris"]]
        
        people.sql_saveToDataBase { (success) in
            print("数据插入操作结果：\(success)")
        }
        SQLite.shared.fetchAllData(model: TestModel()) { (success, result) in
            if success {
                if let final = result {
                    print(final.first!.infomation!)
                }
            }
        }
        let name = Expression<String>("name")
        let filter = Filter(name == "Name")
        SQLite.shared.fetchData(filter: filter, model: TestModel()) { (success, result) in
            if success {
                if let final = result {
                    print("============条件查询结果=============")
                    print("查询到: \(final.count) 个结果")
                    print(final.first!.name!)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

