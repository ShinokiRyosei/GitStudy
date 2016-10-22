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
    
    var model: CommitNumber!
    
    fileprivate var models: [CommitNumber_Commit]?
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 82
            tableView.tableFooterView = UIView()
            tableView.registerCellClass(CommitDetailTableViewCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        models = self.fetch(with: model)
        tableView.reloadData()
    }
    
    private func setNavBar() {
        self.title = "Commit Detail"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteTheme
    }
    
    private func fetch(with model: CommitNumber) -> [CommitNumber_Commit]? {
        let objects: [CommitNumber_Commit]? = CommitNumber_Commit.fetch(with: model)
        return objects
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
        cell.applyModel(of: (models?[indexPath.row].commit)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
}
