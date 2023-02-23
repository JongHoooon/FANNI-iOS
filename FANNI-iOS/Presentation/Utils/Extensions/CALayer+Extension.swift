//
//  CALayer+Extension.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/24.
//

import QuartzCore
import UIKit

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}

struct BorderOptions: OptionSet {
    let rawValue: Int

    static let top = BorderOptions(rawValue: 1 << 0)
    static let left = BorderOptions(rawValue: 1 << 1)
    static let bottom = BorderOptions(rawValue: 1 << 2)
    static let right = BorderOptions(rawValue: 1 << 3)
    
    static let horizontal: BorderOptions = [.left, .right]
    static let vertical: BorderOptions = [.top, .bottom]
}

extension UIView {
    func addBorder(
        toSide options: BorderOptions,
        color: UIColor,
        borderWidth width: CGFloat
    ) {
        // options에 .top이 포함되어있는지 확인
        if options.contains(.top) {
            // 이미 해당 사이드에 경계선이 있는지 확인하고, 있으면 제거
            if let exist = layer.sublayers?.first(where: { $0.name == "top" }) {
                exist.removeFromSuperlayer()
            }
            let border: CALayer = CALayer()
            border.borderColor = color.cgColor
            border.name = "top"
            // 현재 UIView의 frame 정보를 통해 경계선이 그려질 레이어의 영역을 지정
            border.frame = CGRect(
                x: 0, y: 0,
                width: frame.size.width, height: width)
            border.borderWidth = width
            // 현재 그려지고 있는 UIView의 layer의 sublayer중에 가장 앞으로 추가해줌
            let index = layer.sublayers?.count ?? 0
            layer.insertSublayer(border, at: UInt32(index))
        }
    }
}
