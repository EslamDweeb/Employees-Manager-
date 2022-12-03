//
//  AddOrUpdateEmployeeVC.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import UIKit
import SearchTextField
import RxSwift
import RxCocoa

class AddOrUpdateEmployeeVC: BaseWireFrame<AddOrUpdateEmployeeViewModel> {

    @IBOutlet weak var createOrUpdateTitleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var uploadPhotoBtn: UIButton!
    @IBOutlet weak var employeeFullNameTxtField: UITextField!
    @IBOutlet weak var employeeEmailTxtField: UITextField!
    @IBOutlet weak var skillAutoCompleteTxtField: SearchTextField!
    @IBOutlet weak var skillsCollectionView: UICollectionView!
    @IBOutlet weak var createOrUpdateBtn: BaseButton!
    @IBOutlet weak var employeeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func bind(viewModel: AddOrUpdateEmployeeViewModel) {
        print("here")
    }
}
