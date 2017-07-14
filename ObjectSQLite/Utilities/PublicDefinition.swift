//
//  PublicDefinition.swift
//  DBTest
//
//  Created by lvjun on 2017/7/14.
//  Copyright © 2017年 lvjun. All rights reserved.
//

import UIKit


/// 默认数据库路径
let DEFAULT_DATABASE_PATH = NSSearchPathForDirectoriesInDomains(
    .documentDirectory, .userDomainMask, true
    ).first! + "/DefaultDB.sqlite3"
