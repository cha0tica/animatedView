//
//  RatingPopUp.swift
//  animatedView
//
//  Created by Agata on 23.09.2023.
//

import Foundation
import UIKit
import PanModal
import SnapKit

class RatingPopUp : UIViewController,UITextViewDelegate, PanModalPresentable {
    var panScrollable: UIScrollView?
    
    //MARK: Элементы View
    private let popUpFrame = UIView() //фрейм поп-апа
    private let closeButton = UIButton() //кнопка крестик
    private let headerText = UILabel() //текст заголовка
    private let mainText = UILabel() //обычный текст
    private let starsContainer = UIStackView() //стак для звезд
    private let reviewText = UITextView() //текстовое поле
    private let orangeButton = UIButton() //универсальная оранжевая кнопка
    private var image = UIImage() //картинка с таймером
    private var timerImage = UIImageView() //вью картинки с таймером
    private let noThanks = UIButton() //кнопка "нет, спасибо"
    
    
    //MARK: Actions
    //Закрываем окошко
    @objc func closeBottomSheet() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Выбираем звезды
    @objc func starButtonTapped(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starsContainer)
        let starWidth = starsContainer.bounds.width / 5
        let rate = Int(location.x / starWidth) + 1
        
        if rate != self.selectedRate {
            feedbackGenerator.selectionChanged()
            self.selectedRate = rate
        }
        
        starsContainer.arrangedSubviews.forEach { subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            starImageView.isHighlighted = starImageView.tag <= rate
            
            if starImageView.tag == rate {
                starImageView.addPulsationAnimation()
            }
        }
        
        if rate >= 1 && rate <= 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.addReview()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.fiveStars()
            }
        }
    }
    
    @objc func letsGoAppstore() {
        //TODO
    }
    
    @objc func didSubmit() {
        self.thankYou()
    }
    
    //MARK: Vars
    var selectedRate : Int = 0
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    let placeholder = "Что можно улучшить?"
    
    //Constraits to update
    var heightOfPopUpConstraint: Constraint?
    var headerTextTopConstraint: Constraint?
    var orangeButtonConstraunds: Constraint?
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rootWindow()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Functions - настройки элементов
    
    private func rootWindow() {
        standartSettings()

        view.addSubview(popUpFrame)
        popUpFrame.snp.makeConstraints { maker in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            heightOfPopUpConstraint = maker.height.equalTo(300).constraint
        }
        
        popUpFrame.addSubview(closeButton)
        closeButton.snp.makeConstraints { maker in
            maker.top.equalTo(popUpFrame).inset(24)
            maker.right.equalTo(popUpFrame).inset(20)
            
            maker.height.equalTo(24)
            maker.width.equalTo(24)
        }
        
        headerText.text = "Оцените приложение"
        popUpFrame.addSubview(headerText)
        headerText.snp.makeConstraints { maker in
            maker.centerX.equalTo(popUpFrame)
            headerTextTopConstraint = maker.top.equalTo(popUpFrame).inset(48).constraint
        }
        
        
        mainText.text = "Мы усердно работаем чтобы сделать приложение удобным для вас, поэтому нам важно ваше мнение"
        popUpFrame.addSubview(mainText)
        mainText.snp.makeConstraints { maker in
            maker.top.equalTo(headerText.snp.bottom).offset(8)
            maker.right.equalTo(popUpFrame).inset(30)
            maker.left.equalTo(popUpFrame).inset(30)
        }
        
        popUpFrame.addSubview(starsContainer)
        starsContainer.snp.makeConstraints { maker in
            maker.top.equalTo(mainText.snp.bottom).offset(32)
            maker.centerX.equalTo(popUpFrame)
        }
        
        createStars()
    }
    
    private func addReview() {
        starsContainer.isHidden = true //спрятали звезды
        
        heightOfPopUpConstraint?.update(offset: 460)
        
        headerText.text = "Спасибо за вашу оценку"
        popUpFrame.addSubview(headerText)
        
        mainText.text = "Расскажите, что можно улучшить в приложении?"
        popUpFrame.addSubview(mainText)
        
        popUpFrame.addSubview(reviewText) //добавили текствью
        reviewText.snp.makeConstraints { maker in
            maker.top.equalTo(mainText.snp.bottom).offset(32)
            maker.centerX.equalTo(popUpFrame)
            maker.height.equalTo(124)
            maker.width.equalTo(300)
        }
        
        popUpFrame.addSubview(orangeButton) //добавили кнопку отправки отзыва
        orangeButton.setTitle("ОТПРАВИТЬ ОТЗЫВ", for: .normal)
        orangeButton.addTarget(self, action: #selector(didSubmit), for: .touchUpInside)
        orangeButton.isEnabled = false
        orangeButton.alpha = 0.5
        orangeButton.snp.makeConstraints { maker in
            maker.centerX.equalTo(popUpFrame)
            orangeButtonConstraunds = maker.top.equalTo(reviewText.snp.bottom).offset(32).constraint
        }
        
        self.view.layoutIfNeeded()
        
    }
    
    private func thankYou() {
        starsContainer.isHidden = true //спрятали звезды
        reviewText.isHidden = true
                
        view.addSubview(popUpFrame)
        heightOfPopUpConstraint?.update(offset: 460)
        
        popUpFrame.addSubview(timerImage)
        timerImage.snp.makeConstraints { maker in
            maker.top.equalTo(popUpFrame).inset(40)
            maker.centerX.equalTo(popUpFrame)
        }
        
        headerText.text = "Спасибо за ваш отзыв!"
        popUpFrame.addSubview(headerText)
        headerTextTopConstraint?.update(offset: 212)
        
        mainText.text = "Спасибо за ваш отзыв, мы постараемся стать лучше"
        popUpFrame.addSubview(mainText)
        
        popUpFrame.addSubview(orangeButton)
        orangeButton.setTitle("ЗАВЕРШИТЬ", for: .normal)
        orangeButton.addTarget(self, action: #selector(closeBottomSheet), for: .touchUpInside)
        orangeButton.snp.makeConstraints { maker in
            maker.centerX.equalTo(popUpFrame)
            orangeButtonConstraunds?.deactivate()
            maker.top.equalTo(mainText.snp.bottom).offset(32)
        }
    }
    
    private func fiveStars() {
        starsContainer.isHidden = true //спрятали звезды

        popUpFrame.addSubview(timerImage)
        heightOfPopUpConstraint?.update(offset: 500)
        
        timerImage.snp.makeConstraints { maker in
            maker.top.equalTo(popUpFrame).inset(40)
            maker.centerX.equalTo(popUpFrame)
        }
        
        headerText.text = "Мы рады, что вам нравится!"
        popUpFrame.addSubview(headerText)
        headerTextTopConstraint?.update(offset: 212)
        
        mainText.text = "Пожалуйста, поделитесь своей оценкой с другими людьми в магазине приложений"
        popUpFrame.addSubview(mainText)
                
        popUpFrame.addSubview(orangeButton)
        orangeButton.addTarget(self, action: #selector(letsGoAppstore), for: .touchUpInside)
        orangeButton.setTitle("ОЦЕНИТЬ В APPSTORE", for: .normal)
        orangeButton.snp.makeConstraints { maker in
            maker.centerX.equalTo(popUpFrame)
            maker.top.equalTo(mainText.snp.bottom).offset(32)
        }
        
        popUpFrame.addSubview(noThanks)
        noThanks.snp.makeConstraints { maker in
            maker.top.equalTo(orangeButton.snp.bottom).offset(12)
            maker.centerX.equalTo(popUpFrame)
        }
    }
    
    private func standartSettings() {
        view.backgroundColor = UIColor.clear
        
        //Настройки фрейма для поп-апа
        popUpFrame.backgroundColor = UIColor.white
        popUpFrame.layer.cornerRadius = 20
        
        //Настройка кнопки закрытия окошка
        closeButton.setImage(UIImage(named: "close-icon"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeBottomSheet), for: .touchUpInside)
        
        
        //Настройка для заголовка
        headerText.textColor = UIColor(red: 0.152, green: 0.179, blue: 0.271, alpha: 1)
        headerText.font = UIFont(name: "Rubik-Regular", size: 20)
        headerText.textAlignment = .center
        headerText.text = ""
        
        
        //Настройки для текста
        mainText.textColor = UIColor(red: 0.431, green: 0.443, blue: 0.569, alpha: 1)
        mainText.font = UIFont(name: "Rubik-Regular", size: 16)
        mainText.textAlignment = .center
        mainText.numberOfLines = 0
        mainText.text = ""
        
        //Стак со звездами
        starsContainer.axis = .horizontal
        starsContainer.spacing = 17
        starsContainer.alignment = .center
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //Текст ревью
        reviewText.text = placeholder
        reviewText.delegate = self
        reviewText.textColor = .lightGray
        
        reviewText.font = UIFont(name: "Rubik-Regular", size: 16)
        reviewText.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        reviewText.layer.cornerRadius = 16
        reviewText.layer.borderWidth = 1
        reviewText.layer.borderColor = UIColor(red: 0.894, green: 0.928, blue: 0.958, alpha: 1).cgColor
        
        //Универсальная оранжевая кнопка
        orangeButton.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14)
        orangeButton.setTitleColor(UIColor.white, for: .normal)
        orangeButton.layer.cornerRadius = 35
        orangeButton.clipsToBounds = true
        orangeButton.backgroundColor = UIColor(named: "BrandOrange")
        
        //Градиент для кнопки

        
        orangeButton.snp.makeConstraints { maker in
            maker.height.equalTo(68)
            maker.width.equalTo(300)
        }
        
        //Картинка с таймером
        image = UIImage(named: "ok-timer")!
        timerImage = UIImageView(image: image)
        timerImage.snp.makeConstraints { maker in
            maker.height.equalTo(148)
            maker.width.equalTo(148)
        }
        
        //Мини кнопка "нет, спасибо"
        noThanks.addTarget(self, action: #selector(closeBottomSheet), for: .touchUpInside)
        noThanks.setTitle("НЕТ, СПАСИБО", for: .normal)
        noThanks.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 14)
        noThanks.setTitleColor(UIColor(red: 0.431, green: 0.443, blue: 0.569, alpha: 1), for: .normal)
        noThanks.layer.cornerRadius = 35
        noThanks.clipsToBounds = true
        noThanks.backgroundColor = .white
        
        noThanks.snp.makeConstraints { maker in
            maker.height.equalTo(34)
            maker.width.equalTo(300)
        }
    }
    
    func orangeGradientForButton() {
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor(red: 1, green: 0.61, blue: 0.29, alpha: 1).cgColor,
                UIColor(red: 0.96, green: 0.47, blue: 0.08, alpha: 1).cgColor
            ]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = orangeButton.bounds
            
            orangeButton.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: Functions
    
    //Работа со звездами
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "star"), highlightedImage: UIImage(named: "star-fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    private func createStars() {
        for index in 1...5 {
            let star = makeStarIcon()
            star.tag = index
            star.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starButtonTapped(gesture:)))
            star.addGestureRecognizer(tapGesture)
            starsContainer.addArrangedSubview(star)
        }
    }
    
    //Работа с текствью
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == .black && textView.text != "" {
            orangeButton.isEnabled = true
            orangeButton.alpha = 1
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    //Работа с клавиатурой
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

extension UIImageView {
    func addPulsationAnimation() {
        print("Adding pulsation animation")
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.2
        scaleAnimation.fromValue = 0.8
        scaleAnimation.toValue = 1
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        scaleAnimation.repeatCount = 1
        self.layer.add(scaleAnimation, forKey: nil)
    }
}
