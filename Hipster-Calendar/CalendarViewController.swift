//
//  CalendarViewController.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 3/25/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionView: HipCalendarView = HipCalendarView()
        collectionView.frame = view.frame
        collectionView.initialize()
        view.addSubview(collectionView)
    }

}

