//
//  HipStickyHeaderFlowLayout.swift
//  Hipster-Calendar
//
//  Created by Annie Cheng on 5/2/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class HipStickyHeaderFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var answer: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElementsInRect(rect)! 
        let contentOffset = collectionView!.contentOffset
        let missingSections = NSMutableIndexSet()
        
        for layoutAttributes in answer {
            if (layoutAttributes.representedElementCategory == .Cell) {
                missingSections.addIndex(layoutAttributes.indexPath.section)
            }
        }
        
        for layoutAttributes in answer {
            if let representedElementKind = layoutAttributes.representedElementKind {
                if representedElementKind == UICollectionElementKindSectionHeader {
                    missingSections.removeIndex(layoutAttributes.indexPath.section)
                }
            }
        }
        
        missingSections.enumerateIndexesUsingBlock { idx, stop in
            let indexPath = NSIndexPath(forItem: 0, inSection: idx)
            if let layoutAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath) {
                answer.append(layoutAttributes)
            }
        }
        
        for layoutAttributes in answer {
            if let representedElementKind = layoutAttributes.representedElementKind {
                if representedElementKind == UICollectionElementKindSectionHeader {
                    let section = layoutAttributes.indexPath.section
                    let numberOfItemsInSection = collectionView!.numberOfItemsInSection(section)
                    
                    let firstCellIndexPath = NSIndexPath(forItem: 0, inSection: section)
                    let lastCellIndexPath = NSIndexPath(forItem: max(0, (numberOfItemsInSection - 1)), inSection: section)
                    
                    let (firstCellAttributes, lastCellAttributes): (UICollectionViewLayoutAttributes, UICollectionViewLayoutAttributes) = {
                        if (self.collectionView!.numberOfItemsInSection(section) > 0) {
                            return (
                                self.layoutAttributesForItemAtIndexPath(firstCellIndexPath)!,
                                self.layoutAttributesForItemAtIndexPath(lastCellIndexPath)!)
                        } else {
                            return (
                                self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: firstCellIndexPath)!,
                                self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionFooter, atIndexPath: lastCellIndexPath)!)
                        }
                        }()
                    
                    let headerHeight = CGRectGetHeight(layoutAttributes.frame)
                    var origin = layoutAttributes.frame.origin
                    
                    origin.y = min(max(contentOffset.y, (CGRectGetMinY(firstCellAttributes.frame) - headerHeight)), (CGRectGetMaxY(lastCellAttributes.frame) - headerHeight))
                    
                    layoutAttributes.zIndex = 1024
                    layoutAttributes.frame = CGRect(origin: origin, size: layoutAttributes.frame.size)
                }
            }
        }
        
        return answer
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
}
