//
//  String+JSON.swift
//  DBTest
//
//  Created by lvjun on 2017/7/13.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import UIKit

extension String {
    
    
    /// JSON 字符串 转 JSON 对象
    ///
    /// - Returns: JSON对象
    func toObject() -> Any? {
        
        var object:Any? = nil
        
        let data = self.data(using: .utf8)
        do {
            object = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        } catch {
            print("JSON 转换失败")
        }
        
        return object
    }
}
