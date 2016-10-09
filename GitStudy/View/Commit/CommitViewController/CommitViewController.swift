//
//  CommitViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import CoreData

class CommitViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.image = image
        }
    }
    @IBOutlet var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    @IBOutlet var textField: UITextField! {
        didSet {
            textField.inputView = pickerView
            pickerView.delegate = self
            pickerView.dataSource = self
            textField.text = subject.string()
        }
    }
    
    var pickerView: UIPickerView = UIPickerView()
    var image: UIImage?
    var subject: Subjects = .other
    var commitNumber: CommitNumber?
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GitStudy")
        container.loadPersistentStores(completionHandler: { (storeDescriptioin, error) in
            if let err = error as NSError? {
                fatalError("Unresolved error \(err), \(err.userInfo)")
            }
        })
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCommitBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        imageView.image = image
    }
    
    func setCommitBtn() {
        let leftBtn: UIBarButtonItem = UIBarButtonItem(title: "Commit", style: .done, target: self, action: #selector(self.commit))
        self.navigationItem.leftBarButtonItem = leftBtn
    }
    
    func commit() {
        let now = Date()
        let context = persistentContainer.viewContext
        let commit = NSEntityDescription.insertNewObject(forEntityName: "Commit", into: context) as! Commit
        commit.image = image?.resize()?.data()
        commit.message = textView.text
        commit.createdAt = now
        commit.subjects = subject.hashValue as NSNumber?
        self.fetchCommitNumber(on: now.day())
        do {
            try context.save()
        }catch {
            
        }
    }
    
    func fetchCommitNumber(on date: Date) {
        let request: NSFetchRequest<CommitNumber> = CommitNumber.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        request.predicate = NSPredicate(format: "createdAt = %@", date as CVarArg)
        let asyncRequest = NSAsynchronousFetchRequest<CommitNumber>(fetchRequest: request, completionBlock: { (result: NSAsynchronousFetchResult<CommitNumber>) in
            if result.finalResult?[0] != nil {
                self.commitNumber = result.finalResult?[0]
                self.commitNumber?.number += 1
            }
            
        })
        
        do {
            try persistentContainer.viewContext.execute(asyncRequest)
        }catch {
            
        }
    }
}

extension CommitViewController: UITextViewDelegate {
    
}

extension CommitViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subject.string(of: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subject.value(in: row)
        self.textField.text = subject.string(of: row)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return subject.count()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
