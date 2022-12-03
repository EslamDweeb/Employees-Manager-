//
//  BaseWireFrame.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//


import UIKit
import RxCocoa
import RxSwift

protocol ViewModel {
    var hasErrInTxt:PublishSubject<String> {get set}
    var isLoading:BehaviorRelay<Bool> {get set}
}
class BaseWireFrame<T:ViewModel>:UIViewController{
    
    let viewModel:T
    let coordinator:Coordinator
    
    lazy var disposeBag: DisposeBag = {
        return .init()
    }()

    //MARK:- Controller Init

    init(viewModel:T,coordinator:Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
    }
    //MARK:- Helper functions
    func bind(viewModel:T){
        fatalError("Please override bind function")
    }
    
}
