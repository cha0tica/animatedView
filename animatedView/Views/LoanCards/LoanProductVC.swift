//
//  LoanProductVC.swift
//  animatedView
//
//  Created by Agata on 06.09.2023.
//

import Foundation
import UIKit

class LoanProductVC : UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var loanView: UICollectionView!
    @IBOutlet weak var scrollIndicator: UIPageControl!
   
    //MARK: Actions
    
    //MARK: Vars
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loanView.delegate = self
        loanView.dataSource = self
        
        let customFlowLayout = LoanProductFlowLayout()
        loanView.collectionViewLayout = customFlowLayout
        scrollerSetup()
        cellsSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loanView.scrollToItem(at: IndexPath(item: loanProducts.count/2, section: 0), at: .centeredHorizontally, animated: true)
        scrollIndicator.currentPage = loanProducts.count/2
    }
    
    //MARK: Func
    func scrollerSetup() {
        if loanProducts.count > 1 {
            scrollIndicator.numberOfPages = loanProducts.count
        } else {
            scrollIndicator.isHidden = true
        }

    }
    
    func cellsSettings() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * 0.9)
        let cellHeight = floor(screenSize.height * 0.6)
        let insertX = (view.bounds.width - cellWidth) / 2.0
        let insertY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = loanView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        loanView.contentInset = UIEdgeInsets(top: insertY, left: insertX, bottom: insertY, right: insertX)
        layout.minimumLineSpacing = -(layout.itemSize.width * 0.5)
    }
}

extension LoanProductVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loanProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: "LoanCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "LoanCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoanCell", for: indexPath) as! LoanCell
        
        let loanProductModel = loanProducts[indexPath.item]
        cell.configure(with: loanProductModel)
        
        return cell
    }
}

extension LoanProductVC : UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.loanView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthWithSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthWithSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
        scrollIndicator.currentPage = Int(roundedIndex)
    }
}
