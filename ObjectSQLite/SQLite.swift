//
//  SQLite.swift
//  DBTest
//
//  Created by lvjun on 2017/7/13.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import UIKit
import SQLite

/// 数据插入完成回调
public typealias InsertBlock = (Bool) -> Void

public class SQLite: NSObject {
    
    public static let shared = SQLite()
    private override init() {}
    
    var dataBase:Connection?
    
    
    /// 数据库连接，如数据库不存在则新增
    public func connect() -> Void {
        do {
            dataBase = try Connection(DEFAULT_DATABASE_PATH)
            print("数据库路径: \(DEFAULT_DATABASE_PATH)")
        } catch  {
            print("DataBase connection failed")
        }
    }
    
    /// 数据插入操作
    ///
    /// - Parameters:
    ///   - tableName: 表名
    ///   - tableKeys: 表字段
    ///   - completeBlock: 完成回调
    public func insertData(tableName:String, tableKeys:[String:String], completeBlock:@escaping InsertBlock) -> Void {
        
        if let dataBase = dataBase {
            SQLiteAction().insertData(dataBase: dataBase, tableName: tableName, tableKeys: tableKeys, completeBlock: completeBlock)
        }
    }
    
    
    /// 数据获取操作
    ///
    /// - Parameters:
    ///   - model: 模型实例
    ///   - completeBlock: 完成回调
    public func fetchData<T>(model:T, completeBlock: @escaping ((Bool, [T]?) -> Void)) -> Void {
        if let dataBase = dataBase {
            SQLiteAction().fetchData(dataBase: dataBase, model: model, completeBlock: completeBlock)
        }
    }
}
