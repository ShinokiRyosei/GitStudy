//
//  CommitViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

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
        self.navigationItem.rightBarButtonItem = leftBtn
    }
    
    func commit() {
        let now = Date()
        guard let img: UIImage = image else {
            return
        }
        Commit.create(message: textView.text, image: img, createdAt: now, subject: subject.hashValue)?.save()
        CommitNumber.hasContributions(createdAt: now.day())?.create(createdAt: now.day())
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
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subject.count()
    }
}
