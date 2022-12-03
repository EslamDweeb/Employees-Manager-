//
//  MainNavigator.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit


class MainNavigator:Navigator{
    var coordinator: Coordinator
    
    enum Destination {
        case empolyeeList
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination{
        case .empolyeeList:
            let viewModel  = EmployeesListVCViewModel()
            return LoginViewController(viewModel:viewModel,coordinator: coordinator)
        }
    }
}
