//
//  CalendarViewController.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 3/25/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: HipCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.center = self.view.center
    }

}

