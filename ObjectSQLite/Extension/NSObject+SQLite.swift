//
//  NSObject+SQLite.swift
//  DBTest
//
//  Created by lvjun on 2017/7/13.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import UIKit
import SQLite

// MARK: - 扩展数据库存取方法
extension NSObject{
    
    public func sql_saveToDataBase(completeBlock:@escaping InsertBlock) -> Void {
        
        SQLite.shared.connect()
        
        SQLite.shared.insertData(tableName: self.getClassName(), tableKeys: self.convertToDictionary(), completeBlock: completeBlock)
    }
}


// MARK: - 工具方法
extension NSObject {
    /**
     获取对象对于的属性值，无对于的属性则返回NIL
     
     - parameter property: 要获取值的属性
     
     - returns: 属性的值
     */
    func getValueOfProperty(property:String)->AnyObject?{
        let allPropertys = self.getAllPropertys()
        if(allPropertys.contains(property)){
            return self.value(forKey: property) as AnyObject
            
        }else{
            return nil
        }
    }
    
    /// 获取类名
    ///
    /// - Returns: 类名字符串
    func getClassName() -> String {
        let name = NSStringFromClass(self.classForCoder).replacingOccurrences(of: ".", with: "_")
        return name
    }
    
    /**
     设置对象属性的值
     
     - parameter property: 属性
     - parameter value:    值
     
     - returns: 是否设置成功
     */
    func setValueOfProperty(property:String,value:AnyObject)->Bool{
        let allPropertys = self.getAllPropertys()
        if(allPropertys.contains(property)){
            
            if let stringValue = value as? String {
                if stringValue.contains("\n") {//是json字符串
                    let object = stringValue.toObject()
                    self.setValue(object, forKey: property)
                    return true
                }
                else {//是普通字符串
                    self.setValue(value, forKey: property)
                    return true
                }
            }
            return false
        }else{
            return false
        }
    }
    
    /**
     获取对象的所有属性名称
     
     - returns: 属性名称数组
     */
    func getAllPropertys()->[String]{
        
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        
        for i in 0 ..< countInt {
            let temp = buff![i]
            let tempPro = property_getName(temp)
            if let tempPro = tempPro {
                let proper = String(utf8String: tempPro)
                result.append(proper!)
            }
        }
        
        return result
    }
}

// MARK: - 转换方法
extension NSObject {
    
    /// Model 转 Dictionary
    ///
    /// - Returns: 数据字典
    func convertToDictionary() -> Dictionary<String, String> {
        
        var resultDic:Dictionary<String, String> = [:]
        let allKeys = self.getAllPropertys()
        
        for key in allKeys {
            if let value = self.getValueOfProperty(property: key) {
                if let result = value as? String {
                    resultDic[key] = result
                }
                else if let result = value as? Array<Any> {
                    resultDic[key] = result.toJsonString()
                }
                else if let result = value as? Dictionary<String,Any> {
                    resultDic[key] = result.toJsonString()
                }
                else if let result = value as? Int {
                    resultDic[key] = "\(result)"
                }
            }
        }
        
        return resultDic
    }
    
    
}
