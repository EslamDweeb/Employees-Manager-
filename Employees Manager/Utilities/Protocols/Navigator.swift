//
//  Navigator.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit

enum NavigatorTypes{
    
    case push
    case presentfullScreen
    case presentFullScreenWithModelTrans
    case root
    case pop
    case popup
}

protocol Navigator {
    associatedtype Destination
    var coordinator:Coordinator { get }
    init(coordinator:Coordinator)
    func viewController(for destination: Destination) -> UIViewController
    func navigate(to destination: Destination,with navigatorType:NavigatorTypes)
}
extension Navigator{
    func navigate(to destination: Destination,with navigatorType:NavigatorTypes = .push){
        let viewController = self.viewController(for: destination)
        
        switch navigatorType {
        case .push:
            coordinator.navigationController?.pushViewController(viewController, animated: true)
        case .presentfullScreen:
            if #available(iOS 13.0, *) {
                coordinator.navigationController?.presentInFullScreen(viewController, animated: true)
            } else {
                coordinator.navigationController?.present(viewController, animated: true)
            }
        case.presentFullScreenWithModelTrans:
            if #available(iOS 13.0, *) {
                coordinator.navigationController?.presentInFullScreen(viewController,transition: .crossDissolve, animated: true)
            } else {
                coordinator.navigationController?.present(viewController, animated: true)
            }
        case .root:
            coordinator.navigationController?.setViewControllers([viewController], animated: true)
        case .pop :
            coordinator.navigationController?.popViewController(animated: true)
        case.popup:
            coordinator.navigationController?.presentPopScreen(viewController, animated: true)
        }
    }
}
