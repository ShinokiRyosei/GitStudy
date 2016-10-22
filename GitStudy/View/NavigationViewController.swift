//
//  NavigationViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/16.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = UIColor.blackTheme
        self.navigationBar.tintColor = UIColor.whiteTheme
    }
}
