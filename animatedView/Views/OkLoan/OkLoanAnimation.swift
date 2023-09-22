//
//  ViewController.swift
//  animatedView
//
//  Created by Agata on 06.09.2023.
//

import UIKit
import Lottie
import PanModal

class OkLoanAnimation: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView?
    
    
    //MARK: Outlets
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var simpleText: UILabel!
    @IBOutlet weak var okTimer: UIImageView!

    //MARK: Actions
    @IBAction func rateUsButton(_ sender: Any) {
        let rateUsPopUp = RateUsView()
        self.presentPanModal(rateUsPopUp)
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        okTimer.alpha = 0.0
        headerText.alpha = 0.0
        simpleText.alpha = 0.0
        confetti()
        animateOkAppearance()
    }
    
    //MARK: Functions
    func confetti() {
        let jsonName = "confetti-final"
        let animation = LottieAnimation.named(jsonName)
        
        let animationView = LottieAnimationView(animation: animation)
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 640)
        animationView.contentMode = .scaleToFill
        view.addSubview(animationView)
        animationView.play()
    }
    
    func animateOkAppearance() {
        let initialTimerOrigin = CGPoint(x: (view.frame.width - okTimer.frame.width) / 2, y: -okTimer.frame.height - 40)
        okTimer.frame.origin = initialTimerOrigin
        
        let initialHeaderTextOrigin = CGPoint(x: (view.frame.width - headerText.frame.width) / 2, y: -headerText.frame.height - 40)
        headerText.frame.origin = initialTimerOrigin
        
        let initialSimpleTextOrigin = CGPoint(x: (view.frame.width - simpleText.frame.width) / 2, y: -simpleText.frame.height - 40)
        simpleText.frame.origin = initialTimerOrigin
        
        UIView.animate(withDuration: 0.5, animations: {
            self.okTimer.alpha = 1.0
            self.okTimer.frame.origin.y += 40
            self.headerText.alpha = 1.0
            self.headerText.frame.origin.y += 40
            self.simpleText.alpha = 1.0
            self.simpleText.frame.origin.y += 40
        })
    }
}

