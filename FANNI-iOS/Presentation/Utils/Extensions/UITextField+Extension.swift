//
//  UITextField+Extension.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/24.
//

import UIKit

extension UITextField {
    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation = CABasicAnimation(keyPath: "buttonBorderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "buttonBorderColor")
        layer.borderColor = toColor.cgColor
    }
}
