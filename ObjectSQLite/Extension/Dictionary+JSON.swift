//
//  Dictionary+JSON.swift
//  DBTest
//
//  Created by lvjun on 2017/7/13.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import UIKit

extension Dictionary {
    
    /// Dictionary 转 JSON 字符串
    ///
    /// - Returns: JSON 字符串
    func toJsonString() -> String {
        var json = ""
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            json = String(data: data, encoding: .utf8)!
        } catch {
            print("Json转换失败")
        }
        return json
    }
}
