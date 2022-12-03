//
//  Coordinator.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit

protocol Coordinator {
    var main: MainNavigator { get }
    var navigationController:UINavigationController? { get }
}
