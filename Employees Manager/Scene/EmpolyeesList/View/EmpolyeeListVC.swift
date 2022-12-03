//
//  EmpolyeeListVC.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import UIKit

class EmpolyeeListVC: BaseWireFrame<EmployeesListVCViewModel> {

    @IBOutlet weak var addNewEmployeeBtn: BaseButton!
    @IBOutlet weak var employeeTableView: UITableView!
    
    //MARK: - Controller lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddNewEmpolyeeButton()
        setupTableView()
    }

    override func bind(viewModel: EmployeesListVCViewModel) {
        print("here")
    }
    
    
    //MARK: - setup UI Components
    private func setupAddNewEmpolyeeButton(){
        addNewEmployeeBtn.setTitle(ViewTitles.addNewEmployee.rawValue, for: .normal)
    }
    private func setupTableView(){
        employeeTableView.registerCellNib(cellClass: EmployeeTableCell.self)
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        employeeTableView.separatorStyle = .none
    }
}

extension EmpolyeeListVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableCell.getIdentifier(), for: indexPath) as! EmployeeTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
