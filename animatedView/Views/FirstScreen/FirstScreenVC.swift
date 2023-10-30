//
//  FirstScreenVC.swift
//  animatedView
//
//  Created by Agata on 21.10.2023.
//

import Foundation
import UIKit
import LocalAuthentication

class FirstScreenViewController : UIViewController {
   
    var okLoanAnimation : OkLoanAnimation?
    let segueID = "ShowApp"
    let targetVC = "Ok"
    
    @IBAction func faceIdButtonTapped(_ sender: Any) {
        faceIDTrigger()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceIDTrigger()
    }
    
    func faceIDTrigger() {
        let context = LAContext()
        var error : NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Разрешите, пожалуйста, доступ"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async { [self] in
                    guard success, error == nil else {
                        showAlert(title: "Ошибка", message: "Поробуйте снова или введите пин-код")
                        return
                    }
                    showVC()
                }
            }
        } else {
            if let error {
                showAlert(title: "Что-то пошло не так", message: "\(error.localizedDescription)")
            }
        }
    }
    
    //show VC...
    func showVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let okLoanAnimation = storyboard.instantiateViewController(withIdentifier: targetVC) as? OkLoanAnimation {
            okLoanAnimation.modalPresentationStyle = .fullScreen
            self.present(okLoanAnimation, animated: true, completion: nil)
        }
    }
}

//alert...
extension FirstScreenViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(dismiss)
        present(alert, animated: true)
    }
}


