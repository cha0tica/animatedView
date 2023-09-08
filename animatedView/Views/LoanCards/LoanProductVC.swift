//
//  LoanProductVC.swift
//  animatedView
//
//  Created by Agata on 06.09.2023.
//

import Foundation
import UIKit

class LoanProductVC : UIViewController {
    
//MARK: outlets
    @IBOutlet weak var loanView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loanView.delegate = self
        loanView.dataSource = self
    }
    
    //MARK: Func
    
    
}

extension LoanProductVC : UICollectionViewDelegate {
    
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
        
        return cell
    }
    
    
}
