//
//  CommitNumber-Commit.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class CommitNumber_Commit: Object {
    
    static let realm = try! Realm()
    
    dynamic private var id: Int = 0
    dynamic var commit: Commit!
    dynamic var commitNumber: CommitNumber!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create(withCommit commit: Commit, withCommitNumber commitNumber: CommitNumber) -> CommitNumber_Commit{
        let join = CommitNumber_Commit()
        join.commit = commit
        join.commitNumber = commitNumber
        return join
    }
    
    static func fetch(with model: CommitNumber) -> [CommitNumber_Commit]? {
        let predicate: NSPredicate = NSPredicate(format: "commitNumber == %@", model)
        let fetchObjects = CommitNumber_Commit.realm.objects(CommitNumber_Commit.self).filter(predicate)
        var objects: [CommitNumber_Commit] = []
        for i in fetchObjects {
            objects.append(i)
        }
        return objects
    }
    
    static func lastId() -> Int {
        if let join = realm.objects(CommitNumber_Commit.self).sorted(byProperty: "id", ascending: false).first {
            return join.id + 1
        }else {
            return 1
        }
    }
    
    func save() {
        try! CommitNumber_Commit.realm.write {
            CommitNumber_Commit.realm.add(self)
        }
    }

}
