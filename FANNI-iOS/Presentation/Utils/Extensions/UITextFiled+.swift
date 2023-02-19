//
//  UITextFiled+.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/19.
//

import UIKit

class CustomTextField: UITextField {
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: frame.width - 16 - 20, y: frame.height / 2 - 10, width: 20, height: 20)
    }
    
}
