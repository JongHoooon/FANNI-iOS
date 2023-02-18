//
//  UIColor+Extension.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/12.
//

import UIKit

extension UIColor {
    
    /// main1: #FBA37D (연한색)
    static let main1 = UIColor(rgb: 0xFBA37D)
    
    /// main1: #F47155 (진한색)
    static let main2 = UIColor(rgb: 0xF47155)
    
    /// sub1: #DE4E45
    static let sub1 = UIColor(rgb: 0xDE4E45)
    
    /// sub2: #E8CDB8
    static let sub2 = UIColor(rgb: 0xE8CDB8)
    
    /// deactive button color: #F7D4C5
    static let deactiveButton = UIColor(rgb: 0xF7D4C5)
    
    /// deactive textField color: #E5E5EC
    static let deactiveTextField = UIColor(rgb: 0xE5E5EC)
    
    /// Branding Font Color
    struct Font {
        
        /// background: #111111 (.label)
        static let font1: UIColor = .label
        
        /// background: #505050
        static let font2: UIColor = UIColor(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor(rgb: 0x505050)
            } else {
                return .secondaryLabel
            }
        })
        
        /// background: #767676
        static let font3: UIColor = UIColor(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor(rgb: 0x767676)
            } else {
                return .tertiaryLabel
            }
        })
        
        /// background: #999999
        static let font4: UIColor = UIColor(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor(rgb: 0x999999)
            } else {
                return .quaternaryLabel
            }
        })
    }
    
    /// Branding Backgroun Color
    struct Background {
        
        /// systemBackground
        static let background1: UIColor = .systemBackground
        
        /// background: #FBF7F7
        static let background2: UIColor = UIColor(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor(rgb: 0xFBF7F7)
            } else {
                return .systemGray6
            }
        })
        
        /// background: #F5F1F1
        static let background3: UIColor = UIColor(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor(rgb: 0xF5F1F1)
            } else {
                return .systemGray5
            }
        })
        
        /// background: #E9E4E4
        static let background4: UIColor = UIColor(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor(rgb: 0xE9E4E4)
            } else {
                return .systemGray4
            }
        })
    }
    
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
