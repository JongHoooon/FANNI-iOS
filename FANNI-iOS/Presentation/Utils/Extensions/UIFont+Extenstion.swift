//
//  UIFont+Extenstion.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/12.
//

import UIKit

extension UIFont {
    
    enum PretendarWeight: String {
        case _100 = "PretendardVariable-Thin"
        case _200 = "PretendardVariable-ExtraLight"
        case _300 = "PretendardVariable-Light"
        case _400 = "PretendardVariable-Regular"
        case _500 = "PretendardVariable-Medium"
        case _600 = "PretendardVariable-SemiBold"
        case _700 = "PretendardVariable-Bold"
        case _800 = "PretendardVariable-ExtraBold"
        case _900 = "PretendardVariable-Black"
    }
    
    enum InterWeight: String {
        case _100 = "Inter"
        case _200 = "Inter_Thin"
        case _300 = "Inter_Extra-Light"
        case _400 = "Inter_Light"
        case _500 = "Inter_Medium"
        case _600 = "Inter_Semi-Bold"
        case _700 = "Inter_Bold"
        case _800 = "Inter_Extra-Bold"
        case _900 = "Inter_Black"
    }
    
    static func pretendar(weight: PretendarWeight, size: CGFloat) -> UIFont? {
        return UIFont(name: weight.rawValue, size: size)
    }
    
    static func cafe24Ssurround(size: CGFloat) -> UIFont? {
        return UIFont(name: "Cafe24Ssurround", size: size)
    }
    
    static func intert(weight: InterWeight, size: CGFloat) -> UIFont? {
        return UIFont(name: weight.rawValue, size: size)
    }
}

/*
 
 font 이름 출력하는 코드!
 
 UIFont.familyNames.sorted().forEach { familyName in
     print("*** \(familyName) ***")
     UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
         print("\(fontName)")
     }
     print("---------------------")
 }
 
 */
