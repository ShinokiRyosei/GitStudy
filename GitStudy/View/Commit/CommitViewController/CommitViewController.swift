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
    
    @IBOutlet var textField: UITextField!
    var toolBar: UIToolbar!
    var pickerView: UIPickerView!
    var image: UIImage?
    var subject: Subjects = .other
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCommitBtn()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    func setup() {
        pickerView = UIPickerView()
        toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.backgroundColor = UIColor.black
        toolBar.barStyle = UIBarStyle.black
        toolBar.tintColor = UIColor.white
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolBarButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.close))
        toolBarButton.tag = 1
        toolBar.items = [toolBarButton]
        textField.inputAccessoryView = toolBar
        textField.text = subject.string()
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
    
    func close() {
        textField.resignFirstResponder()
    }
}

extension CommitViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
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
