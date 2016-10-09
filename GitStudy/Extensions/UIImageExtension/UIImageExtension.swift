//
//  UIImageExtension.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/07.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resize() -> UIImage? {
        let size: CGSize = CGSize(width: 150, height: 150)
        let widthRatio = size.width / self.size.width
        let heightRatio = size.height / self.size.height
        let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
        let resizedSize = CGSize(width: (self.size.width * ratio), height: (self.size.height * ratio))
        UIGraphicsBeginImageContext(resizedSize)
        draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func data() -> Data? {
        return UIImagePNGRepresentation(self)
    }
}
