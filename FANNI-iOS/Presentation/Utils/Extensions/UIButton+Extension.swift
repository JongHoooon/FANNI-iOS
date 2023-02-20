//
//  UIButton+Extension.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/20.
//

import UIKit

extension UIButton {
    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }
}
