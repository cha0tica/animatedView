//
//  GoUpdate.swift
//  animatedView
//
//  Created by Agata on 10.09.2023.
//

import Foundation
import UIKit

class GoUpdate : UIViewController {
    
    @IBOutlet weak var refreshImage: UIImageView!
    @IBOutlet weak var goUpdate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientButton()
        startRotationAnimation()
    }
    
    private func gradientButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.61, blue: 0.29, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.47, blue: 0.08, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = goUpdate.bounds
        
        goUpdate.layer.insertSublayer(gradientLayer, at: 0)
        goUpdate.setTitleColor(UIColor.white, for: .normal)
        goUpdate.layer.cornerRadius = goUpdate.bounds.height / 2
        goUpdate.clipsToBounds = true
    }
    
    func startRotationAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: -Double.pi * 2)
        rotationAnimation.duration = 5.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
        refreshImage.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopRotationAnimation() {
        refreshImage.layer.removeAnimation(forKey: "rotationAnimation")
    }
}
