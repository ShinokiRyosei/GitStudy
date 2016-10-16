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
        self.configureTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
        image = image?.resize()
        imageView.image = image
    }
    
    private func setup() {
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
    
    private func configureTextView() {
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.textViewDone))
        kbToolBar.items = [spacer, commitButton]
        textView.inputAccessoryView = kbToolBar
    }
    
    @objc private func textViewDone() {
        textView.resignFirstResponder()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
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
        let commit = Commit.create(message: textView.text, image: img, createdAt: now, subject: subject.hashValue)
        commit?.save()
        if let commitNumber: CommitNumber = CommitNumber.hasContributions(createdAt: now.day()) {
            commitNumber.update()
            CommitNumber_Commit.create(withCommit: commit!, withCommitNumber: commitNumber).save()
        }else {
            let commitNumber = CommitNumber.save(createdAt: now.day())
            CommitNumber_Commit.create(withCommit: commit!, withCommitNumber: commitNumber).save()
        }
    }
    
    @objc private func close() {
        textField.resignFirstResponder()
    }
}

extension CommitViewController: UITextViewDelegate {
    
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
