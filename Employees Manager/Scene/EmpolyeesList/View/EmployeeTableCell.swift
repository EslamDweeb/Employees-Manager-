//
//  EmployeeTableCell.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import UIKit

class EmployeeTableCell: UITableViewCell {

    @IBOutlet weak var employeeNameLbl: UILabel!
    @IBOutlet weak var employeeEmailLbl: UILabel!
    @IBOutlet weak var editBtn: BaseButton!
    @IBOutlet weak var deleteBtn: BaseButton!
    @IBOutlet weak var employeeImageView: UIImageView!
    
    
    var editBtnTapped:(()->Void)?
    var deleteBtnTapped:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIComponents()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupUIComponents(){
        editBtn.setTitle(ViewTitles.edit.rawValue, for: .normal)
        deleteBtn.setTitle(ViewTitles.delete.rawValue, for: .normal)
        deleteBtn.backgroundColor = .red
        editBtn.titleColor = .white
        deleteBtn.titleColor = .white
        deleteBtn.titleFont = .systemFont(ofSize: 8, weight: .regular)
        editBtn.titleFont    = .systemFont(ofSize: 8, weight: .regular)

        employeeImageView.cornerRadius = 20
        employeeImageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
    }
    @IBAction func editeBtnTaappedAction(_ sender: Any) {
        self.editBtnTapped?()
    }
    @IBAction func deleteBtnTapeedAction(_ sender: Any) {
        self.deleteBtnTapped?()
    }
}
