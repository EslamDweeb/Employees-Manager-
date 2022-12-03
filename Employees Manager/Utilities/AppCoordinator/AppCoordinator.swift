//
//  AppCoordinator.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit

class AppCoordinator:Coordinator{
    let window:UIWindow
    
    lazy var main: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    
    lazy var employeeListVC: UIViewController = {
        return UINavigationController(rootViewController: EmpolyeeListVC.loadController())
    }()
    
    var navigationController:UINavigationController?{
       if let nav = employeeListVC as? UINavigationController {
           nav.navigationBar.isHidden = true
           return nav
       }else{
           return nil
       }
       //  let navigation = UINavigationController(rootViewController: splahScreen)
            
    }
    var rootViewController:UIViewController {
        return employeeListVC
    }
    
    init(window:UIWindow = UIWindow()) {
        self.window = window
        
    }
    
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
