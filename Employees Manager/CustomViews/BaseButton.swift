//
//  BaseButton.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import UIKit

class BaseButton:UIButton {
    var titleColor:UIColor? {
        didSet {
            guard let titleColor else{return}
            setTitleColor(titleColor, for: .normal)
        }
    }
    var titleFont:UIFont? {
        didSet {
            guard let titleFont else{return}
            titleLabel?.font = titleFont
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(){
        backgroundColor = UIColor(named: ColorName.prim.rawValue)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
}
