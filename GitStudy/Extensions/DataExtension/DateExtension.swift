//
//  DateExtension.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/07.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func format() -> String {
        return ""
    }
    
    func day() -> Date {
        let calendar: Calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        let today = self.create(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!)
        return today
    }
    
    func create(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
}
