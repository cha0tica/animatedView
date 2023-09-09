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
    
    //SumOfLoanSelect
    @IBOutlet weak var sumSelect: UIStackView!
    @IBOutlet weak var sumSlider: UISlider!
    @IBOutlet weak var userSelectSum: UILabel!
    @IBOutlet weak var selectedSum: UIStackView!
    @IBOutlet weak var minSum: UILabel!
    @IBOutlet weak var maxSum: UILabel!
    
    //DaysForReturnSelect
    @IBOutlet weak var termSelect: UIStackView!
    @IBOutlet weak var daysSlider: UISlider!
    @IBOutlet weak var selectedDays: UILabel!
    @IBOutlet weak var minDays: UILabel!
    @IBOutlet weak var maxDays: UILabel!
    
    //PercentsInfo
    @IBOutlet weak var percentInfo: UIStackView!
    @IBOutlet weak var percentSize: UILabel!
    @IBOutlet weak var dateofReturn: UILabel!
    
    //ScheduleInfo
    @IBOutlet weak var scheduleInfo: UIStackView!
    @IBOutlet weak var sumOfPayment: UILabel!
    @IBOutlet weak var paymentsCount: UILabel!
    
    @IBOutlet weak var selectLoan: UIButton!
    
    //MARK: Actions
    @IBAction func sumSliderDragged(_ sender: Any) {
        userSelectSum.text = ("\(Int(sumSlider.value))  ₽")
    }
    
    @IBAction func daysSliderDragged(_ sender: Any) {
        selectedDays.text = ("\(Int(daysSlider.value))  д.")
    }
    
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
    
    //MARK: functions
    
    func configure(with model: NewLoanProductModel) {
        if let greenLineText = model.greenLineText {
            greenLine.isHidden = false
            self.greenLineText.text = model.greenLineText
        } else {
            greenLine.isHidden = true
        }
        
        //MustHave
        loanName.text = model.loanName
        maxLoanSum.text = "\(model.maxLoanSum) ₽"
        percentTop.text = "\(model.percentTop)% в день"
        daysTop.text = "\(model.daysTopMenu) д."
        
        //SumOfLoanSelect
        maxSum.text = "\(model.maxLoanSum) ₽"
        sumSlider.minimumValue = 1000
        sumSlider.maximumValue = Float(model.maxLoanSum)
        sumSlider.value = Float(model.maxLoanSum)
        userSelectSum.text = "\(model.maxLoanSum) ₽"
        
        if let selectedDays = model.selectedDays {
            termSelect.isHidden = false
            self.daysSlider.minimumValue = 1
            self.daysSlider.maximumValue = Float(model.daysTopMenu)
            self.daysSlider.value = Float(model.daysTopMenu)
            self.maxDays.text = "\(model.daysTopMenu) д."
            self.selectedDays.text = "\(model.daysTopMenu) д."
        } else {
            termSelect.isHidden = true
        }
        
        //DaysForReturnSelect
        if let dateofReturn = model.dateofReturn, let percentSize = model.percentSize {
            percentInfo.isHidden = false
            self.percentSize.text = ("\(percentSize) ₽")
            self.dateofReturn.text = dateofReturn
        } else {
            percentInfo.isHidden = true
        }
        
        if let sumOfPayment = model.sumOfPayment, let paymentsCount = model.paymentsCount {
            scheduleInfo.isHidden = false
            self.sumOfPayment.text = "\(sumOfPayment)"
            self.paymentsCount.text = "\(paymentsCount)"
        } else {
            scheduleInfo.isHidden = true
        }
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
