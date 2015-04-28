//
//  HipCalendarDayCollectionViewCell.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 3/25/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class HipCalendarDayCollectionViewCell: UICollectionViewCell {
    
    // UIViews
    var dayLabel: UILabel!
    var dayCircleView: UIView!
    var dayInnerCircleView: UIView!

    // Colors
    var unselectedTextColor : UIColor! = UIColor.whiteColor()
    var unselectedColor : UIColor! = UIColor.blackColor()
    var selectedColor : UIColor! = UIColor(red: 160/255, green: 232/255, blue: 202/255, alpha: 1)
    var circleColor : UIColor! = UIColor(red: 76/255, green: 173/255, blue: 133/255, alpha: 1)
    var todayColor: UIColor! = UIColor(red: 179/255, green: 59/255, blue: 61/255, alpha: 1)
    
    var date: NSDate! {
        didSet {
            dayLabel.text = HipCalendarDayStringFromDate(date)
            dayInnerCircleView.backgroundColor = unselectedColor
            
            if (isToday()) {
                dayLabel.textColor = todayColor
                dayLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
                dayCircleView.backgroundColor = todayColor
            } else {
                dayLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
                dayCircleView.backgroundColor = circleColor
                if (date.month() != NSDate().month()) {
                    dayLabel.textColor = UIColor.grayColor()
                } else {
                    dayLabel.textColor = unselectedTextColor
                }
            }
        }
    }
    
    override var selected: Bool {
        didSet {
            dayInnerCircleView.backgroundColor = selected ? selectedColor : unselectedColor
            
            if (!isToday()) {
                if (date.month() == NSDate().month()) {
                    dayLabel.textColor = selected ? unselectedColor : unselectedTextColor
                } else {
                    dayLabel.textColor = selected ? unselectedColor : UIColor.grayColor()
                }
            }
        }
    }
    
    // Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let dayCircleViewInset:CGFloat = contentView.bounds.size.height * 0.15
        dayCircleView = UIView(frame: CGRectInset(contentView.frame, dayCircleViewInset, dayCircleViewInset))
        dayCircleView.layer.cornerRadius = CGRectGetHeight(dayCircleView.bounds) / 2
        contentView.addSubview(dayCircleView)
        
        let dayInnerCircleViewInset:CGFloat = contentView.bounds.size.height * 0.2
        dayInnerCircleView = UIView(frame: CGRectInset(contentView.frame, dayInnerCircleViewInset, dayInnerCircleViewInset))
        dayInnerCircleView.layer.cornerRadius = CGRectGetHeight(dayInnerCircleView.bounds) / 2
        contentView.addSubview(dayInnerCircleView)
        
        dayLabel = UILabel(frame: self.bounds)
        dayLabel.textAlignment = NSTextAlignment.Center
        contentView.addSubview(dayLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func isToday() -> Bool {
        return (date.month() == NSDate().month() && date.day() == NSDate().day() && date.year() == NSDate().year())
    }
    
    private func HipCalendarDayStringFromDate(date: NSDate) -> String {
        return String(format: "%d", date.day());
    }

}
