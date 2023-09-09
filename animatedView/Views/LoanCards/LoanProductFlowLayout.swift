//
//  LoanProductFlowLayout.swift
//  animatedView
//
//  Created by Agata on 09.09.2023.
//

import UIKit

class LoanProductFlowLayout: UICollectionViewFlowLayout {
    //MARK: Vars
    let standartItemAlpha : CGFloat = 0.5
    let standartItemScale : CGFloat = 0.8
    
    //MARK: Functions
    override func prepare() {
        super.prepare()
        self.scrollDirection = .horizontal
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAttributes(itemAttributesCopy)
            attributesCopy.append(itemAttributesCopy)
        }
        return attributesCopy
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        let collectionCenter = collectionView!.frame.size.width / 2  // Изменено на ширину
        let offset = collectionView!.contentOffset.x  // Изменено на горизонтальный сдвиг
        let normalizedCenter = attributes.center.x - offset  // Изменено на горизонтальный сдвиг
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing  // Изменено на ширину
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        let alpha = ratio * (1 - self.standartItemAlpha) + self.standartItemAlpha
        let scale = ratio * (1 - self.standartItemScale) + self.standartItemScale
        
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)
    }

}
