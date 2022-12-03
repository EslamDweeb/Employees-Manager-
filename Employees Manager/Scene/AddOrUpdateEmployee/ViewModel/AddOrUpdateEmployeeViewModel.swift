//
//  AddOrUpdateEmployeeViewModel.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

class AddOrUpdateEmployeeViewModel:ViewModel {
    
    var hasErrInTxt:PublishSubject<String> = .init()
    var isLoading:BehaviorRelay<Bool> = .init(value: false)
    
    
}
