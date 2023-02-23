//
//  Reactive+Extension.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/14.
//

import UIKit
import RxSwift

// MARK: - Agreement View

extension Reactive where Base: UIButton {
    var isCheck: Binder<Bool> {
        return Binder(self.base) { button, bool in
            switch bool {
            case true: button.setImage(UIImage(named: "checkBox1"), for: .normal)
            case false: button.setImage(UIImage(named: "checkBox0"), for: .normal)
            }
        }
    }
}

extension Reactive where Base: UIButton {
    var isEnable: Binder<Bool> {
        return Binder(self.base) { button, bool in
            switch bool {
            case true:
                button.isEnabled = true
                button.backgroundColor = .main1
            case false:
                button.backgroundColor = .deactiveButton
                button.isEnabled = false
            }
        }
    }
}

// MARK: - OnboardingFirst View

extension Reactive where Base: UITextField {
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { textField, color in
            textField.layer.borderColor = color?.cgColor
        }
    }
}

extension Reactive where Base: UITextField {
    var isHiddenAnimatioin: Binder<Bool> {
        return Binder(self.base) { textField, bool in
            switch bool {
            case true:
                UIView.animate(withDuration: 0.5) {
                    // textField.isHidden = bool
                    textField.alpha = 0
                }
                textField.endEditing(true)
                textField.text = ""
            case false:
                textField.isHidden = bool
                UIView.animate(withDuration: 0.5) {
                    textField.alpha = 1
                }
            }
        }
    }
}


extension Reactive where Base: UITextField {
    var becomeResponder: Binder<Bool> {
        return Binder(self.base) { textField, bool in
            switch bool {
            case true:
                textField.becomeFirstResponder()
            case false:
                textField.resignFirstResponder()
            }
        }
    }
}
