//
//  HipCalendarViewDelegate.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 3/25/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import Foundation

protocol HipCalendarViewDelegate {
    
    // Reports the selected date.
    func calendarView(calendarView: HipCalendarView, didSelectDate date: NSDate)
    
    // Reports the unselected date.
    func calendarView(calendarView: HipCalendarView, didDeselectDate date: NSDate)
    
}
