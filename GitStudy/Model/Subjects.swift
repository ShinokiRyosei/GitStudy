//
//  Subjects.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/07.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation

enum Subjects {
    case other
    case math
    case langage
    case foreign
    
    func count() -> Int {
        return 4
    }
    
    func string(of num: Int) -> String {
        let subjectNames: [String] = ["その他", "数学", "国語", "英語"]
        return subjectNames[num]
    }
    
    func string() -> String {
        let subjectNames: [String] = ["その他", "数学", "国語", "英語"]
        return subjectNames[self.hashValue]
    }
    
    mutating func value(in num: Int) {
        switch num {
        case 0:
            self = .other
        case 1:
            self = .math
        case 2:
            self = .langage
        case 3:
            self = .foreign
        default:
            self = .other
        }
    }
    
}
