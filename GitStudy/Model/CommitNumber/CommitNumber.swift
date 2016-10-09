//
//  CommitNumber.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/09.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class CommitNumber: Object {
    
    static let realm = try! Realm()
    
    dynamic private var id: Int = 0
    dynamic var contributions: Int = 0
    dynamic var createdAt: Date!
    
    static func hasContributions(createdAt: Date) -> CommitNumber?{
        if let num = realm.objects(CommitNumber.self).filter("createdAt == %@", createdAt).first {
            return num
        }else {
            return nil
        }
    }
    
    func create(createdAt: Date) {
        if let `self`: CommitNumber = self {
            self.update()
        }else {
            self.save(createdAt: createdAt)
        }
    }
    
    
    func save(createdAt: Date) {
        let num = CommitNumber()
        num.id = self.lastId()
        num.createdAt = createdAt
        num.contributions = 1
        try! CommitNumber.realm.write {
            CommitNumber.realm.add(num)
        }
    }
    
    func update() {
        try! CommitNumber.realm.write {
            self.contributions = self.contributions + 1
        }
    }
    
    
    func lastId() -> Int {
        if let num = CommitNumber.realm.objects(CommitNumber.self).sorted(byProperty: "id", ascending: false).first {
            return num.id + 1
        }else {
            return 1
        }
    }
    
}
