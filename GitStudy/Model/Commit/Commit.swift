//
//  Commit.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/09.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class Commit: Object {
    
    static let realm = try! Realm()
    
    dynamic private var id: Int = 0
    dynamic var message: String!
    dynamic private var _image: UIImage? = nil
    dynamic var image: UIImage? {
        set {
            self._image = newValue
            if let value = newValue {
                self.imageData = UIImagePNGRepresentation(value)
            }
        }
        get {
            if let image = self._image {
                return image
            }
            
            if let data = self.imageData {
                self._image = UIImage(data: data)
                return self._image
            }
            
            return nil
        }
    }
    dynamic private var imageData: Data? = nil
    dynamic var createdAt: Date!
    dynamic var subject: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image", "_image"]
    }
    
    static func create(message: String?, image: UIImage, createdAt: Date, subject: Int) -> Commit?{
        guard let mes: String = message else {
            return nil
        }
        let commit = Commit()
        commit.id = lastId()
        commit.message = mes
        commit.image = image
        commit.createdAt = createdAt
        commit.subject = subject
        return commit
    }
    
    
    func save() {
        try! Commit.realm.write {
            Commit.realm.add(self)
        }
    }
    
    static func lastId() -> Int {
        if let todo = realm.objects(Commit.self).sorted(byProperty: "id", ascending: false).first {
            return todo.id + 1
        }else {
            return 1
        }
    }
}
