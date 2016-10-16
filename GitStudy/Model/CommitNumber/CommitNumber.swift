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
    
    dynamic var id: Int = 0
    dynamic var contributions: Int = 0
    dynamic var createdAt: Date!
    
    static func hasContributions(at createdAt: Date) -> CommitNumber? {
        if let num = realm.objects(CommitNumber.self).filter("createdAt == %@", createdAt).first {
            return num
        }else {
            return nil
        }
    }
    
    
    static func save(createdAt: Date) -> CommitNumber {
        let num = CommitNumber()
        num.id = num.lastId()
        num.createdAt = createdAt
        num.contributions = 1
        try! CommitNumber.realm.write {
            CommitNumber.realm.add(num)
        }
        return num
    }
    
    static func fetch(with id: Int) -> CommitNumber? {
        let object = CommitNumber.realm.objects(CommitNumber.self).filter("id == %d", id).first
        return object
    }
    
    static func fetch() -> [CommitNumber] {
        let objects = realm.objects(CommitNumber.self).sorted(byProperty: "createdAt", ascending: false)
        var arr: [CommitNumber] = []
        for i in objects {
            arr.append(i)
        }
        return arr
    }
    
    static func countMax() -> Int? {
        if let commitNumber = CommitNumber.realm.objects(CommitNumber.self).sorted(byProperty: "contributions", ascending: false).first {
            return commitNumber.contributions
        }
        return nil
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
