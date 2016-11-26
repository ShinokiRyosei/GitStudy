//
//  CommitDetailTableViewCell.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit


// MARK: CommitDetailTableViewCell

class CommitDetailTableViewCell: UITableViewCell {
    
    
    // MARK: Internal
    
    internal func applyModel(of model: Commit?) {
        
        guard let commit: Commit = model else { return }
        commitImageView.image = commit.image
        dateLabel.text = commit.createdAt.formatDate()
        commitMessageLabel.text = commit.message
    }
    
    
    // MARK: UITableViewCell

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    
    // MARK: Private
    
    @IBOutlet private weak var commitImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var commitMessageLabel: UILabel!
}
