//
//  CommitNumber.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/09.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

import RealmSwift


// MARK: - CommitNumber

class CommitNumber: Object {
    
    static private let realm = try! Realm()
    
    dynamic internal var id: Int = 0
    dynamic internal var contributions: Int = 0
    dynamic internal var createdAt: Date!
    internal var commits = List<Commit>()
    
    static internal func hasContributions(at createdAt: Date) -> CommitNumber? {
        
        if let num = realm.objects(CommitNumber.self).filter("createdAt == %@", createdAt).first {
            
            return num
        }else {
            
            return nil
        }
    }
    
    
    static internal func save(createdAt: Date) -> CommitNumber {
        
        let num = CommitNumber()
        num.id = num.lastId()
        num.createdAt = createdAt
        num.contributions = 1
        try! CommitNumber.realm.write {
            
            CommitNumber.realm.add(num)
        }
        return num
    }
    
    static internal func fetch(with id: Int) -> CommitNumber? {
        
        let object = realm.objects(CommitNumber.self).filter("id == %d", id).first
        return object
    }
    
    static internal func fetch() -> Results<CommitNumber> {

        return realm.objects(CommitNumber.self).sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    static internal func countMax() -> Int? {
        
        if let commitNumber = CommitNumber.realm.objects(CommitNumber.self).sorted(byKeyPath: "contributions", ascending: false).first {
            
            return commitNumber.contributions
        }
        return nil
    }
    
    internal func update() {
        
        try! CommitNumber.realm.write {
            
            self.contributions = self.contributions + 1
        }
    }
    
    
    internal func lastId() -> Int {
        
        if let num = CommitNumber.realm.objects(CommitNumber.self).sorted(byKeyPath: "id", ascending: false).first {
            
            return num.id + 1
        }else {
            
            return 1
        }
    }
    
}
