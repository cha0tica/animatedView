//
//  LoanCell.swift
//  animatedView
//
//  Created by Agata on 07.09.2023.
//

import UIKit

class LoanCell: UICollectionViewCell {

    //MARK: Outlets
    
    //GreenLine
    @IBOutlet weak var greenLine: UIView!
    @IBOutlet weak var greenLineText: UILabel!
    
    @IBOutlet weak var cardStack: UIStackView!
    
    //MainInfo
    @IBOutlet weak var loanName: UILabel!
    @IBOutlet weak var maxLoanSum: UILabel!
    @IBOutlet weak var percentTop: UILabel!
    @IBOutlet weak var daysTop: UILabel!
    
    //SumSelect
    @IBOutlet weak var sumSelect: UIStackView!
    @IBOutlet weak var selectedSum: UIStackView!
    @IBOutlet weak var minSum: UILabel!
    @IBOutlet weak var maxSum: UILabel!
    
    //TermSelect
    @IBOutlet weak var termSelect: UIStackView!
    @IBOutlet weak var selectedDays: UILabel!
    @IBOutlet weak var minDays: UILabel!
    @IBOutlet weak var maxDays: UILabel!
    
    //Percents
    @IBOutlet weak var percentInfo: UIStackView!
    @IBOutlet weak var percentSize: UILabel!
    @IBOutlet weak var dateofReturn: UILabel!
    
    //ScheduleInfo
    @IBOutlet weak var scheduleInfo: UIStackView!
    @IBOutlet weak var sumOfPayment: UILabel!
    @IBOutlet weak var paymentsCount: UILabel!
    
    @IBOutlet weak var selectLoan: UIButton!
    
    //MARK: LifeCycle
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientButton()
        updateUI()
        
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
    }
    
    func updateUI() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        
        greenLine.layer.cornerRadius = 16
        greenLine.clipsToBounds = true
        
        cardStack.layer.cornerRadius = 16
        cardStack.clipsToBounds = true
        
    }
    
    func gradientButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.61, blue: 0.29, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.47, blue: 0.08, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = selectLoan.bounds
        
        selectLoan.layer.insertSublayer(gradientLayer, at: 0)
        selectLoan.setTitleColor(UIColor.white, for: .normal)
        selectLoan.layer.cornerRadius = selectLoan.bounds.height / 2
        selectLoan.clipsToBounds = true
    }

}
