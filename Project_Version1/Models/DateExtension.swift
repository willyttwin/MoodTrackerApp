//
//  DateExtension.swift
//  Project_Version1
//
//  Created by Pro on 10/31/23.
//

import Foundation

extension Date {
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func firstDayOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
    func add(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func dayOfWeek() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
}
