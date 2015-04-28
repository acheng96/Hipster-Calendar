//
//  NSDate Extension.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 3/25/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import Foundation

private func HipCalendarDate(components: NSDateComponents) -> NSDate {
    let calendar : NSCalendar = NSCalendar.currentCalendar()
    return calendar.dateFromComponents(components)!
}

extension NSDate {
    
    private func HipCalendarDateComponents(date: NSDate) -> NSDateComponents {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        return calendar.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.WeekCalendarUnit|NSCalendarUnit.WeekdayCalendarUnit|NSCalendarUnit.DayCalendarUnit, fromDate:self)
    }
    
    func components() -> NSDateComponents {
        return HipCalendarDateComponents(self)
    }
    
    func month() -> Int {
        let components : NSDateComponents = HipCalendarDateComponents(self)
        return components.month
    }
    
    func day() -> Int {
        let components : NSDateComponents = HipCalendarDateComponents(self)
        return components.day
    }
    
    func year() -> Int {
        let components : NSDateComponents = HipCalendarDateComponents(self)
        return components.year
    }
    
    func firstDayOfMonth() -> NSDate {
        let components : NSDateComponents = HipCalendarDateComponents(self)
        components.day = 1
        return HipCalendarDate(components)
    }
    
    func lastDayOfMonth() -> NSDate {
        let components : NSDateComponents = HipCalendarDateComponents(self)
        components.month++
        components.day = 0
        return HipCalendarDate(components)
    }
    
    func numDaysInMonth() -> Int {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let firstDay : NSDate = self.firstDayOfMonth()
        let lastDay : NSDate = self.lastDayOfMonth()
        let components : NSDateComponents = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: firstDay, toDate: lastDay, options: NSCalendarOptions(0))
        return components.day + 1
    }
    
    func numberOfMonthsUntilEndDate(endDate: NSDate) -> Int {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let components : NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitMonth, fromDate:self, toDate:endDate, options: NSCalendarOptions(0))
        return components.month
    }
    
    func dateByAddingMonths(months: Int) -> NSDate {
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let components : NSDateComponents = NSDateComponents()
        components.month = months
        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(0))!
    }
    
    func timeDescription(format: String) -> String {
        let formatter: NSDateFormatter =  NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    
    class func dateFromComponents(components: NSDateComponents) -> NSDate {
        return HipCalendarDate(components)
    }
    
}
