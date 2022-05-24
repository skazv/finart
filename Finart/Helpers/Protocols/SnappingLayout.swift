//
//  PageController.swift
//  Finart
//
//  Created by Suren Kazaryan on 17.04.2022.
//

import UIKit

class SnappingLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
        
        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
}




//class SnappingLayout: UICollectionViewFlowLayout {
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
//        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
//
//        let itemWidth = collectionView.frame.width - 16 //MagicNumber Magic Number
//        let itemSpace = itemWidth + minimumInteritemSpacing
//        var currentItemIdx = round(collectionView.contentOffset.x / itemSpace) //pageNumber
//
//        // Skip to the next cell, if there is residual scrolling velocity left.
//        // This helps to prevent glitches
//        let vX = velocity.x
//        if vX > 0 {
//          currentItemIdx += 1
//        } else if vX < 0 {
//          currentItemIdx -= 1
//        }
//
//        let nearestPageOffset = currentItemIdx * itemSpace
//        return CGPoint(x: nearestPageOffset,
//                       y: parent.y)
//      }
//
//}
