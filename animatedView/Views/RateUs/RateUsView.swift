//
//  RateUsView.swift
//  animatedView
//
//  Created by Agata on 15.09.2023.
//

import UIKit
import SnapKit

class RateUsView: UIViewController {
    
    //MARK: Actions
    @objc func closeBottomSheet() {
        self.dismiss(animated: true, completion: nil)
    }
    
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
            let badRateViewController = BadRateView()
                let sheet = badRateViewController.sheetPresentationController
                sheet?.detents = [.medium()]
                present(badRateViewController, animated: true)
                        } else {
                let fiveStarsViewController = FiveStarsView()
                            let sheet = fiveStarsViewController.sheetPresentationController
                            sheet?.detents = [.medium()]
                            present(fiveStarsViewController, animated: true)
            }
        
    }
    
    //MARK: Vars
    var starButtons: [UIButton] = []
    var selectedRate : Int = 0
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    private let starsContainer = UIStackView()
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Functions
    
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "star"), highlightedImage: UIImage(named: "star-fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    func initialize() {
        view.backgroundColor = UIColor.clear
        
        let popUp = UIView()
        popUp.backgroundColor = UIColor.white
        popUp.layer.cornerRadius = 20
        view.addSubview(popUp)
        popUp.snp.makeConstraints { maker in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            
            maker.height.equalTo(300)
        }
        
        let dragger = UIView()
        dragger.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        dragger.layer.cornerRadius = 2
        view.addSubview(dragger)
        dragger.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(popUp.snp.top).inset(-8)
            
            maker.height.equalTo(4)
            maker.width.equalTo(44)
        }
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "close-icon"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeBottomSheet), for: .touchUpInside)
        view.addSubview(closeButton)
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
        headerText.text = "Оцените приложение"
        view.addSubview(headerText)
        headerText.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(popUp).inset(48)
        }
        
        let mainText = UILabel()
        mainText.textColor = UIColor(red: 0.431, green: 0.443, blue: 0.569, alpha: 1)
        mainText.font = UIFont(name: "Rubik-Regular", size: 16)
        mainText.textAlignment = .center
        mainText.numberOfLines = 0
        mainText.text = "Мы усердно работаем чтобы сделать приложение удобным для вас, поэтому нам важно ваше мнение"
        view.addSubview(mainText)
        mainText.snp.makeConstraints { maker in
            maker.top.equalTo(headerText.snp.bottom).offset(8)
            maker.right.equalTo(popUp).inset(30)
            maker.left.equalTo(popUp).inset(30)
        }
        
        starsContainer.axis = .horizontal
        starsContainer.spacing = 17
        starsContainer.alignment = .center
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starsContainer)
        starsContainer.snp.makeConstraints { maker in
            maker.top.equalTo(mainText.snp.bottom).offset(32)
            maker.centerX.equalToSuperview()
        }
        
        createStars()
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
    
    func showBadRateView() {
        let badRateView = BadRateView()
        badRateView.modalPresentationStyle = .overFullScreen
        self.present(badRateView, animated: true, completion: nil)
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
