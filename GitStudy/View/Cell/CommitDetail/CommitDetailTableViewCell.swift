//
//  CommitDetailTableViewCell.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class CommitDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var commitImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var commitMessageLabel: UILabel!
    
    func applyModel(of model: Commit?) {
        guard let commit: Commit = model else { return }
        commitImageView.image = commit.image
        dateLabel.text = commit.createdAt.formatDate()
        commitMessageLabel.text = commit.message
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
