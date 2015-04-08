//
//  HipCalendarCollectionReusableView.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 3/25/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class HipCalendarCollectionReusableView: UICollectionReusableView {
    
    var dateFormat: String! = "MMMM YYYY"
    var titleLabel: UILabel!
    var firstDayOfMonth: NSDate! {
        didSet {
            self.titleLabel.text = firstDayOfMonth.timeDescription(dateFormat).uppercaseString
        }
    }
    
    // Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var rect: CGRect = self.bounds
        rect.size.height = 30.0
        rect.origin.y = frame.size.height - rect.size.height
        
        titleLabel = UILabel(frame: rect)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17.5)!
        titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(titleLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
