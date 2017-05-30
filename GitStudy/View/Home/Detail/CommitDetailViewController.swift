//
//  CommitDetailViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift
import JEToolkit

class CommitDetailViewController: UIViewController {
    
    var model: CommitNumber!

    fileprivate var commits: List<Commit>?
    
    fileprivate var detailIndexPath: IndexPath?
    
    @IBOutlet private dynamic weak var tableView: UITableView! {

        didSet {

            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 82
            tableView.tableFooterView = UIView()
            tableView.registerCellClass(CommitDetailTableViewCell.self)
            tableView.registerCellClass(CommitLargeTableViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        commits = model.commits
        tableView.reloadData()
    }
    
    private func setNavBar() {
        self.title = "Commit Detail"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteTheme
    }
}

extension CommitDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        detailIndexPath = indexPath
        tableView.reloadData()
    }
}

extension CommitDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let model: Commit = commits?[indexPath.row] else {

            return UITableViewCell()
        }

        if indexPath == detailIndexPath {
            let cell = tableView.dequeueReusableCell(with: CommitLargeTableViewCell.self, for: indexPath) as! CommitLargeTableViewCell
            cell.applyModel(with: model)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(with: CommitDetailTableViewCell.self, for: indexPath) as! CommitDetailTableViewCell
            cell.applyModel(of: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commits?.count ?? 0
    }
}
