//
//  EmployeesListVCViewModel.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol EmployeesListVCViewModelInputs{
    func viewDidLod()
}
protocol EmployeesListVCViewModelOutputs{
    var employeesArr:BehaviorRelay<[Employee]> {get set}
}
class EmployeesListVCViewModel:ViewModel,EmployeesListVCViewModelInputs,EmployeesListVCViewModelOutputs{
    
    var hasErrInTxt:PublishSubject<String> = .init()
    var isLoading:BehaviorRelay<Bool> = .init(value: false)
    var employeesArr:BehaviorRelay<[Employee]> = .init(value: [])
    
    private var localDB = EmployeeLDB()
    
    func viewDidLod() {
        getAllEmplyee()
    }
    private func getAllEmplyee(){
        isLoading.accept(true)
        
        localDB.getEmployees {[weak self] employees, error in
            guard let self else{return}
            self.isLoading.accept(false)
            if let employees {
                self.employeesArr.accept(employees)
            }
            if let error {
                self.hasErrInTxt.onNext(error.localizedDescription)
            }
        }
    }
    func deleteEmployee(_ index:Int) {
        isLoading.accept(true)
        let employee = employeesArr.value[index]
        localDB.deleteContact(eid: employee.id){[weak self] sucess, error in
            guard let self else{return}
            self.isLoading.accept(false)
            if let _ = sucess {
                self.deleteFromEmployeeArr(index: index)
            }
            if let error {
                self.hasErrInTxt.onNext(error.localizedDescription)
            }
        }
    }
    private func deleteFromEmployeeArr(index:Int){
        var arr = employeesArr.value
        arr.remove(at: index)
        self.employeesArr.accept(arr)
    }
}
