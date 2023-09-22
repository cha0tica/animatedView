//
//  FiveStarsView.swift
//  animatedView
//
//  Created by Agata on 18.09.2023.
//

import Foundation
import UIKit
import SnapKit
import PanModal

class FiveStarsView : UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView?
    
    
    //MARK: Actions
    @objc func endThis() {
        let rootViewController = UIApplication.shared.connectedScenes
                .filter {$0.activationState == .foregroundActive }
                .map {$0 as? UIWindowScene }
                .compactMap { $0 }
                .first?.windows
                .filter({ $0.isKeyWindow }).first?.rootViewController
            
            rootViewController?.dismiss(animated: true) {
            }
    }
    
    @objc func letsGoAppstore() {
        //TODO
    }
    
    //MARK: Vars
    let goAppStore = UIButton()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        gradientButtom()
    }
    
    //MARK: Functions
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
            
            maker.height.equalTo(460)
        }
        
        let image = UIImage(named: "ok-timer")
        let timerImage = UIImageView(image: image)
        view.addSubview(timerImage)
        timerImage.snp.makeConstraints { maker in
            maker.top.equalTo(popUp).inset(40)
            maker.centerX.equalToSuperview()
            
            maker.height.equalTo(148)
            maker.width.equalTo(148)
        }
        
        let headerText = UILabel()
        headerText.textColor = UIColor(red: 0.152, green: 0.179, blue: 0.271, alpha: 1)
        headerText.font = UIFont(name: "Rubik-Regular", size: 20)
        headerText.textAlignment = .center
        headerText.text = "Мы рады, что вам нравится!"
        view.addSubview(headerText)
        headerText.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(timerImage.snp.bottom).offset(24)
        }
        
        let mainText = UILabel()
        mainText.textColor = UIColor(red: 0.431, green: 0.443, blue: 0.569, alpha: 1)
        mainText.font = UIFont(name: "Rubik-Regular", size: 16)
        mainText.textAlignment = .center
        mainText.numberOfLines = 0
        mainText.text = "Пожалуйста, поделитесь своей оценкой с другими людьми в магазине приложений"
        view.addSubview(mainText)
        mainText.snp.makeConstraints { maker in
            maker.top.equalTo(headerText.snp.bottom).offset(8)
            maker.right.equalTo(popUp).inset(30)
            maker.left.equalTo(popUp).inset(30)
        }
        
        goAppStore.addTarget(self, action: #selector(letsGoAppstore), for: .touchUpInside)
        goAppStore.setTitle("ОЦЕНИТЬ В APPSTORE", for: .normal)
        goAppStore.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14)
        goAppStore.setTitleColor(UIColor.white, for: .normal)
        goAppStore.layer.cornerRadius = 35
        goAppStore.clipsToBounds = true
        goAppStore.backgroundColor = UIColor(named: "BrandOrange")
        view.addSubview(goAppStore)
        
        goAppStore.snp.makeConstraints { maker in
            maker.top.equalTo(mainText.snp.bottom).offset(32)
            maker.centerX.equalToSuperview()
            
            maker.height.equalTo(68)
            maker.width.equalTo(300)
        }
        
        let noThanks = UIButton()
        noThanks.addTarget(self, action: #selector(endThis), for: .touchUpInside)
        noThanks.setTitle("НЕТ, СПАСИБО", for: .normal)
        noThanks.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 14)
        noThanks.setTitleColor(UIColor(red: 0.431, green: 0.443, blue: 0.569, alpha: 1), for: .normal)
        noThanks.layer.cornerRadius = 35
        noThanks.clipsToBounds = true
        noThanks.backgroundColor = .white
        view.addSubview(noThanks)
        
        noThanks.snp.makeConstraints { maker in
            maker.top.equalTo(goAppStore.snp.bottom).offset(12)
            maker.centerX.equalToSuperview()
            
            maker.height.equalTo(34)
            maker.width.equalTo(300)
        }
    }
    
    func gradientButtom() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.61, blue: 0.29, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.47, blue: 0.08, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = goAppStore.bounds
        
        goAppStore.layer.insertSublayer(gradientLayer, at: 0)
    }
}
    
