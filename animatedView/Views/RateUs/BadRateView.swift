//
//  GoodRateView.swift
//  animatedView
//
//  Created by Agata on 16.09.2023.
//

import UIKit
import SnapKit
import PanModal

class BadRateView : UIViewController, UITextViewDelegate, PanModalPresentable {
    var panScrollable: UIScrollView?
    
        
    //MARK: Actions
    @objc func closeBottomSheet() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didSubmit() {
        let ThankYouViewController = ThankYouForReviewView()
            let sheet = ThankYouViewController.sheetPresentationController
            sheet?.detents = [.medium()]
            present(ThankYouViewController, animated: true)
        
    }
    
    //MARK: Vars
    let placeholder = "Что можно улучшить?"
    
    let submitReview = UIButton()
    let popUp = UIView()

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        gradientButtom()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    //MARK: Functions
    func initialize() {
        view.backgroundColor = UIColor.clear
        
        popUp.backgroundColor = UIColor.white
        popUp.layer.cornerRadius = 20
        view.addSubview(popUp)
        popUp.snp.makeConstraints { maker in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            
            maker.height.equalTo(460)
        }
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "close-icon"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeBottomSheet), for: .touchUpInside)
        popUp.addSubview(closeButton)
        closeButton.snp.makeConstraints { maker in
            maker.top.equalTo(popUp).inset(24)
            maker.right.equalTo(popUp).inset(20)
            
            maker.height.equalTo(24)
            maker.width.equalTo(24)
        }
        
        let headerText = UILabel()
        headerText.textColor = UIColor(red: 0.152, green: 0.179, blue: 0.271, alpha: 1)
        headerText.font = UIFont(name: "Rubik-Regular", size: 20)
        headerText.textAlignment = .center
        headerText.text = "Спасибо за вашу оценку"
        popUp.addSubview(headerText)
        headerText.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(popUp).inset(48)
        }
        
        let mainText = UILabel()
        mainText.textColor = UIColor(red: 0.431, green: 0.443, blue: 0.569, alpha: 1)
        mainText.font = UIFont(name: "Rubik-Regular", size: 16)
        mainText.textAlignment = .center
        mainText.numberOfLines = 0
        mainText.text = "Расскажите, что можно улучшить в приложении?"
        popUp.addSubview(mainText)
        mainText.snp.makeConstraints { maker in
            maker.top.equalTo(headerText.snp.bottom).offset(8)
            maker.right.equalTo(popUp).inset(30)
            maker.left.equalTo(popUp).inset(30)
        }
        
        let reviewText = UITextView()
        reviewText.text = placeholder
        reviewText.delegate = self
        reviewText.textColor = .lightGray
        
        reviewText.font = UIFont(name: "Rubik-Regular", size: 16)
        reviewText.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        reviewText.layer.cornerRadius = 16
        reviewText.layer.borderWidth = 1
        reviewText.layer.borderColor = UIColor(red: 0.894, green: 0.928, blue: 0.958, alpha: 1).cgColor
        popUp.addSubview(reviewText)
        reviewText.snp.makeConstraints { maker in
            maker.top.equalTo(mainText.snp.bottom).offset(32)
            maker.centerX.equalToSuperview()
            
            maker.height.equalTo(124)
            maker.width.equalTo(300)
        }
        
        submitReview.addTarget(self, action: #selector(didSubmit), for: .touchUpInside)
        submitReview.setTitle("ОТПРАВИТЬ ОТЗЫВ", for: .normal)
        submitReview.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14)
        submitReview.setTitleColor(UIColor.white, for: .normal)
        submitReview.layer.cornerRadius = 35
        submitReview.clipsToBounds = true
        submitReview.backgroundColor = UIColor(named: "BrandOrange")
        
        submitReview.isEnabled = false
        submitReview.alpha = 0.5
        popUp.addSubview(submitReview)
        
        submitReview.snp.makeConstraints { maker in
            maker.top.equalTo(reviewText.snp.bottom).offset(32)
            maker.centerX.equalToSuperview()
            
            maker.height.equalTo(68)
            maker.width.equalTo(300)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == .black && textView.text != "" {
               submitReview.isEnabled = true
               submitReview.alpha = 1
       }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    func gradientButtom() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.61, blue: 0.29, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.47, blue: 0.08, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = submitReview.bounds
        
        submitReview.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }

        let keyboardHeight = keyboardFrame.height

        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = -keyboardHeight + 50
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }

        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = 0
        }
    }



}
