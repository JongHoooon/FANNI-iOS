//
//  UIFont+Extenstion.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/12.
//

import UIKit

extension UIFont {
    
    enum PretendarStyle: String {
        case regular = "PretendardVariable-Regular"
        case thin = "PretendardVariable-Thin"
        case extraLight = "PretendardVariable-ExtraLight"
        case light = "PretendardVariable-Light"
        case medium = "PretendardVariable-Medium"
        case semiBold = "PretendardVariable-SemiBold"
        case bold = "PretendardVariable-Bold"
        case extraBold = "PretendardVariable-ExtraBold"
        case black = "PretendardVariable-Black"
    }
    
    static func pretendar(style: PretendarStyle, size: CGFloat) -> UIFont? {
        return UIFont(name: style.rawValue, size: size)
    }
    
    static func cafe24Ssurround(size: CGFloat) -> UIFont? {
        return UIFont(name: "Cafe24Ssurround", size: size)
    }
}
