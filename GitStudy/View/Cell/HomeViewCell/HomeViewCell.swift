//
//  HomeViewCell.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit


// MARK: HomeViewCell

class HomeViewCell: UICollectionViewCell {
    
    
    // MARK: Internal 
    
    internal func applyColor(of hasContribution: Bool = false) {
        
        if hasContribution {
            
            view.backgroundColor = UIColor.middleGreen
        }else {
            
            view.backgroundColor = UIColor.lightGray
        }
    }
    
    
    // MARK: UICollectionViewCell

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    
    // MARK: Private
    
    @IBOutlet private weak var view: UIView!
}
