//
//  HipCalendarView.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 3/25/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class HipCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate : HipCalendarViewDelegate?
    var calendar : NSCalendar! = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    var startDate : NSDate! = NSDate()
    var endDate : NSDate! = NSDate().dateByAddingMonths(12).lastDayOfMonth()
    var dates : [NSDate]! = []
    var daySize : CGSize!
    var padding : CGFloat = 15
    
    // Initializer
    
    func initialize() {
        
        let cols : Int = 6
        let cwidth = self.frame.width/CGFloat(cols)
        let cheight = cwidth
        daySize = CGSize(width: cwidth, height: cheight)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        var collectionView : UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.allowsMultipleSelection = true
        self.addSubview(collectionView)
        
        collectionView.registerClass(HipCalendarCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.registerClass(HipCalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: "DayCell")
    }
    
    // Helper Methods
    
    private func dateForIndexPath(indexPath: NSIndexPath ) -> NSDate {
        var date : NSDate! = startDate?.dateByAddingMonths(indexPath.section)
        let components : NSDateComponents = date.components()
        components.day = indexPath.item + 1
        date = NSDate.dateFromComponents(components)

        return date;
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        var numberOfMonths : Int? = startDate?.numberOfMonthsUntilEndDate(self.endDate!)
        return numberOfMonths == nil ? 0 : numberOfMonths!
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let firstDayOfMonth : NSDate? = startDate?.firstDayOfMonth().dateByAddingMonths(section)
        let lastDayOfMonth : NSDate? = firstDayOfMonth?.lastDayOfMonth()
        var numberOfDays : Int? = firstDayOfMonth?.numDaysInMonth()
        numberOfDays == nil ? 0 : numberOfDays!

        return numberOfDays!
    }
    
    // Cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let firstDayOfMonth : NSDate? = startDate?.firstDayOfMonth().dateByAddingMonths(indexPath.section)
        let date: NSDate = dateForIndexPath(indexPath)
        var cell : HipCalendarDayCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("DayCell", forIndexPath: indexPath) as HipCalendarDayCollectionViewCell
        cell.date = date
        
        return cell
    }
    
    // Section
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
        if (kind == UICollectionElementKindSectionHeader) {
            let firstDayOfMonth: NSDate = dateForIndexPath(indexPath).firstDayOfMonth()
            var header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as HipCalendarCollectionReusableView
            header.firstDayOfMonth = firstDayOfMonth
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let date: NSDate = dateForIndexPath(indexPath)
        dates.append(date)
        
        if (delegate != nil) {
            delegate?.calendarView(self, didSelectDate: date)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let date: NSDate = dateForIndexPath(indexPath)
        let index: Int? = find(dates, date) as Int?
        if (index != nil) {
            dates.removeAtIndex(index!)
        }
        
        if (delegate != nil) {
            delegate?.calendarView(self, didDeselectDate: date)
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(collectionView.frame.width - padding * 2, 30)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return daySize
    }
    
}
