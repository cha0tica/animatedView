//
//  LikeDislikeView.swift
//  animatedView
//
//  Created by Agata on 16.11.2023.
//

import Foundation
import UIKit
import PanModal

class LikeDislikeView : UIViewController, UITextViewDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var secondaryText: UILabel!
    @IBOutlet weak var likeStack: UIStackView!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var textReview: UITextView!
    @IBOutlet weak var rateAppstoreButton: UIButton!
    @IBOutlet weak var sendReviewButton: UIButton!
    @IBOutlet weak var noThanksButton: UIButton!
    @IBOutlet weak var overButton: UIButton!
    
    //MARK: Actions

    @IBAction func didTapDislike(_ sender: Any) {
        changeButton(for: dislikeButton)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dontLikeScreen()
        }
    }
    
    @IBAction func didTapLike(_ sender: Any) {
        changeButton(for: likeButton)
        likeButton.tintColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.didLike()
        }
    }
    
    @IBAction func sendReviewTapped(_ sender: Any) {
        thankForReview()
        //TODO: Отправили куда то отзыв
    }
    
    @IBAction func rateAppstoreTapped(_ sender: Any) {
        //TODO: Go Appstore
    }
    
    @IBAction func noThanksTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeThisTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func overButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Vars
    var hasLoaded = false
    private let placeholder = "Что можно улучшить?"
    
    var shortFormHeight: PanModalHeight {
        if hasLoaded {
            return .contentHeight(300)
        }
        return .maxHeight
    }
    
    enum MainText {
        case rateUs
        case notLike
        case didLike
        case thankYou
        
        var stringValue: String {
            switch self {
            case .rateUs:
                return "Оцените приложение"
            case .notLike:
                return "Спасибо за вашу оценку"
            case .didLike:
                return "Мы рады, что вам нравится!"
            case .thankYou:
                return "Спасибо за ваш отзыв!"
            }
        }
    }
    
    enum SecondaryText {
        case rateUs
        case notLike
        case didLike
        case thankYou
        
        var stringValue: String {
            switch self {
            case .rateUs:
                return "Мы усердно работаем чтобы сделать приложение удобным для вас, поэтому нам важно ваше мнение"
            case .notLike:
                return "Расскажите, что можно улучшить в приложении?"
            case .didLike:
                return "Пожалуйста, поделитесь своей оценкой с другими людьми в магазине приложений"
            case .thankYou:
                return "Спасибо за ваш отзыв, мы постараемся стать лучше"
            }
        }
    }
    
    
    //MARK: Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        hasLoaded = true
            panModalSetNeedsLayoutUpdate()
            panModalTransition(to: .shortForm)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        firstScreenSetup()
    }
    
    
    //MARK: Functions
    
    //Design
    private func gradientButton() {
        setupGradient(for: rateAppstoreButton)
    }
    
    private func setupGradient(for button: UIButton) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.61, blue: 0.29, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.47, blue: 0.08, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = button.bounds
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = button.bounds.height / 2
        button.clipsToBounds = true
    }
    
    private func buttonSetup(for button: UIButton) {
        button.layer.cornerRadius = 28
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray20.cgColor
    }
    
    private func changeButton(for button: UIButton) {
        button.backgroundColor = UIColor.brandOrange
        button.tintColor = .white
        button.layer.borderColor = UIColor.brandOrange.cgColor
    }
    private func setupTextField() {
        textReview.text = placeholder
        textReview.delegate = self
        textReview.textColor = .lightGray
        
        textReview.font = UIFont(name: "Rubik-Regular", size: 16)
        textReview.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        textReview.layer.cornerRadius = 16
        textReview.layer.borderWidth = 1
        textReview.layer.borderColor = UIColor(red: 0.894, green: 0.928, blue: 0.958, alpha: 1).cgColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == .black && textView.text != "" {
            sendReviewButton.isEnabled = true
            sendReviewButton.alpha = 1
       }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
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
    
    //ScreenSetup
    
    private func firstScreenSetup() {
        let mainTextCase: MainText = .rateUs
        mainText.text = mainTextCase.stringValue
        
        let secondaryTextCase: SecondaryText = .rateUs
        secondaryText.text = secondaryTextCase.stringValue
        
        textReview.isHidden = true
        sendReviewButton.isHidden = true
        rateAppstoreButton.isHidden = true
        noThanksButton.isHidden = true
        overButton.isHidden = true
        
        setupTextField()
        buttonSetup(for: dislikeButton)
        buttonSetup(for: likeButton)
    }
    
    private func dontLikeScreen() {
        let mainTextCase: MainText = .notLike
        mainText.text = mainTextCase.stringValue
        
        let secondaryTextCase: SecondaryText = .notLike
        secondaryText.text = secondaryTextCase.stringValue
        
        likeButton.isHidden = true
        dislikeButton.isHidden = true
        
        sendReviewButton.isEnabled = false
        sendReviewButton.alpha = 0.5
        
        textReview.isHidden = false
        sendReviewButton.isHidden = false
        setupGradient(for: sendReviewButton)
    }
    
    private func thankForReview() {
        let mainTextCase: MainText = .thankYou
        mainText.text = mainTextCase.stringValue
        
        let secondaryTextCase: SecondaryText = .thankYou
        secondaryText.text = secondaryTextCase.stringValue
        
        textReview.isHidden = true
        sendReviewButton.isHidden = true
        
        setupGradient(for: overButton)
        overButton.isHidden = false
    }
    
    private func didLike() {
        let mainTextCase: MainText = .didLike
        mainText.text = mainTextCase.stringValue
        
        let secondaryTextCase: SecondaryText = .didLike
        secondaryText.text = secondaryTextCase.stringValue
        
        likeButton.isHidden = true
        dislikeButton.isHidden = true
        
        setupGradient(for: rateAppstoreButton)
        rateAppstoreButton.isHidden = false
        noThanksButton.isHidden = false
        
        
    }
}

extension LikeDislikeView: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
}
