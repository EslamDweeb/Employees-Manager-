//
//  AddOrUpdateEmployeeViewModel.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AddOrUpdateEmployeeViewModelInputs{
    func createOreUpdateEmployee()
    var imageData:BehaviorRelay<Data?>{get set}
    var email:BehaviorRelay<String?> {get set}
    var imagePath:BehaviorRelay<String?> {get set}
    var fullName:BehaviorRelay<String> {get set}
    var createNewEmployee:BehaviorRelay<Bool> {get set}
    var employeeToUpdate:BehaviorRelay<Employee?>{get set}
}
protocol AddOrUpdateEmployeeViewModelOutputs{
    var createdEmployeeSucess:PublishSubject<String>{get set}
}
class AddOrUpdateEmployeeViewModel:ViewModel,AddOrUpdateEmployeeViewModelInputs,AddOrUpdateEmployeeViewModelOutputs {
    
    private var localDB = EmployeeLDB()
    var employeeToUpdate:BehaviorRelay<Employee?> = .init(value: nil)
    var createNewEmployee:BehaviorRelay<Bool> = .init(value: true)
    var createdEmployeeSucess:PublishSubject<String> = .init()
    var hasErrInTxt:PublishSubject<String> = .init()
    var isLoading:BehaviorRelay<Bool> = .init(value: false)
    var imageData:BehaviorRelay<Data?> = .init(value: nil)
    var email:BehaviorRelay<String?> = .init(value: "")
    var fullName:BehaviorRelay<String> = .init(value: "")
    var imagePath:BehaviorRelay<String?> = .init(value: nil)
    
    init(createNewEmployee:Bool,employee:Employee?){
        self.createNewEmployee.accept(createNewEmployee)
        self.employeeToUpdate.accept(employee)
    }
    
    
    private func checkForFullName()->Bool{
        if fullName.value == "" {
            hasErrInTxt.onNext("Please Employee Full name is Requird")
            return false
        }
        return true
    }
    
    func createOreUpdateEmployee(){
        if checkForFullName() {
            
            if createNewEmployee.value {
                callAddEmplyeeFromLDB(name: fullName.value, email: email.value, image: imagePath.value)
            }else{
                callUpdateEmployeFormLDB(id: employeeToUpdate.value!.id, employee: Employee(id: employeeToUpdate.value!.id, fullName: fullName.value, email: email.value, image: imagePath.value))
            }
        }
    }
    private func callAddEmplyeeFromLDB(name:String,email:String?,image:String?){
        self.isLoading.accept(true)
        localDB.addEmployee(eFullName: name, eEmail: email, eImage: image){[weak self] (sucess,error) in
             guard let self else{return}
             self.isLoading.accept(false)
             if let sucess {
                 self.createdEmployeeSucess.onNext(sucess)
             }
             if let error {
                 self.hasErrInTxt.onNext(error.localizedDescription)
             }
         }
    }
    private func callUpdateEmployeFormLDB(id:Int64,employee:Employee){
        localDB.updateContact(eid: id, newEmployee: employee) {[weak self] sucess, error in
            guard let self else{return}
            self.isLoading.accept(false)
            if let sucess {
                self.createdEmployeeSucess.onNext(sucess)
            }
            if let error {
                self.hasErrInTxt.onNext(error.localizedDescription)
            }
        }
    }
}
