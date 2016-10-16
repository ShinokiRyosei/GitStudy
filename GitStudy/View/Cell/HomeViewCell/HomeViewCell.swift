//
//  HomeViewCell.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var view: UIView!
    
    func applyColor(of hasContribution: Bool = false) {
        if hasContribution {
            view.backgroundColor = UIColor.middleGreen
        }else {
            view.backgroundColor = UIColor.lightGray
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
