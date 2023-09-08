//
//  CarouselFlowLayout.swift
//  animatedView
//
//  Created by Agata on 09.09.2023.
//

import Foundation
import UIKit

class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        collectionView?.isPagingEnabled = true
        collectionView?.contentOffset.x = -sectionInset.left
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let pageWidth = itemSize.width + minimumLineSpacing
        let approximatePage = collectionView!.contentOffset.x / pageWidth
        let currentPage = (proposedContentOffset.x > collectionView!.contentOffset.x) ? floor(approximatePage) : ceil(approximatePage)
        let newOffset = currentPage * pageWidth - sectionInset.left
        return CGPoint(x: newOffset, y: proposedContentOffset.y)
    }
}
