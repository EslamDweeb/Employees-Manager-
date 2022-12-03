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

//enum VCType{
//    case create
//    case update
//}
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
    
    
    var imageVedioPicker:ImageVideoPicker!
    
    //MARK: - Controller lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageVedioPicker = .init(presentationController: self, delegate: self)
        bindTextField()
        bindBackBtn()
        bindCreateOrUpdateBtn()
        bindUploadImageBtn()
    }
    override func bind(viewModel: AddOrUpdateEmployeeViewModel) {
        viewModel.createNewEmployee.subscribe(onNext: { (sucess) in
            if sucess {
                self.setupAddorUpdateButton(title: ViewTitles.createEmployee.rawValue)
            } else {
                self.setupAddorUpdateButton(title: ViewTitles.updateEmployee.rawValue)
            }
        }).disposed(by: disposeBag)
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
        
        viewModel.createdEmployeeSucess.subscribe {[weak self] msg in
            guard let self = self else{return}
            guard let msg = msg.element else{return}
            self.createAlert(title: "Success",erroMessage: msg)
        } .disposed(by: disposeBag)
        
        
        viewModel.employeeToUpdate.subscribe{[weak self] employee in
            guard let self = self else{return}
            guard let employee = employee.element else{return}
            if let employee {
                self.employeeEmailTxtField.text = employee.email
                self.employeeFullNameTxtField.text = employee.fullName
                self.employeeImageView.sd_setImage(with: URL(string: employee.image ?? ""))
            }
           
        }.disposed(by: disposeBag)
    }
    //MARK: - setup UI Components
    private func setupAddorUpdateButton(title:String){
        createOrUpdateBtn.titleColor = .white
        createOrUpdateBtn.title = title
    }


    //MARK: - helper functions
    private func bindTextField(){
        employeeFullNameTxtField.rx.text.orEmpty.bind(to: viewModel.fullName).disposed(by: disposeBag)
        employeeEmailTxtField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
    }
    private func bindBackBtn(){
        backBtn.rx.tap.subscribe {[weak self] _ in
            guard let self = self else{return}
            self.PopToOldPage()
        }.disposed(by: disposeBag)
    }
    private func bindCreateOrUpdateBtn(){
        createOrUpdateBtn.rx.tap.subscribe {[weak self] _ in
            guard let self = self else{return}
            self.viewModel.createOreUpdateEmployee()
        }.disposed(by: disposeBag)
    }
    private func bindUploadImageBtn(){
        uploadPhotoBtn.rx.tap.subscribe {[weak self] _ in
            guard let self = self else{return}
            self.imageVedioPicker.present(from: self.uploadPhotoBtn!,addVideo: false)
        }.disposed(by: disposeBag)
    }
}
extension AddOrUpdateEmployeeVC:ImageVideoPickerPickerDelegate {
    func didSelect(url: URL?) {
        guard let url = url else{return}
        print(url)
    }
    
    func didSelect(image: UIImage?,path:URL?) {
        guard let image = image else{return}
        print(path?.absoluteString)
        let data = image.jpegData(compressionQuality: 1)
        
        DispatchQueue.main.async {
            self.employeeImageView.image = UIImage(data: data!)
        }
       // viewModel.ImageData.accept(data)
        viewModel.imagePath.accept(path?.absoluteString)
    }
}
