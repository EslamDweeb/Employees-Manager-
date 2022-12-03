//
//  UIViewController_EXt.swift
//

import UIKit

@available(iOS 13.0, *)
extension UIViewController {
    
    func createAlert(title: String? = nil,erroMessage: String,createButton:Bool? = true,completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title ?? "", message: erroMessage, preferredStyle: UIAlertController.Style.alert)
//        alert.setBackgroundColor(color: .darkGray)
//        alert.setMessage(font: nil, color: .white)
        if createButton == true{
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
                if let completion = completion {
                    completion()
                }else{
                    alert.dismiss(animated: true)
                }
            }
        alert.addAction(okButton)
        }
        self.present(alert, animated: true, completion: nil)
    }
        

    class func loadController() -> Self {
            let controller = Self(nibName: String(describing: self), bundle: nil)
             return controller
        }
    func presentInFullScreen(_ viewController: UIViewController,transition:UIModalTransitionStyle = .coverVertical,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = transition
        present(viewController, animated: animated, completion: completion)
    }
    func presentPopScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: animated, completion: completion)
    }
    func navigateToNewVC(_ VC:UIViewController){
        navigationController?.pushViewController(VC, animated: true)
    }
    func PopToOldPage(){
        navigationController?.popViewController(animated: true)
    }
    func cleanNavStackWithNewVC(_ VC:UIViewController){
        navigationController?.setViewControllers([VC], animated: true)
    }
    func getError (error : [String : [String]]) -> String {
        var   text = ""
        for (_,v) in error {
            for i in v {
                text += " \(i) "
            }
        }
        return text
    }
    
//    func startActivityIndicator(){
//        ProgressHUD.animationType = .systemActivityIndicator
//        ProgressHUD.colorHUD = .purpleColor2
//        ProgressHUD.colorBackground = .lightGray
//        ProgressHUD.colorAnimation = .darkGray
//        ProgressHUD.colorProgress = .darkGray
//        ProgressHUD.colorStatus = .systemGray
//        ProgressHUD.show()
//    }
//    @available(iOS 13.0, *)
//    func stopActivityIndicator(){
//        ProgressHUD.dismiss()
//    }
    
}
