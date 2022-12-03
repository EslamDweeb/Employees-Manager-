//
//  EmptyStateBG.swift
//  Employees Manager
//
//

import UIKit

class EmptyStatBG:UIView {
    
    lazy var lbl = UILabel(text: "Remainder is empty,please set remainder", font: .systemFont(ofSize: 15  ,weight: .semibold),numberOfLines: 0,textColor: .darkGray, textAlign: .center)
  //  var title:String
    
    init(title:String) {
        super.init(frame: .zero)
        backgroundColor = .white
        lbl.text = title
        addSubview(lbl)
        lbl.centerYInSuperview()
        lbl.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        lbl.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
