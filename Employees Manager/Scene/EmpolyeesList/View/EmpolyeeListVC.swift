//
//  EmpolyeeListVC.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import UIKit
import SDWebImage

class EmpolyeeListVC: BaseWireFrame<EmployeesListVCViewModel> {

    @IBOutlet weak var addNewEmployeeBtn: BaseButton!
    @IBOutlet weak var employeeTableView: UITableView!
    
    //MARK: - Controller lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddNewEmpolyeeButton()
        setupTableView()
       // viewModel.viewDidLod()
        bindCreateEmployeeBtn()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLod()
    }
    override func bind(viewModel: EmployeesListVCViewModel) {
        print("here")
        viewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
        
        
        viewModel.hasErrInTxt.subscribe {[weak self] msg in
            guard let self = self else{return}
            guard let msg = msg.element else{return}
            self.createAlert(erroMessage: msg)
        } .disposed(by: disposeBag)
        
        viewModel.employeesArr.subscribe {[weak self] employees in
            guard let self else{return}
            guard let employees = employees.element else{return}
            if employees.isEmpty {
                self.employeeTableView.backgroundView = EmptyStatBG(title: "No Employees Data please try to add one")
            }else{
                self.employeeTableView.backgroundView = nil
                print(employees)
            }
        }.disposed(by: disposeBag)
    }
    
    
    //MARK: - setup UI Components
    private func setupAddNewEmpolyeeButton(){
        addNewEmployeeBtn.setTitle(ViewTitles.addNewEmployee.rawValue, for: .normal)
    }
    private func setupTableView(){
        employeeTableView.registerCellNib(cellClass: EmployeeTableCell.self)
        employeeTableView.rx.setDelegate(self).disposed(by: disposeBag)

        employeeTableView.separatorStyle = .none
        
        viewModel.employeesArr.asObservable().bind(to: employeeTableView.rx.items(cellIdentifier: EmployeeTableCell.getIdentifier(),cellType: EmployeeTableCell.self)){[weak self] index,model,cell in
            guard let self else{return}
            cell.employeeNameLbl.text = model.fullName
            cell.employeeEmailLbl.text = model.email
            if model.image != nil{
                cell.employeeImageView.sd_setImage(with: URL(string: model.image ?? ""))
            }
            cell.deleteBtnTapped = {
                self.viewModel.deleteEmployee(index)
            }
            cell.editBtnTapped = {
                self.coordinator.main.navigate(to: .createOrUpdateEmployee(createEmployee: false, employee: model))
            }
        }.disposed(by: disposeBag)
        
    }
    
    
    //MARK: - helper functions
    private func bindCreateEmployeeBtn(){
        addNewEmployeeBtn.rx.tap.subscribe {[weak self] _ in
            guard let self = self else{return}
            self.coordinator.main.navigate(to: .createOrUpdateEmployee(createEmployee: true, employee: nil))
        }.disposed(by: disposeBag)
    }
}

extension EmpolyeeListVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
