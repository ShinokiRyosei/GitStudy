//
//  CommitDetailViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import JEToolkit

class CommitDetailViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCellClass(CommitDetailTableViewCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CommitDetailViewController: UITableViewDelegate {
    
}

extension CommitDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CommitDetailTableViewCell.self, for: indexPath) as! CommitDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
