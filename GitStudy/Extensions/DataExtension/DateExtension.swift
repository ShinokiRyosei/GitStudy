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
    
    internal func formatDate() -> String {
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter.string(from: self)
    }
    
    internal func formatDateWithDay() -> String {
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        return formatter.string(from: self)
    }
    
    internal func day() -> Date {
        
        let calendar: Calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        let today = self.create(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!)
        return today
    }
    
    internal func create(year: Int, month: Int, day: Int) -> Date {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
    
    internal func pastThirtyOneDay() -> Date {
        
        let cal = Calendar(identifier: .gregorian)
        let prevMonth: Date = cal.date(byAdding: .day, value: -365, to: self)!
        return prevMonth
    }
    
    internal func past(to date: Date) -> Int{
        
        let cal = Calendar.current
        let components = cal.dateComponents([.day], from: self, to: date)
        return components.day!
    }
}
