//
//  UIButton+UIStackView+UILabel_Ext.swift
//
//

import UIKit


extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1,textColor:UIColor? = nil,textAlign:NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        guard let color = textColor else{return}
        self.textColor = color
        self.textAlignment = textAlign
    }
}
extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
