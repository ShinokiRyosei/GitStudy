//
//  CommitLargeTableViewCell.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/22.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit


// MARK: - CommitLargeTableViewCell

class CommitLargeTableViewCell: UITableViewCell {
    
    
    // MARK: Internal
    
    internal func applyModel(with model: Commit) {
        dateLabel.text = model.createdAt.formatDateWithDay()
        messageLabel.text = model.message
        subjectLabel.text = Subjects(rawValue: model.subject)?.string()
        commitImageView.image = model.image
    }
    
    
    // MARK: UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: Private
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var commitImageView: UIImageView!
    
}
