//
//  UIColor+Extension.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/12.
//

import UIKit

extension UIColor {
    
    static let main1 = UIColor(rgb: 0xFBA37D)
    static let main2 = UIColor(rgb: 0xF47155)
    static let sub1 = UIColor(rgb: 0xDE4E45)
    static let sub2 = UIColor(rgb: 0xE8CDB8)
    
    static let kakaoYellow = UIColor(rgb: 0xFEE500)
    
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    /// HEX 변환
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    /// HEX 변환 with alpha
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}
