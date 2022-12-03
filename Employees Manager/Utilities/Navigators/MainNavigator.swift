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
        case createOrUpdateEmployee(createEmployee:Bool,employee:Employee?)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination{
        case .createOrUpdateEmployee(let createEmployee,let employee):
            let viewModel  = AddOrUpdateEmployeeViewModel(createNewEmployee: createEmployee, employee: employee)
            return AddOrUpdateEmployeeVC(viewModel: viewModel, coordinator: coordinator)
        }
    }
}
