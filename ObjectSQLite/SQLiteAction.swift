//
//  SQLiteAction.swift
//  DBTest
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import UIKit
import SQLite

class SQLiteAction: NSObject {
    
    
    
    /// 建表操作，如果表已存在则跳过
    ///
    /// - Parameters:
    ///   - dataBase: 数据库
    ///   - tableName: 表名
    ///   - tableKeys: 表字段
    func createTable(dataBase:Connection, tableName:String, tableKeys:[String]) -> Void {
        
        let users = Table(tableName)
        
        let expression = getExpression(keyArray: tableKeys)
        
        do {
            try dataBase.run(users.create(ifNotExists: true) { t in
                for exp in expression {
                    t.column(exp)
                }
            })
        } catch {
            print("Create Table failed")
        }
    }
}


// MARK: - 数据插入方法
extension SQLiteAction {
    
    /// 执行数据插入操作
    ///
    /// - Parameters:
    ///   - dataBase: 数据库
    ///   - tableName: 表名
    ///   - tableKeys: 表字段
    func insertData(dataBase:Connection, tableName:String, tableKeys:[String:String], completeBlock:InsertBlock?) -> Void {
        
        self.createTable(dataBase: dataBase, tableName: tableName, tableKeys: Array(tableKeys.keys))
        
        let table = Table(tableName)
        
        let querys = tableKeys.map { (key, value) -> Setter in
            return getInsertQuery(key: key, value: value)
        }
        do {
            try dataBase.run(table.insert(querys))
            if let block = completeBlock {
                block(true)
            }
        } catch {
            if let block = completeBlock {
                block(false)
            }
            print("Insert value failed")
        }
    }
    
    /// 获取查询用的Query
    ///
    /// - Parameters:
    ///   - key: 插入数据的表字段
    ///   - value: 待插入的数据
    /// - Returns: 根据以上参数获得的Query
    func getInsertQuery(key:String, value:String) -> Setter {
        let expression = Expression<String>(key)
        let query = expression <- value
        return query
    }
}

// MARK: - 数据查询方法
extension SQLiteAction {
    
    /// 从数据库获取数据
    ///
    /// - Parameters:
    ///   - dataBase: 数据库
    ///   - model: 数据模型，可为任何继承自NSObject的实例
    ///   - completeBlock: 完成回调
    func fetchData<T>(dataBase:Connection, model:T, completeBlock:((Bool, [T]?) -> Void)?) -> Void {
        
        if let object = model as? NSObject {
            
            let tableKeys = object.getAllPropertys()
            
            let expression = getExpression(keyArray: tableKeys)
            
            let table = Table(object.getClassName())
            
            do {
                let result = try dataBase.prepare(table)
                
                let final = result.map({ (obj) -> NSObject in
                    let temp = object
                    for exp in expression {
                        let propertyName = exp.template.replacingOccurrences(of: "\"", with: "")
                        let success = temp.setValueOfProperty(property: propertyName, value: obj[exp] as AnyObject)
                        if success == false {
                            #if DEBUG
                                print("属性: propertyName 无法赋值")
                            #endif
                        }
                    }
                    return temp
                })
                
                if final is Array<T> {//获取成功，返回结果
                    if let block = completeBlock {
                        block(true, final as! [T])
                    }
                }
                else {
                    if let block = completeBlock {
                        block(false, nil)
                    }
                }
            } catch {
                print("fetch data failed")
                if let block = completeBlock {
                    block(false, nil)
                }
            }
        }
        else {
            if let block = completeBlock {
                block(false, nil)
            }
        }
    }
}

extension SQLiteAction {
    
    /// 根据Key的值，获得SQLite数据库中的expression
    ///
    /// - Parameter keyArray: Key值数组
    /// - Returns: expression数组
    func getExpression(keyArray:[String]) -> [Expression<String>] {
        let expression = keyArray.map({Expression<String>($0)})
        return expression
    }
}
